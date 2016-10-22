// contravar.d: Illustrates contravariance of preconditions and covariance of post-conditions
import std.stdio;

class Base {
public:
    int f(int x)
    in {
        assert(x % 2 == 1);         // Pre-condition
    }
    out (retval) {
        assert(retval % 2 == 0);    // Post-condition
    }
    body {
        int retval = x*2;
        return retval;
    }
}

class Derived : Base {
public:
    int f(int x) 
    in {
        assert(is(typeof(x) : int));
    }
    out (retval) {
        assert(retval == 8);             // Consistent with x % 2 == 0
    }
    body {
        int retval = 8;
        return retval;
    }
}

void main() {
    Base b = new Base;
    Base p = b;
    writeln(p.f(11));   // 22
    p = new Derived;
    writeln(p.f(10));   // 8
}