#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <termios.h>
#include <time.h>
#include "uart.h"


#define ARRAY_SIZE(arr) (sizeof(arr)/sizeof(arr[0]))

/* Initial effort to send the captured packet back to the software. While now failing hard */

char packet[] = { 
	0x46, /* Looks like these */
	0xB9, /* are the magic */
	0x68, /* number that IDs*/
	0x00, /* the MCU */
	0x31,
	0x50,
	0x00,
	0xF3,
	0x00,
	0xF1,
	0x00,
	0xF2,
	0x00,
	0xF1,
	0x00,
	0xF1,
	0x00,
	0xF2,
	0x00,
	0xF2,
	0x00,
	0xF2,
	0x62,
	0x49,
	0x00,
	0xD1,
	0x70,
	0x8C,
	0xFF,
	0x7F,
	0xF7,
	0xFF,
	0xFF,
	0xFF,
	0x00,
	0x00,
	0x00,
	0x03,
	0x00,
	0xB0,
	0x01,
	0xD7,
	0x6A,
	0x00,
	0xBB,
	0x71,
	0x80,
	0x00,
	0x14,
	0x02,
	0x16,
};




void pulse(int fd, int n) {
	/* Send out 2 x 0x7f every ~15 ms */ 
	char token[] = {0x7f, 0x7f};
	while(n--)
	{
		write(fd,token,ARRAY_SIZE(token));
		usleep(1000);
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


void wait_mark(int fd, int n) {
	char token;;
	int i=0;
	float a=0.0;
	float delta;
	while(1)
	{
		frametimer_update();
		n--;
		read(fd,&token,1);
		delta = frametimer_since(0)-a;
		printf("%f %f %d \n" ,a, delta, n);
		a = frametimer_since(0);
		if ((n<0) && (delta<0.01)) return;
	}
}

void _write(int fd, char* buf, int count) {
	int i;
	for (i=0; i< count; i++)
	{
		write(fd,&buf[i],1);
		usleep(800);
	}
}

int main(int argc, char* argv[])
{
printf("create\n");
	struct uart_settings_t* us = str_to_uart_settings(argv[1]);
	us->fd = uart_init(us);
	printf("fs is %d\n",us->fd);
//	pulse(us->fd,100000);
	frametimer_init();
	wait_mark(us->fd,50);
	printf("sending %d bytes\n",ARRAY_SIZE(packet));
	write(us->fd,&packet,ARRAY_SIZE(packet));
	
}
