#include <iostream>
#include <string>
using namespace std;

/*
V A *
V B
V C *
W A
W B
W C
X A *
X B *
X C
*/

class A { public: virtual ~A(){} };
class B : public A {};
class C : public B {};
class V { public: virtual ~V(){} };
class W : public V {};
class X : public W {};

string dispatch(const V& v, const A& a) {
    const B* pb = dynamic_cast<const B*>(&a);
    const C* pc = dynamic_cast<const C*>(&a);
    const W* pw = dynamic_cast<const W*>(&v);
    const X* px = dynamic_cast<const X*>(&v);

    if (px) {
        if (pb) {
            return "(X B)";
        }
        return "(X A)";
    }
    // V
    if (pc) {
        return "(V C)";
    }
    return "(V A)";
}

void f(const V& v, const A& a) {
    cout << dispatch(v,a) << "\n";
}

int main() {
    A a;
    B b;
    C c;
    V v;
    W w;
    X x;

    f(v,a);     // (V A)
    f(v,b);     // (V A)
    f(v,c);     // (V C)
    f(w,a);     // (V A)
    f(w,b);     // (V A)
    f(w,c);     // (V C)
    f(x,a);     // (X A)
    f(x,b);     // (X B)
    f(x,c);     // (X B)
}
