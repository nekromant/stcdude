#ifndef __STCDUDE_H
#define __STCDUDE_H

enum {
	ACTION_NONE,
	ACTION_MON, /* Packet monitoring */
	ACTION_SEQ /* Run sequence from lua */
};


#define MCU2HOST 0x68
#define HOST2MCU 0x6A

#define START_BYTE0 0x46
#define START_BYTE1 0xB9

struct packet {
	unsigned short size;
	unsigned char* data;
	unsigned char* payload;
} ;

struct mcuinfo {
	char* name;
	char magic[2];
	size_t iramsz;
	size_t xramsz;
	size_t iromsz;
	int speed;
	char* descr;
} __attribute__ ((packed));

enum {
	TESTED_INFO_GET,
	TESTED_INFO_SET,
	TESTED_FLASH_READ,
	TESTED_FLASH_WRITE,
	TESTED_EEPROM_READ,
	TESTED_EEPROM_WRITE,
};

struct write_response {
	char errcode;
	unsigned char crc;
} __attribute__ ((packed));

//#define DUMP_PACKETS

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
#define HIGH_BYTE(s) (char) ((s >> 8 ) & 0xff);
#define LOW_BYTE(s) (char) ((s ) & 0xff);


#define MCUDB_DIR    SCRIPTS_PATH "/mcudb/"
#define SEQDIR       SCRIPTS_PATH "/seq/"
#define INITFILE     SCRIPTS_PATH "/init.lua"


void free_packet(struct packet* pck);
extern struct mcuinfo* minf;

#endif
