stcdude: stcdude.c payload.c uart.c mcudb.c
	$(CC) -g -o $(@) $(^) -llua -lpthread 

stcplay: main.c uart.c payload.c
	gcc main.c uart.c -o stcplay
