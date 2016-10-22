OBJS = genetics.o population.o
CC = g++ -std=c++11
DEBUG = -g
CFLAGS = -Wall -c $(DEBUG)
LFLAGS = -Wall $(DEBUG)

genetics.exe: $(OBJS)
	$(CC) $(LFLAGS) $(OBJS) -o genetics

genetics.o: population.h genetics.cpp
	$(CC) $(CFLAGS) genetics.cpp

population.o: population.h population.cpp 
	$(CC) $(CFLAGS) population.cpp

clean:
	\rm *.o genetics.exe