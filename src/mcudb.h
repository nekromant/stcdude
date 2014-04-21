#ifndef STCDUDE_MCUDB_H
#define STCDUDE_MCUDB_H

#include <lualib.h>

struct mcuinfo {
    char* name;
    char magic[2];
    size_t iramsz;
    size_t xramsz;
    size_t iromsz;
    int speed;
    char* descr;
} __attribute__ ((packed));

lua_State* mcudb_open(lua_State* L, char* file);
void print_mcuinfo(struct mcuinfo *mi);
struct mcuinfo* mcudb_query_magic(void* L, unsigned char magic[2]);

#endif
