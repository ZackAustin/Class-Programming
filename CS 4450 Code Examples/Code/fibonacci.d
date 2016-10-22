// Try n = 42
import std.conv;
import std.stdio;

ulong fib(ulong n) {
    if (n == 0 || n == 1)
        return n;
    else
        return fib(n-1) + fib(n-2);
}

ulong fib2(ulong m) {
    ulong fibhelp(ulong n,ulong a,ulong b) {
        if (n > 0)
            return fibhelp(n-1,a+b,a);  // Tail recursion
        else
            return a;
    }
    return fibhelp (m,0,1);
}

void main(string[] args) {
    if (args.length == 2) {
        writeln(fib2(to!int(args[1])));
        writeln(fib(to!int(args[1])));
    }
}