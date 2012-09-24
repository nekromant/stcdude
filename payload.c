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


char* pack_paylod(char* payload, int len, char* dir) {
	char* packet = malloc(len+8);
	packet[0]=0x46;
	packet[1]=0xB9;
	packet[2]=dir;
	unsigned short llen = len+2; /* Account for dir byte and stop byte */
	/* 8051 is BIG endian */
	packet[3]=(char) ((llen >>8) & 0xff);
	packet[4]=(char) (llen & 0xff);
	memcpy(&packet[5], payload, len);
	unsigned short sum = byte_sum(payload, len);
	char* csum = packet[5+len];
	csum[0] = (char) ((sum >>8) & 0xff);
	csum[1] = (char) ((sum) & 0xff);
	csum[2] = 0x16; 
	return packet;
}

void dump_packet(char* packet, int len) {
	int i; 
	printf("-----8<----- ");
	for (i=0; i<len; i++) {
		if (0 == (i % 8)) printf("\n"); 
		printf(" 0x%2hhx ", packet[i]);
		
	}
	printf("\n-----8<----- \n ");
}

struct packet* fetch_packet(int fd) {
	unsigned char tmp[128];
	do {
		read(fd,tmp,1);
		//	printf("!\n");
	} while (tmp[0] != START_BYTE0);
	
	/* We got the start marker, yappee! */
	block_read(fd, &tmp[1], 4);
	
	if (tmp[1] != START_BYTE1) {
		printf("Warning! Second byte looks weird: 0x%hhx vs 0x%hhx\n", tmp[1], START_BYTE1);
	}

	if (tmp[2] != MCU2HOST){
		printf("Warning! Direction byte incorrect: 0x%hhx vs 0x%hhx\n", tmp[2], MCU2HOST);      }
	
	unsigned short len=0; 
	len |= (unsigned short) tmp[3]<<8;
	len |= (unsigned short) tmp[4];
	printf("Packet is expected to be %hd bytes long\n", len);
	struct packet *pck = malloc(sizeof(struct packet));
	char* data = malloc((int)len+3);
	pck->data = data;
	pck->size = len;
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
		fflush(stdout);
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

struct mcuinfo* parse_info_packet(lua_State* L, struct packet* pck) {
	struct info_packet *inf = pck->data;
	printf("MCU magic: %hhx %hhx", inf->mcuid[0], inf->mcuid[1]);
	struct mcuinfo *minf = mcudb_query_magic(L,inf->mcuid);
	print_mcuinfo(minf);
	/* TODO: Calculate the frequency, figure out other bytes */

}
