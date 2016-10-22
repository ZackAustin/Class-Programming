OBJS = rll.o
CC = g++ -std=c++11 -static-libgcc -static-libstdc++
DEBUG = -g
CFLAGS = -Wall -c $(DEBUG)
LFLAGS = -Wall $(DEBUG)

rll.exe: $(OBJS)
	$(CC) $(LFLAGS) $(OBJS) -o rll

rll.o: rll.cpp
	$(CC) $(CFLAGS) rll.cpp

