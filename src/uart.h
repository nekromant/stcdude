#ifndef _UART_H
#define _UART_H

#include <termios.h>

struct uart_settings_t {
	tcflag_t ifl;
	tcflag_t cfl;
	tcflag_t ofl;
	char * port;
	char* tag;
	int fd;
	int speed;
};

void stc_uart_reconf(struct uart_settings_t* s, int speed);
struct uart_settings_t* str_to_uart_settings();

#endif
