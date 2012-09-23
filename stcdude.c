#include <stdlib.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <termios.h>
#include "uart.h"
#include "stcdude.h"
#include "lualib.h"
#include "lauxlib.h"

void usage(char* nm){
	printf("WARNING: This tool is in no way affiliated with STC MCU Limited. \n");
	printf("WARNING: Those guys even keep the protocol closed \n");
	printf("WARNING: So consider some STM32 for your new project \n");
	printf("Usage: %s [options] action\n", nm);
	printf("Valid options are:\n");
	printf("\t -p /dev/ttyUSB0 \tspecify serial port to use\n");
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
	printf("GPLv3 or above. See COPYING for details\n");
}



int main(int argc, char* argv[]) {
	printf("STC ISP Tool. (c) Necromant 2012\n");
	int opt;
	int action = ACTION_NONE;
	char* mcudb = "./mcudb/stc10fx.lua";
	char* port = "/dev/ttyUSB0";
	int speed = 19200;
	lua_State* L = lua_open();
	luaL_openlibs(L);

	while ((opt = getopt(argc, argv, "ib:d:mp:")) != -1) {
		switch (opt) {
		case 'i':
			action = ACTION_INFO;
			break;
		case 'd':
			mcudb = optarg;
			printf("Using mcudb file: %s\n", mcudb);
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



	struct uart_settings_t* us = stc_uart_settings(port, speed);
	if (uart_init(us)<0) {
		exit(EXIT_FAILURE);
	}
	printf("fd is %d\n", us->fd );
	char pulsechar[] = { 0x7f, 0x7f };
	switch (action)
	{
	case ACTION_INFO:
		
		printf("Waiting for an infopacket from MCU...\n");
       		start_pulsing(us->fd, 100000, pulsechar, 2); 
		struct packet* packet = fetch_packet(us->fd);
		stop_pulsing();
		dump_packet(packet->data, packet->size);
		sleep(1);
		break;
	}
}

