import std.stdio;

void main() {
	class A { int fun() { return 42; } }
	A a = new A;
	auto dg = &a.fun;	// A "bound method"
	writeln(dg());
}
