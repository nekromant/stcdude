stcdude: stcdude.c payload.c uart.c
	$(CC) -o $(@) $(^) -llua

stcplay: main.c uart.c payload.c
	gcc main.c uart.c -o stcplay
