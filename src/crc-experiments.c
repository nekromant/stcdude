#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <termios.h>
#include <time.h>
#include "uart.h"


#define ARRAY_SIZE(arr) (sizeof(arr)/sizeof(arr[0]))

unsignd short POLY=0
unsigned short _crc16(const unsigned char *buf, int sz)
{
        unsigned short crc = 0;
        while (--sz >= 0)
        {
                int i;
                crc ^= (unsigned short) *buf++ << 8;
                for (i = 0; i < 8; i++)
                        if (crc & 0x8000)
                                crc = crc << 1 ^ 1021;
                else
                        crc <<= 1;
        }
        return crc;
}


char packet[] = {
	0x46,
	0xb9,
	0x68,
	0x00,
	0x07,
	0x8f,
	0x00,
	0xfe,
	0x16
};

void bruteforce_poly(char* data, int sz)
{
	char* crc = &data[sz-3];
	short crc_a = crc[0]|crc[1]<<8;
	short crc_b = crc[1]|crc[0]<<8;
	crc[0]=0xff;
	crc[1]=0xff;
	printf("Expecting crc: %hx or %hx\n",crc_a,crc_b);
        POLY=1;
	do { 
		unsigned short nc = _crc16(data,(unsigned short)sz-3);
		printf("%hx       \r", POLY);
		fflush(stdout);
		if ((nc == crc_a) || (nc == crc_b))
		{
			printf("Suggesting POLY %hx [ %hx ]\n", POLY, nc);
		}
		POLY++;
	} while (POLY!=0xffff);

	printf("...done");
}

int main()
{
	unsigned short n = _crc16(&packet,1);
        printf("%hx\n",n);
}
