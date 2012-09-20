#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <termios.h>
#include <time.h>
#include "uart.h"
#include "stcdude.h"

unsigned short reverse_bytes(unsigned short value)
{
  return (unsigned short)((value & 0xFFU) << 8 | (value & 0xFF00U) >> 8);
}

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

char* fetch_packet(int fd) {
	char tmp[8];
	do {
		read(fd,tmp,1);
	} while (tmp[0] != START_BYTE0);
	
	/* We got the start marker, yappee! */
	read(fd, &tmp[1], 4);
	if (tmp[1] != START_BYTE1)
		printf("Warning! Second byte looks weird: 0x%hhx vs 0xhhx\n", tmp[1], START_BYTE1);
	if (tmp[1] != MCU2HOST)
		printf("Warning! Direction byte incorrect: 0x%hhx vs 0xhhx\n", tmp[2], MCU2HOST);      
	unsigned short len; 
	len |= tmp[3]<<8;
	len |= tmp[4];
	printf("Packet is expected to be %hd bytes long\n", len);
	char* data = malloc((int)len+3);
	read(fd,data,(int)len+3);
	unsigned short sum = byte_sum(data,len);
	unsigned short ssum = * (unsigned short *) &data[(int) len];
	ssum = reverse_bytes(ssum);
	if (ssum!=sum)
		printf("Checksum error, dropping packet!\n");
}
