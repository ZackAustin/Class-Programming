import std.stdio;
void main()
{
	double[3] a = [ 10, 20, 30 ];
	double[3] b = [ 2, 3, 4 ];
	double[3] result = a[] + b[];
	writeln(result);
	double[3] c = [ 10, 20, 30 ];
	c[] /= 4;
	writeln(c);
	int[][] array = [
		[ 10, 11, 12 ],
		[ 20, 21 ],
		[ 30, 31, 32 ],
		[ 40, 41, 42 ]
		];
	writeln(array);
}