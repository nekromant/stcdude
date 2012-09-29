#ifndef __STCDUDE_H
#define __STCDUDE_H

enum {
	ACTION_NONE,
	ACTION_INFO,
	ACTION_MON, /* Packet monitoring */
	ACTION_DOWN
};


#define MCU2HOST 0x68
#define HOST2MCU 0x6A

#define START_BYTE0 0x46
#define START_BYTE1 0xB9

struct packet {
	unsigned short size;
	unsigned char* data;
	unsigned char* payload;
};

struct mcuinfo {
	char* name;
	char magic[2];
	size_t iramsz;
	size_t xramsz;
	size_t iromsz;
	int speed;
	char* descr;
};

enum {
	TESTED_INFO_GET,
	TESTED_INFO_SET,
	TESTED_FLASH_READ,
	TESTED_FLASH_WRITE,
	TESTED_EEPROM_READ,
	TESTED_EEPROM_WRITE,
};

#define DUMP_PACKETS
#ifdef DUMP_PACKETS
#define do_dump_packet(pck, len) dump_packet(pck,len)
#else
#define do_dump_packet(pck, len) ;;
#endif

/* 
-- tested can be one of the following flags:
-- rflash wflash 
-- reeprom weeprom
-- rinfo winfo
*/


struct mcuinfo* mcudb_query_magic(void* L, char magic[2]);

/* Creates an uart settings structure suitable for ISP */
struct uart_settings_t* stc_uart_settings(char* port, int speed);

/* On-the-fly speed change for port */
void stc_uart_speedchange(struct uart_settings_t* us, int speed);

/* opens up the port, if needed or reinits with new speed */
int uart_init(struct uart_settings_t* us);

/* Start pulsing with data on the descriptor */
void start_pulsing(int fd, int delay, char* data, size_t datasz);

/* Stop pulsing */ 
void stop_pulsing();

#define ARRAY_SIZE(arr) (sizeof(arr)/sizeof(arr[0]))
#define PACKED_SIZE(len) (len+8)
#endif
