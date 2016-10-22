import std.stdio, std.functional, std.datetime;

ulong fib(ulong n) {
    return n == 0 ? 0 : n < 2 ? 1 : fib(n - 2) + fib(n - 1);
}

// Memoized version
ulong fib2(ulong n) {
    alias memoize!fib2 mfib;
    return n == 0 ? 0 : n < 2 ? 1 : mfib(n - 2) + mfib(n - 1);
}

// Tail-recursive version
ulong fib3(ulong n) {
    ulong fibhelp(ulong n, ulong a, ulong b) {
        if (n <= 0)
            return a;
        else
            return fibhelp(n-1,a+b,a);
    }
    return fibhelp(n,0,1);
}

ulong fib4(ulong n) {
    if (n == 0 || n == 1)
        return n;
    ulong curr = 1;
    ulong last = 0;
    foreach (i; 1..n) {
        ulong temp = curr+last;
        last = curr;
        curr = temp;
    }
    return curr;
}

void main() {
    int n = 35;
    auto start = Clock.currSystemTick;
    writeln(fib(n));
    auto stop = Clock.currSystemTick;
    writeln(stop - start);

    start = Clock.currSystemTick;
    writeln(fib2(n));
    stop = Clock.currSystemTick;
    writeln(stop - start);

    start = Clock.currSystemTick;
    writeln(fib3(n));
    stop = Clock.currSystemTick;
    writeln(stop - start);

    start = Clock.currSystemTick;
    writeln(fib4(n));
    stop = Clock.currSystemTick;
    writeln(stop - start);
}

/* Output:
9227465
TickDuration(132826492)
9227465
TickDuration(20314)
9227465
TickDuration(554)
9227465
TickDuration(418)
*/