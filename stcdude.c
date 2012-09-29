#include <stdlib.h>
#include <sys/ioctl.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <termios.h>
#include <sys/stat.h>
#include "uart.h"
#include "stcdude.h"
#include "lualib.h"
#include "lauxlib.h"

static struct uart_settings_t* us;
struct mcuinfo* minf;

void usage(char* nm){
	printf("WARNING: This tool is in no way affiliated with STC MCU Limited. \n");
	printf("WARNING: Those guys even keep the protocol closed \n");
	printf("WARNING: So consider some STM32 for your new project \n");
	printf("Usage: %s [options] action\n", nm);
	printf("Valid options are:\n");
	printf("\t -p /dev/ttyUSB0 \tspecify serial port to use\n");
	printf("\t -b handshake:upload \tspecify baud rate to use (initial and upload)\n");
	printf("\t -d database \tspecify mcudb to use\n");
	printf("Valid actions are:\n");
	printf("\t -h \tprint this help and exit\n");
	printf("\t -i \tquery MCU info\n");
	printf("\t -s infostring \tset MCU info (have a look at the README)\n");
	printf("\t -w filename.bin \tdownload binary file to flash\n");
	printf("\t -e filename.bin \tdownload binary file to eeprom\n");
	printf("\t -W filename.bin \tupload binary file from flash\n");
	printf("\t -E filename.bin \tupload binary file from eeprom\n");
	printf("This is free software, feel free to redistribute it under the terms\n");
	printf("Extra developer options:\n");
	printf("\t -l packet monitoring mode:\n");
	printf("GPLv3 or above. See COPYING for details\n");
}

#define die(message) { printf(message); exit(EXIT_FAILURE); }

int l_send_packet(lua_State* L) {
	int argc = lua_gettop(L);
	if (argc!=1)
		die("Incorrect number of args to send_packet\n");
	const char* payload = lua_tostring(L,1);
	char scbuf[3];
	printf("Sending out: %s\n", payload);
	scbuf[2]=0x0;
	int len = strlen(payload)/2;
	char* tmp = malloc(len);
	int i;
	for (i=0;i<len; i++)
	{
		strncpy(scbuf,&payload[i*2],2);
		sscanf(scbuf, "%hhx",&tmp[i]);
	}
	char* packet = pack_payload(tmp, len, HOST2MCU);
	write(us->fd, packet, PACKED_SIZE(len));
	usleep(200000); /* FixMe: Find a better way to flush the data */
	free(tmp);
	free(packet);
	return 0;
}

int l_get_packet(lua_State* L) {
	struct packet* packet;
	packet = fetch_packet(us->fd);
	printf("Got %hd bytes\n ", packet->size);
	int i;
	lua_newtable(L);
	for (i=0; i<packet->size; i++) {
		   lua_pushnumber(L, i);
		   lua_pushnumber(L, (int) packet->payload[i]);
		   lua_settable(L, -3);
	}
		
	return 1; /* return the table with bytes */
}

int l_set_baud(lua_State *L) {
	int argc = lua_gettop(L);
	if (argc!=1)
		die("Incorrect number of args to set_baud\n");
	int newbaud = lua_tonumber(L,1);
	printf("Baudrate switch to %d\n", newbaud);
	stc_uart_reconf(us, newbaud);
	uart_init(us);
	return 0;
}



static void display_progressbar(int max, int value){
	int percent = 60 - value * 60 / max;
	int i;
	
	printf("\r %d %% done | ", percent);
	for (i=0; i<percent; i++)
		printf("#");
	fflush(stdout);
}


int l_send_file(lua_State *L) {
	int argc = lua_gettop(L);
	if (argc!=2)
		die("Incorrect number of args to set_baud\n");
	char* filename = lua_tostring(L,1);
	int chunksize = lua_tonumber(L,128);
	
	FILE* fd = fopen(filename, "r");
	struct stat inf;
	if (0 != stat(filename,&inf)) {
		perror("stat failed: ");
		die("");
	}
	if (fd<0){
		perror("couldn't open file:");
		die("");
	}
	unsigned int sz = (unsigned int)inf.st_size;
	if (minf->iromsz < sz) {
		printf("File too big to fit in flash, truncating");
		sz = minf->iromsz+1;
	}
	printf("Downloading %s (%d bytes)\n", filename, sz);
	unsigned int maxsz = sz;
//	unsigned short sz = PACKED_SIZE();
//	char* tmp=calloc(1,chunksize+8);
	
//	char* data=&tmp[8];
	
	while (sz) {
		
	}
	
}

void register_luastuff(lua_State* L) {
	lua_register(L, "send_packet", l_send_packet);
	lua_register(L, "get_packet", l_get_packet);
	lua_register(L, "set_baud", l_set_baud);
	lua_register(L, "send_file", l_send_file);
}


int main(int argc, char* argv[]) {
	printf("STC ISP Tool. (c) Necromant 2012\n");
	int opt;
	int action = ACTION_NONE;
	char* mcudb = "./mcudb/stc10fx.lua";
	char* port = "/dev/ttyUSB0";
	char* scenario = "default.lua";
	char* filename = "null";
	int uspeed = 19200;
	int hspeed = 1200;
	lua_State* L = lua_open();
	luaL_openlibs(L);
	register_luastuff(L);
	struct winsize w;
	ioctl(STDOUT_FILENO, TIOCGWINSZ, &w);
	
	printf ("lines %d\n", w.ws_row);
	printf ("columns %d\n", w.ws_col);

	while ((opt = getopt(argc, argv, "ib:d:mp:lb:w:")) != -1) {
		switch (opt) {
		case 'i':
			action = ACTION_INFO;
			break;
		case 'd':
			mcudb = optarg;
			printf("Using mcudb file: %s\n", mcudb);
			break;
		case 'b':
			sscanf(optarg, "%d:%d",&hspeed, &uspeed);
			break;
		case 't':
			//nsecs = atoi(optarg);
			//tfnd = 1;
			break;
		case 'p':
			port = optarg;
			break;
		case 'm': /* Dirty hack, remove me later */
			printf("Demonstrating mcudb magic\n");
			mcudb_open(L, "./init.lua");
			mcudb_open(L, mcudb);
			char magic[] = {0xD2, 0xFA};
			struct mcuinfo *inf = mcudb_query_magic(L,magic);
			print_mcuinfo(inf);	
			exit(1);
			break;
		case 'l':
			printf("Starting to monitor all incoming packets\n");
			action = ACTION_MON;
			break;
		case 'w':
			action = ACTION_DOWN;
			filename = optarg;
			break;
		default: /* '?' */
			usage(argv[0]);
			exit(EXIT_FAILURE);
		}
	}
	if (action == ACTION_NONE)
	{
		printf("No valid action set, have a quick look at the help\n");
		usage(argv[0]);
		exit(EXIT_FAILURE);
	}
	
	/* All checks passsed, let's rick'n'roll */
	mcudb_open(L, "./init.lua");
	mcudb_open(L, mcudb);



	us = stc_uart_settings(port, hspeed);
	if (uart_init(us)<0) {
		exit(EXIT_FAILURE);
	}
	
	printf("fd is %d\n", us->fd );
	char pulsechar[] = { 0x7f, 0x7f };

	
	struct packet* packet;
	switch (action)
	{
	case ACTION_INFO:
		printf("Waiting for an infopacket from MCU...\n");
       		start_pulsing(us->fd, 145000, pulsechar, 2); 
		packet = fetch_packet(us->fd);
		stop_pulsing();
		parse_info_packet(L, packet, hspeed);
		break;
	case ACTION_MON:
		while (1)
		{
			packet = fetch_packet(us->fd);
			free(packet->data);
			free(packet);
		}
		break;
	case ACTION_DOWN:
		/* Draft implementation, leaks memory, for testing only */
		printf("\nWaiting for an infopacket from MCU...\n");
       		start_pulsing(us->fd, 145000, pulsechar, 2); 
		packet = fetch_packet(us->fd);
		stop_pulsing();
		minf = parse_info_packet(L, packet, hspeed);
		printf("Running io scenario...\n");
		mcudb_open(L, scenario);
		break;
	}
}

