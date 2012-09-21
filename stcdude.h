#ifndef __STCDUDE_H
#define __STCDUDE_H

enum {
	ACTION_NONE,
	ACTION_INFO,
};


#define MCU2HOST 0x68
#define HOST2MCU 0x6A

#define START_BYTE0 0x46
#define START_BYTE1 0xB9

struct packet {
	unsigned short size;
	char* data;
};

/* Creates an uart settings structure suitable for ISP */
struct uart_settings_t* stc_uart_settings(char* port, int speed);
/* opens up the port */
int uart_init(struct uart_settings_t* us);

#endif
