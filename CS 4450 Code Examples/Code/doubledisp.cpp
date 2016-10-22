// doubledisp.cpp
#include <iostream>
#include <string>
using namespace std;

/*
A V *
A W
A X *
B V
B W
B X *
C V *
C W
C X
*/

class A { public: virtual ~A(){} };
class B : public A {};
class C : public B {};
class V { public: virtual ~V(){} };
class W : public V {};
class X : public W {};

string dispatch(const A& a, const V& v) {
    const B* pb = dynamic_cast<const B*>(&a);
    const C* pc = dynamic_cast<const C*>(&a);
    const W* pw = dynamic_cast<const W*>(&v);
    const X* px = dynamic_cast<const X*>(&v);

    if (pc) {
        return "(C V)";
    }
    if (pb) {
        if (px) {
            return "(B X)";
        }
    }
    // A
    if (px) {
        return "(A X)";
    }
    return "(A V)";
}

void f(const A& a, const V& v) {
    cout << dispatch(a,v) << "\n";
}

int main() {
    A a;
    B b;
    C c;
    V v;
    W w;
    X x;
    
    f(a,v);     // (A V)
    f(a,w);     // (A V)
    f(a,x);     // (A X)
    f(b,v);     // (A V)
    f(b,w);     // (A V)
    f(b,x);     // (B X)
    f(c,v);     // (C V)
    f(c,w);     // (C V)
    f(c,x);     // (C V)
}
