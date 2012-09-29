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

void stc_uart_reconf(struct uart_settings_t* s, int speed) {
	s->cfl=0;
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
	s->cfl|=CS8;
	s->cfl|=PARENB;
}

struct uart_settings_t* stc_uart_settings(char* port, int speed) {
	struct uart_settings_t* s = calloc(1,sizeof(struct uart_settings_t));
	s->port=port;
	printf("Using %s @ %d\n", s->port, speed);
	stc_uart_reconf(s,speed);
	s->fd=-1;
	return s;
}



static struct termios oldtio,newtio;

block_read(int fd, char* buf, int sz)
{
	int n;
	while(sz) {
		n = read(fd, buf, sz);
		sz -= n;
		buf += n;
	}
}

//int uart_init(char* port, tcflag_t cfl, tcflag_t ifl)
int uart_init(struct uart_settings_t* us)
{
	
	tcdrain(us->fd);
	tcflush(us->fd, TCOFLUSH);
	if (us->fd<0) {
		int fd = open(us->port, O_RDWR | O_NOCTTY );
		fcntl(fd, F_SETFL, 0);
		if (fd <0) {
			fprintf(stderr, "I failed to open port %s\n", us->port);
			perror("The error is ");
			return -EIO;
		}
		us->fd=fd;
	}
	tcgetattr(us->fd,&oldtio); /* save current port settings */
	bzero(&newtio, sizeof(newtio));
	cfmakeraw(&newtio);
	newtio.c_cflag =  us->cfl | CLOCAL | CREAD;
	newtio.c_iflag = us->ifl;
	newtio.c_oflag = us->ofl;
	/* set input mode (non-canonical, no echo,...) */
	newtio.c_lflag = 0;
	newtio.c_cc[VTIME]    = 0; 
	newtio.c_cc[VMIN]     = 1; 
	tcdrain(us->fd);
	tcsetattr(us->fd,TCSANOW,&newtio);
	return us->fd;
}

