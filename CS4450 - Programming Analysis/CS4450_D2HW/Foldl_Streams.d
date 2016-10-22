//Zack Austin - D2PartB, Streams - 12/15/13

import std.concurrency, std.stdio, std.exception, std.conv, std.string;

void trinumstream()
{
	int curr = 1;
	int n = 1;
	bool term = false;
	while (!term)
		receive(
				(Tid tid)
				{
					tid.send(curr);
					//increment N
					n++;
					//current of triangular numbers = N(N+1) / 2.
					curr = (n * (n + 1)) / 2;
				},
				(OwnerTerminated x) {term = true;}
				);
}

void numstream()
{
	bool term = false;
	int item = 0;
	while (!term)
		receive(
				(Tid tid)
				{
					item++;
					//send string representation
					tid.send(to!string(item));
				},
				(OwnerTerminated x) {term = true;}
				);
}

//which takes a binary function as a compile-­‐time parameter, along with
//the type of the elements expected in the stream to be processed.

void foldstream(alias f, T)(Tid caller, Tid stream, T t)
{
    T sum = t;
    bool term = false;
    while (!term)
        receive(
				(Tid tid) {
					enforce(tid == caller);
					stream.send(thisTid);
					sum = f(sum, receiveOnly!T());
					caller.send(sum);
				},
				(OwnerTerminated x) {term = true;}
				);
}

int f(int sofar, int x) {return sofar + x;}
string g(string sofar, string x) {return sofar ~ "_" ~ x;}

int main()
{
	auto tid = spawn(&foldstream!(f,int), thisTid, spawn(&trinumstream), 0);
	foreach (i; 0..10)
	{
		tid.send(thisTid);
		writeln(receiveOnly!int());
	}

	writeln();

	tid = spawn(&foldstream!(g,string),thisTid,spawn(&numstream),"0");
	foreach (i; 0..10)
	{
		tid.send(thisTid);
		writeln(receiveOnly!string());
	}

	return 0;
}
