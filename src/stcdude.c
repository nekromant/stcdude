/*
 * Copyright 2014 Andrew 'Necromant' Andrianov <andrew@ncrmnt.org>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 */

#include "stcdude.h"
#include "mcudb.h"
#include "payload.h"
#include "uart.h"

#include <stdlib.h>
#include <sys/ioctl.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <termios.h>
#include <sys/stat.h>
#include <lualib.h>
#include <lauxlib.h>

static struct uart_settings_t* us;
static int delay_hack = 0;
int g_no_crc = 0;

void usage(char* nm){
	printf("WARNING: This tool is in no way affiliated with STC MCU Limited. \n");
	printf("WARNING: Those guys even keep the protocol closed \n");
	printf("WARNING: So consider some STM32 for your new project \n");
	printf("Usage: %s [options]\n", nm);
	printf("Valid options are:\n");
	printf("\t -p /dev/ttyUSB0 \tspecify serial port to use\n");
	printf("\t -b handshake:upload \tspecify baud rate to use (initial and upload)\n");
	printf("\t -h \tprint this help and exit\n");
	printf("\t -a action \tspecify an action\n");
	printf("\t -f filename.bin \tSend this file to mcu\n");
	printf("\t -w \t Workaround broken tcdrain\n");
	printf("\t -n \t Disable CRC checking of inbound packets (STC89)\n");	
	printf("Valid actions (for -a) are:\n");
	printf("\t info \t query mcu options\n");
	printf("\t wflash \t write file to flash memory\n");
	printf("This is free software, feel free to redistribute it under the terms\n");
	printf("GPLv3 or above. See COPYING for details\n");
	printf("Extra developer options:\n");
	printf("\t -l packet monitoring mode\n");
}

#define die(message) { printf(message); exit(EXIT_FAILURE); }


int l_send_packet(lua_State* L) {
	int argc = lua_gettop(L);
	if (argc!=1)
		die("Incorrect number of args to send_packet\n");
	const char* payload = lua_tostring(L,1);
	char scbuf[3];
	scbuf[2]=0x0;
	int len = strlen(payload)/2;
	unsigned char* tmp = malloc(len);
	int i;
	for (i=0;i<len; i++)
	{
		strncpy(scbuf,&payload[i*2],2);
		sscanf(scbuf, "%hhx",&tmp[i]);
	}
	unsigned char* packet = pack_payload(tmp, len, HOST2MCU);
	write(us->fd, packet, PACKED_SIZE(len));
	
	tcdrain(us->fd);

	if (delay_hack) {
		int delay = PACKED_SIZE(len)*1000000/us->speed*12; /* account for 11 bits */	
		usleep(delay);
	}
		
	free(tmp);
	free(packet);
	return 0;
}

int l_get_packet(lua_State* L) {
	struct packet* packet;
	packet = fetch_packet(us->fd);
	//printf("Got %hd bytes\n ", packet->size);
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
	if (us->speed == newbaud)
		return 0;
	stc_uart_reconf(us, newbaud);
	uart_init(us);
	return 0;
}



static void display_progressbar(int max, int value){
	int percent = 100 - value * 100 / max;
	int bars = 60 - value * 60 / max;
	int i;
	
	printf("\r %d %% done | ",  percent);
	for (i=0; i<bars; i++)
		printf("#");
	for (i=bars; i<60; i++)
		printf(" ");
	printf("| %d K", (max-value) / 1024);
	fflush(stdout);
}


int l_send_file(lua_State *L) {
	int argc = lua_gettop(L);
	if (argc!=2)
		die("Incorrect number of args to set_baud\n");
	const char* filename = lua_tostring(L,1);
	int chunksize = lua_tonumber(L,2);
	
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
		printf("WARNING: File too big to fit in flash, truncating!\n");
		sz = minf->iromsz+1;
	}
	printf("Downloading %s (%d bytes)\n", filename, sz);
	unsigned int maxsz = sz;
	//unsigned short sz = PACKED_SIZE(chunksize+7);
	/* We add a few bytes.
	   type of packet? 0x00
	   0x0 0x0 
	   2 bytes, offset to write at
	   2 bytes, size to write
	 */
	unsigned char* tmp = calloc(1, chunksize+7);
	int len;
	unsigned short offset=0;
	/* Since chunksize is fixed */
	tmp[5]=HIGH_BYTE((unsigned short) chunksize);
	tmp[6]=LOW_BYTE((unsigned short) chunksize);
	struct packet* response;
	struct write_response *rsp;
	unsigned short crc; 
	while (sz) {
		len = fread(&tmp[7], 1, chunksize, fd);
		crc = byte_sum(&tmp[7], chunksize);
		crc = crc & 0x00ff; /* We get a shorted, one byte crc */ 
		tmp[3]=HIGH_BYTE(offset);
		tmp[4]=LOW_BYTE(offset);		
		unsigned char* packet = pack_payload(tmp,chunksize+7, HOST2MCU);
		write(us->fd, packet, PACKED_SIZE(chunksize+7));
		do_dump_packet(packet,PACKED_SIZE(chunksize+7));
		free(packet);
		response = fetch_packet(us->fd);
		rsp = (struct write_response *) response->payload;
		if (rsp->errcode !=0 )
		{
			fprintf(stderr, "Warning, mcu reports error @0x%hx: %hhx\n", offset, rsp->errcode);
			//printf();
		}else
		{
			//tmp[0]
		}
		if (rsp->crc != (unsigned char) crc )
			fprintf(stderr, "Warning, crc error @0x%hx: %hhx vs %hhx\n", 
				offset, 
				rsp->crc, 
				(unsigned char) crc);
		do_dump_packet(response->payload, response->size);
		sz-= len;
		offset+=len;
		display_progressbar(maxsz,sz);	
	}
	printf("\n");

	return 0;
}

static char pulsechar[] = { 0x7f, 0x7f };

int l_mcu_connect(lua_State* L) {
	struct packet *packet;
	start_pulsing(us->fd, 50000, pulsechar, 2); 

	do { 
		packet = fetch_packet(us->fd);
	} while (!packet);

	stop_pulsing();
	int hspeed = lua_tonumber(L,1);
	parse_info_packet(L, packet, hspeed);
	return 0;
}

void register_luastuff(lua_State* L) {
	lua_register(L, "send_packet", l_send_packet);
	lua_register(L, "get_packet", l_get_packet);
	lua_register(L, "set_baud", l_set_baud);
	lua_register(L, "send_file", l_send_file);
	lua_register(L, "mcu_connect", l_mcu_connect);
}


int main(int argc, char* argv[]) {
	printf("STC ISP Tool. (c) Necromant 2012\n");
	int opt;
	int action = ACTION_SEQ;
	char* port = "/dev/ttyUSB0";
	char* scenario = "default.lua";
	char* filename = "null";
	int uspeed = 57600;
	int hspeed = 1200;
	char* seq = "info";
	lua_State* L = luaL_newstate();
	luaL_openlibs(L);
	register_luastuff(L);
	struct winsize w;
	ioctl(STDOUT_FILENO, TIOCGWINSZ, &w);
	
	while ((opt = getopt(argc, argv, "nb:p:lb:a:f:w")) != -1) {
		switch (opt) {
		case 'b':
			sscanf(optarg, "%d:%d",&hspeed, &uspeed);
			break;
		case 'p':
			port = optarg;
			break;
		case 'l':
			printf("Starting to monitor all incoming packets\n");
			action = ACTION_MON;
			break;
		case 'a':
			action = ACTION_SEQ;
			seq = optarg;
			break;
		case 'f':
			filename = optarg;
			break;
		case 'w':
			delay_hack = 1;
			break;
		case 'n':
			g_no_crc=1;
			break;

		default: /* '?' */
			usage(argv[0]);
			exit(EXIT_FAILURE);
		}
	}


	/* Push a few options to lua */
	lua_pushstring( L, filename );
	lua_setglobal( L, "filename" );
	lua_pushnumber( L, hspeed );
	lua_setglobal( L, "handshake_speed" );
	lua_pushnumber( L, uspeed );
	lua_setglobal( L, "upload_speed" );
	lua_pushstring( L,  SEQDIR);
	lua_setglobal( L, "SEQDIR" );
	lua_pushstring( L,  MCUDB_DIR);
	lua_setglobal( L, "MCUDBDIR" );

	/* All checks passsed, let's rick'n'roll */
	mcudb_open(L, SCRIPTS_PATH "/init.lua" );



	if (action == ACTION_NONE)
	{
		printf("No valid action set, have a quick look at the help\n");
		usage(argv[0]);
		exit(EXIT_FAILURE);
	}
	
	us = stc_uart_settings(port, hspeed);
	if (uart_init(us)<0) {
		exit(EXIT_FAILURE);
	}
	
	struct packet* packet;
	switch (action)
	{
	case ACTION_MON:
		while (1)
		{
			packet = fetch_packet(us->fd);
			free(packet->data);
			free(packet);
		}
		break;
	case ACTION_SEQ: /* Scripted action */
		lua_getglobal(L, "run_sequence");  /* function to be called */
		lua_pushstring(L, seq);  /* prepare parameter */
		if (lua_pcall(L, 1, 0, 0) != 0)
		{
			fprintf(stderr, "error running sequence '%s': %s\n",
				seq, lua_tostring(L, -1));
			return 1;
		}
		break;
	}
}

