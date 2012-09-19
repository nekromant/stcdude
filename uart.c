#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/resource.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/epoll.h>
#include <fcntl.h>
#include <termios.h>
#include <stdio.h>
#define _POSIX_SOURCE 1 /* POSIX compliant source */
#include <errno.h>
#include <string.h>
#include "uart.h"

//tag:/dev/ttyUSB0:115200:8:n:1\n
//#define set_prop(key,value) if (t)
#define MAPSPEED(speed) case speed: s->cfl|=B##speed; break;
#define MAPBITS(bits) case bits: s->cfl|=CS##bits; break;
#define FAULT(code, text, ...)			\
	default:\
	printf("\r");\
	fprintf(stderr, text, __VA_ARGS__);	\
			exit(code);

struct uart_settings_t* str_to_uart_settings(char* str) {
	struct uart_settings_t* s = calloc(1,sizeof(struct uart_settings_t));
	char* t = strtok(str, ":");
	if (t) s->tag=t;
	t = strtok(NULL, ":");
	if (t) s->port=t;
	t = strtok(NULL, ":");
	printf("Tag: %s at port %s\n", s->tag, s->port);
	int speed;
	if (t) {
		sscanf(t, "%d", &speed);
		printf("Running at %d baud,", speed);
		// cat /usr/include/bits/termios.h |grep define|grep " B"
		switch(speed) {
			MAPSPEED(230400);
			MAPSPEED(115200);
			MAPSPEED(57600);
			MAPSPEED(38400);
			MAPSPEED(19200);
			MAPSPEED(9600);
			MAPSPEED(4800);
			MAPSPEED(2400);
			MAPSPEED(1200);
			MAPSPEED(300);
			FAULT(1,"The requested speed (%d) doesn't seem to be valid.\n", speed);
		}
	}
	t = strtok(NULL, ":");
	int bits=0;
	if (t) {
		sscanf(t, "%d", &bits);
		printf(" %d data bits,", bits);
		switch(bits) {
			MAPBITS(5);
			MAPBITS(6);
			MAPBITS(7);
			MAPBITS(8);
			FAULT(1,"The requested data bit count (%d) doesn't seem to be valid.\n", bits);
		}
	}
	t = strtok(NULL, ":");
	if (t) {
		if (strcmp(t,"o")==0) {
			//odd
			printf(" odd parity,");;
			s->cfl|=PARENB|PARODD;
		} else if (strcmp(t,"e")==0) {
			//even
			printf(" even parity,");;
			s->cfl|=PARENB;
		} else {
			printf(" no parity,");
		}
	}

	t = strtok(NULL, ":");
	if (t && *t=='2') {
		s->ofl|=CSTOPB;
		printf(" 2 stop bits\n");
	} else {
		printf(" 1 stop bit\n");
	}
	return s;
}

static struct termios oldtio,newtio;
//int uart_init(char* port, tcflag_t cfl, tcflag_t ifl)
int uart_init(struct uart_settings_t* us)
{
	int fd = open(us->port, O_RDWR | O_NOCTTY | O_DSYNC | O_APPEND);
	if (fd <0) {
		fprintf(stderr, "I failed to open port %s\n", us->port);
		perror("The error is ");
		return -EIO;
	}
	tcgetattr(fd,&oldtio); /* save current port settings */
	bzero(&newtio, sizeof(newtio));
	newtio.c_cflag =  us->cfl | CLOCAL | CREAD;
	newtio.c_iflag = us->ifl;
	newtio.c_oflag = us->ofl;
	/* set input mode (non-canonical, no echo,...) */
	newtio.c_lflag = 0;
	newtio.c_cc[VTIME]    = 0;   /* inter-character timer unused */
	newtio.c_cc[VMIN]     = 1;   /* We're non-blocking */
	cfmakeraw(&newtio);
	tcflush(fd, TCIFLUSH);
	tcsetattr(fd,TCSANOW,&newtio);
	return fd;
}
