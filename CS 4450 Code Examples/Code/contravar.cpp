// contravar.cpp: Illustrates contravariance of preconditions and covariance of post-conditions
#include <cassert>
#include <iostream>
#include <stdexcept>
using namespace std;

class Base {
public:
    virtual int f(int x) {
        if (x % 2 == 0)
            throw logic_error("Pre-condition violation; x must be odd");

        int retval = x*2;           // Function body

        assert(retval % 2 == 0);    // Post-condition: retval is even
        return retval;
    }
    virtual ~Base() {}
};

class Derived : public Base {
public:
    virtual int f(int x) {
        // Pre-condition: x is an integer
        
        return 8;   // 8 is even
    }
};

int main() {
    Base b, *p = &b;
    cout << p->f(11) << '\n';   // 22
    Derived d;
    p = &d;
    cout << p->f(10) << '\n';   // 8
}