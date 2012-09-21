#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <termios.h>
#include <time.h>
#include "uart.h"


#define ARRAY_SIZE(arr) (sizeof(arr)/sizeof(arr[0]))

/* Initial effort to send the captured packet back to the software. While now failing hard */

void pulse(int fd, int n) {
	/* Send out 2 x 0x7f every ~15 ms */ 
	char token[] = {0x7f, 0x7f};
	while(n--)
	{
		write(fd,token,ARRAY_SIZE(token));
		usleep(13000);
	}
	
}

//copypaste from an OpenGL app, actually
static struct timeval		tv, tv0;
static float			time_counter, last_frame_time_counter, dt, prev_time, fps, elapsed;
void frametimer_init()
{
    gettimeofday(&tv0, NULL);
//frame=1;
//frames_per_fps = 30;
}

float frametimer_since(float offset)
{
    return elapsed-offset;
}

void frametimer_update()
{
    last_frame_time_counter = time_counter;
    gettimeofday(&tv, NULL);
    time_counter = (float)(tv.tv_sec-tv0.tv_sec) + 0.000001*((float)(tv.tv_usec-tv0.tv_usec));
    dt = time_counter - last_frame_time_counter;
    elapsed+=dt;
}

unsigned short byte_sum(char* payload, int sz) {
	int i;
	unsigned short sum=0;
	for (i=0; i<sz; i++)
		sum+=payload[sz];
	return sum;
}


char* pack_paylod(char* payload, int len) {
	char* packet = malloc(len+8);
	packet[0]=0x46;
	packet[1]=0xB9;
	packet[2]=0x68;
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


void wait_mark(int fd, int n) {
	char token;;
	int i=0;
	float a=0.0;
	float delta;
	while(1) {
		frametimer_update();
		n--;
		read(fd,&token,1);
		delta = frametimer_since(0)-a;
		//printf("%f %f %d \n" ,a, delta, n);
		a = frametimer_since(0);
		if ((n<0) && (delta<0.01)) return;
	}
}


int main(int argc, char* argv[])
{
printf("create\n");
	struct uart_settings_t* us = str_to_uart_settings(argv[1]);
	us->fd = uart_init(us);
	printf("fs is %d\n",us->fd);
	printf("Packet len is %x/%hhx\n", ARRAY_SIZE(packet)-2, packet[4]);
	unsigned short nc = crc16(&packet[2],(unsigned short)ARRAY_SIZE(packet)-5);
	char* crc = &packet[ARRAY_SIZE(packet)-3];
	printf("%hx | %hhx %hhx       \n", nc, crc[0], crc[1]);
	exit(2);
	bruteforce_poly(packet,ARRAY_SIZE(packet));
//	pulse(us->fd,100000);

	frametimer_init();
	wait_mark(us->fd,5);
	usleep(100);
	int n;
	printf("sending %d bytes\n",ARRAY_SIZE(packet));
	write(us->fd, &packet[0], ARRAY_SIZE(packet));
	printf ("%d bytes written\n", n);
	perror("err is: ");
//*/
	
}
