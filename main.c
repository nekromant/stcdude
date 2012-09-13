#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <termios.h>
#include "uart.h"

char packet[] = { 0x46, 0xb9, 0x68, 0x31, 0x1, 0xe5, 0x1, 0xe5, 0x1, 0xe5, 0x1, 0xe5, 0x1, 0xe5, 0x1, 0x1, 0xe5, 0x1, 0x62, 0x49, 0x70, 0x8c, 0x7f, 0xf7, 0xb0, 0x1, 0x80, 0x13, 0xa2, 0x16 };




void pulse(int fd, int n) {
	char token = 0x7f;
	while(n--)
	{
		write(fd,&token,1);
		usleep(1000);
	}
	
}

int main(int argc, char* argv[])
{
printf("create\n");
	struct uart_settings_t* us = str_to_uart_settings(argv[1]);
	printf("open\n");
	us->fd = uart_init(us);
	printf("fs is %d\n",us->fd);
	pulse(us->fd,100000);
//	wait_mark(us->fd,50);
//	write(us->fd,&packet,30);
	
}
