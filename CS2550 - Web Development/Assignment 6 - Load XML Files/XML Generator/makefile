OBJS = GenerateXMLPuzzles.o XMLGenerator.o
CC = g++ -std=c++11
DEBUG = -g
CFLAGS = -Wall -c $(DEBUG)
LFLAGS = -Wall $(DEBUG)

genPuzzles.exe: $(OBJS)
	$(CC) $(LFLAGS) $(OBJS) -o GenerateXMLPuzzles

GenerateXMLPuzzles.o: XMLGenerator.h GenerateXMLPuzzles.cpp
	$(CC) $(CFLAGS) -o GenerateXMLPuzzles.cpp

XMLGenerator.o: XMLGenerator.h XMLGenerator.cpp
	$(CC) $(CFLAGS) -o XMLGenerator.cpp

clean:
	\rm *.o genPuzzles.exe