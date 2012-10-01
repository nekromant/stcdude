bin_PROGRAMS = stcdude

AM_CFLAGS = -DSCRIPTS_PATH='"@datadir@/stcdude/lua"' 
stcdude_CPPFLAGS = $(AMCFLAGS)
stcdude_LDADD = $(LUA_LIBS) -lpthread
stcdude_SOURCES = stcdude.c uart.c payload.c mcudb.c
stcdudedir=@datadir@/stcdude
include datafiles.mk

#v
install-data-local:
	for file in $(stcdude_lua); do \
	$(INSTALL) -D $$file $(stcdudedir)/$$file ;\
	done	
