#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <termios.h>
#include <time.h>
#include "uart.h"


#define MCU2HOST 0x68
#define HOST2MCU 0x6A


unsigned short byte_sum(char* payload, int sz) {
	int i;
	unsigned short sum=0;
	for (i=0; i<sz; i++)
		sum+=payload[sz];
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
	printf("-----8<----- \n ");
	for (i=0; i<len; i++) {
		printf(" 0x%hhx ", packet[i]);
		if (0 == (i % 8)) printf("\n"); 
	}
	printf("\n-----8<----- \n ");
}
