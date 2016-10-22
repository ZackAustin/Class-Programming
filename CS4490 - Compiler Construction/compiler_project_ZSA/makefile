OBJS = kxic.o dbgArgs.o scanner.o st.o sas.o os.o semdeb.o icgen.o cl.o tcgen.o
CC = g++ -std=c++11 -static-libgcc -static-libstdc++
DEBUG = -g
CFLAGS = -Wall -c $(DEBUG)
LFLAGS = -Wall $(DEBUG)

kxic.exe: $(OBJS)
	$(CC) $(LFLAGS) $(OBJS) -o kxic

kxic.o: kxic.cpp scanner.h st.h os.h sas.h semdeb.h icgen.h cl.h tcgen.h
	$(CC) $(CFLAGS) kxic.cpp

dbgArgs.o: dbgArgs.h dbgArgs.cpp
	$(CC) $(CFLAGS) dbgArgs.cpp

scanner.o: scanner.h dbgArgs.h scanner.cpp
	$(CC) $(CFLAGS) scanner.cpp

st.o: scanner.h dbgArgs.h st.h st.cpp
	$(CC) $(CFLAGS) st.cpp

sas.o: st.h sas.h sas.cpp
	$(CC) $(CFLAGS) sas.cpp

os.o: dbgArgs.h sas.h os.h os.cpp
	$(CC) $(CFLAGS) os.cpp

semdeb.o: semdeb.h sas.h os.h semdeb.cpp
	$(CC) $(CFLAGS) semdeb.cpp

icgen.o: icgen.h scanner.h icgen.cpp
	$(CC) $(CFLAGS) icgen.cpp

cl.o: scanner.h dbgArgs.h st.h sas.h os.h semdeb.h icgen.h cl.h cl.cpp
	$(CC) $(CFLAGS) cl.cpp

tcgen.o: st.h icgen.h tcgen.h tcgen.cpp
	$(CC) $(CFLAGS) tcgen.cpp

clean: 
	\rm *.o