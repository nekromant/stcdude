#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <termios.h>
#include <time.h>
#include <sys/time.h>
#include <pthread.h> 
#include <errno.h>

#include "uart.h"
#include "lualib.h"
#include "lauxlib.h"
#include "stcdude.h"

unsigned short reverse_bytes(unsigned short value)
{
return (unsigned short)((value & 0xFFU) << 8 | (value & 0xFF00U) >> 8);
}

unsigned short byte_sum(unsigned char* payload, int sz) {
int i;
unsigned short sum=0;
for (i=0; i<sz; i++)
	sum+=payload[i];
return sum;
}


char* pack_payload(char* payload, int len, char dir) {
	char* packet = malloc(PACKED_SIZE(len));
	packet[0]=0x46;
	packet[1]=0xB9;
	packet[2]=dir;
	unsigned short llen = len+6; /* Account for dir byte and stop byte */
	/* 8051 is BIG endian */
	packet[3]=(char) ((llen >>8) & 0xff);
	packet[4]=(char) (llen & 0xff);
	memcpy(&packet[5], payload, len);
	unsigned short sum = byte_sum(&packet[2], len+3);
	char* csum = &packet[5+len];
	csum[0] = (char) ((sum >> 8 ) & 0xff);
	csum[1] = (char) ((sum) & 0xff);
	csum[2] = 0x16; 
	return packet;
}

void dump_packet(char* packet, int len) {
	int i; 
	printf("-----8<----- ");
	for (i=0; i<len; i++) {
		if (0 == (i % 8)) printf("\n"); 
		printf("%2hhX ", packet[i]);
	}
	printf("\n-----8<----- \n ");
}

struct packet* fetch_packet(int fd) {
	unsigned char tmp[128];
	do {
		read(fd,tmp,1);
	} while (tmp[0] != START_BYTE0);
	
	/* We got the start marker, yappee! */
	block_read(fd, &tmp[1], 4);
	
	if (tmp[1] != START_BYTE1) {
		printf("Warning! Second byte looks weird: 0x%hhx vs 0x%x\n",
			tmp[1], START_BYTE1);
	}

	if (tmp[2] != MCU2HOST){
		printf("Warning! Direction byte incorrect: 0x%hhx vs 0x%x\n",
			tmp[2], MCU2HOST);
	}
	
	unsigned short len=0; 
	len |= (unsigned short) tmp[3]<<8;
	len |= (unsigned short) tmp[4];
	struct packet *pck = malloc(sizeof(struct packet));
	char* data = malloc((int)len+3);
	pck->payload = &data[3];
	pck->data = data;
	pck->size = len-6;
	memcpy(data,&tmp[2],3);
	block_read(fd,&data[3],(int)len-3);
	unsigned short sum = byte_sum(data, len-3);
	unsigned short ssum = * (unsigned short *) &data[(int) len-3];
	ssum = reverse_bytes(ssum);
        do_dump_packet(data, len);
	if (ssum!=sum) {
		printf("Checksum error, dropping packet!\n");
		free(data);
		free(pck);
		return 0;
	}
	return pck;
}


struct pulsedata {
	pthread_t th;
	int fd;
	int delay;
	int running;
	char* data;
	size_t dtsz;
};


void* pulse_thread(void* ptr) {
	struct pulsedata* pdata = ptr;
	while (pdata->running)
	{
		write(pdata->fd, pdata->data, pdata->dtsz);
		usleep(pdata->delay);
	}
	pthread_exit(NULL);
};

static struct pulsedata pdata; 

void start_pulsing(int fd, int delay, char* data, size_t datasz) {
	pdata.fd = fd;
	pdata.delay = delay;
	pdata.data = data;
	pdata.dtsz = datasz;
	pdata.running = 1;
	pthread_create(&pdata.th, NULL, pulse_thread, &pdata);
}


void stop_pulsing() {
	pdata.running=0;
	pthread_join(pdata.th, NULL);
}


typedef struct info_packet {
	unsigned char dir;
	unsigned short len;
	unsigned char typebyte; //??
	unsigned short freq_samples[8];
	unsigned char ldr_vnumber;
	unsigned char ldr_vchar;
	unsigned char nilbyte; 
	unsigned char mcuid[2];
	
} __attribute__ ((packed));


#define ALPHA 580706.8955206028
struct mcuinfo* minf;
struct mcuinfo* parse_info_packet(lua_State* L, struct packet* pck, int baudrate) {
	struct info_packet *inf = pck->data;
	minf = mcudb_query_magic(L,inf->mcuid);
	print_mcuinfo(minf);
	printf("MCU Options information:\n");
	int i;
	for (i=0; i<8;i++) 
		inf->freq_samples[i] = reverse_bytes(inf->freq_samples[i]);
	float avg = 0;
	for (i=0; i<8;i++) avg+= (float) (inf->freq_samples[i]+1);
	avg = avg / 8;;
	
	/* 
	 *
	 *  Just a short note of how this was cracked and some fun calculus. 
	 *
	 *  Several (n) bits at a known baudrate are measured by the mcu
	 *  8 times. The timer has a prescaler (1 or 12 by spec). So, let's 
	 *  throw up a small equation with a few parameters. 
	 *
	 *
	 *                                     n
	 *  T * average counter value   =  -------------
	 *                                  baudrate
	 *
	 *  Where T is the peiod of the counter clock. Since that is prescaled:
	 *
	 *                 1            prescaler
	 *   T =   ---------------- =  ------------
	 *          F / prescaler           F
	 *
	 *  prescaler                  n
	 *  ----------  =  ---------------------------------------------
	 *     F             baudrate * averge counter value
	 * 
	 *  So, the MCU clock period is
	 * 
	 *                     n * 1000000         
	 *  Tc =   -----------------------------------------
	 *         baudrate * avg counter value * prescaler
	 * 
	 * 
	 *  So we ave a few parameters to figure out:
	 *  n and prescaler. 
	 *  We can call this 'alpha' coefficient and determine value experimentally. 
	 *  But this will give us some rounding error. 
	 *  Luckily I noticed, that at 12M quartz the counter value is roughly the 
	 *  7 bit HIGH period in uS. 
	 *  That effectively gives us the n = 7
	 *  And having a look at the datasheet tells us that the prescaler for the timer
	 *  can be either 1 or 12. That gives us the prescaler = 12.
	 *  
	 *  Once done, the mcu clock (and hence the crystal frequency) is: 
	 *
	 *            1
	 *  => F = -------
	 *            Tc
	 * 
	 *  However that gave a small deviation from what the STC ISP tool says. 
	 *  So let's do a little doublechecking:
	 *
	 *  STC ISP Tool reports 12.03912 Mhz
	 *  Logical Analyzer dump reports:
	 *
	 *  0x16b 0x16b 0x16b 0x16b 0x16b 0x16b 0x16b 0x16c
	 *
	 *  Now let's convert these to float and take the average
	 *
	 *  float avg = ( (float) (0x16c * 7) + (float) 0x16d )/ 8.0;
	 *  (Remember the old trick with +1 for all the timer values ? )
	 *
	 *  And that's 364.125000
	 *
	 *     1             n * 1000000
	 *  ----------  = -----------------------
	 *  12.03912        19200 * 364.125 * 12
	 *
	 * That effectively gives us n as 6.968482746247234
	 * Which is quite close to 7. 
	 * With a ~0.03 deviation. While now I used 6.97 as a 
	 * coefficient to match the behavior of the STC ISP tool, but 
	 * you must understand, that the error here is mostly composed of:
	 *
	 * The deviation of your serial clock 
	 * In case of pl2303 - it might be the baudrate prescaler deviation 
	 * and quartz crystal frequency deviation. The one that pl2303 uses.
	 *
	 * We can get better results here by using a high-precision crystal with
	 * pl2303 and throwing up a good set of measurements. 
	 * But honestly, do you need such a precision ?
	 * 
	 */

	float freq = (((float) baudrate * avg * 12 ) / (6.968482746247234 * 1000000) );
	printf("MCU Clock: %f Mhz (%f raw)\n", freq, avg);
	lua_pushnumber(L,freq);
	lua_setglobal(L,"mcu_clock");
	printf("Bootloader version: %x.%x%c\n",
		(inf->ldr_vnumber & 0xf0) >> 4,
		inf->ldr_vnumber & 0xf,
		inf->ldr_vchar );
	inf->len = reverse_bytes(inf->len);
/*
	printf("Dumping interesting bytes...\n");
	printf("---8<---\n");

	char* data = &inf->nilbyte;

	for (i=0;i<57-(8*3);i++) 
		fprintf(stderr, "%hhx \n", data[i]);
	printf("---8<---");
*/
	return minf;
}


void free_packet(struct packet* pck) {
	free(pck->data);
	free(pck);
}
