// multimeth.cpp
#include <iostream>
using namespace std;

/* Possible combinations (in ascending "most derived" order); existing methods marked*:
A V Y *
A V Z *
A W Y
A W Z
A X Y
A X Z *
B V Y
B V Z
B W Y *
B W Z
B X Y
B X Z *
C V Y
C V Z *
C W Y
C W Z
C X Y *
C X Z
*/

class A { public: virtual ~A(){} };
class B : public A {};
class C : public B {};
class V { public: virtual ~V(){} };
class W : public V {};
class X : public W {};
class Y { public: virtual ~Y(){} };
class Z : public Y {};

string dispatch(const A& a, const V& v, const Y& y) {
    const B* pb = dynamic_cast<const B*>(&a);
    const C* pc = dynamic_cast<const C*>(&a);
    const W* pw = dynamic_cast<const W*>(&v);
    const X* px = dynamic_cast<const X*>(&v);
    const Z* pz = dynamic_cast<const Z*>(&y);

    if (pc) {
        if (px) {
            return "(C X Y)";
        }
        if (pz) {
            return "(C V Z)";
        }
    }
    if (pb) {
        if (px && pz) {
            return "(B X Z)";
        }
        if (pw) {
            return "(B W Y)";
        }
    }
    // A
    if (px && pz) {
        return "(A X Z)";
    }
    if (pz) {
        return "(A V Z)";
    }
    return "(A V Y)";
}

void f(const A& a, const V& v, const Y& y) {
    cout << dispatch(a,v,y) << "\n";
}

int main() {
    A a;
    B b;
    C c;
    V v;
    W w;
    X x;
    Y y;
    Z z;
    
    f(a,v,y);
    f(a,v,z);
    f(a,w,y);
    f(a,w,z);
    f(a,x,y);
    f(a,x,z);
    f(b,v,y);
    f(b,v,z);
    f(b,w,y);
    f(b,w,z);
    f(b,x,y);
    f(b,x,z);
    f(c,v,y);
    f(c,v,z);
    f(c,w,y);
    f(c,w,z);
    f(c,x,y);
    f(c,x,z);
}
