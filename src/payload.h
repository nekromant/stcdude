#ifndef STCDUDE_PAYLOAD_H
#define STCDUDE_PAYLOAD_H

#include "stcdude.h"

#include <lualib.h>

unsigned short byte_sum(unsigned char* payload, int sz);
unsigned char* pack_payload(unsigned char* payload, int len, char dir);
struct packet* fetch_packet(int fd);
struct mcuinfo* parse_info_packet(lua_State* L, struct packet* pck, int baudrate);

#endif
