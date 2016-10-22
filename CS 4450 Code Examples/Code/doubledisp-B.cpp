#include <iostream>
using namespace std;

class V;
class W;
class X;

class Visitor {
public:
    virtual ~Visitor(){};
    virtual void visitV(const V&) const = 0;
    virtual void visitW(const W&) const = 0;
    virtual void visitX(const X&) const = 0;
};

class A : public Visitor {
public:
    void visitV(const V&) const {
        cout << "(V A)\n";
    }
    void visitW(const W&) const {
        cout << "(V A)\n";      // Have to add manually per interface
    }
    void visitX(const X&) const {
        cout << "(X A)\n";
    }
};

class B : public A {
public:
    void visitX(const X&) const {
        cout << "(X B)\n";
    }
};

class C : public B {
public:
    void visitV(const V&) const {
        cout << "(V C)\n";
    }
};

class V {
public:
    virtual ~V() {}
    virtual void f(const Visitor& v) const {
        v.visitV(*this);
    }
};

class W : public V {
public:
    virtual void f(const Visitor& v) const {
        v.visitW(*this);
    }
};

class X: public W {
public:
    virtual void f(const Visitor& v) const {
        v.visitX(*this);
    }
};

int main() {
    A a;
    B b;
    C c;
    V v;
    W w;
    X x;
    
    V* p = &v;
    p->f(a);    // (V A)
    p->f(b);    // (V A)
    p->f(c);    // (V C)

    p = &w;
    p->f(a);    // (V A)
    p->f(b);    // (V A)
    p->f(c);    // (V A) => was (C V)

    p = &x;
    p->f(a);    // (X A)
    p->f(b);    // (X B)
    p->f(c);    // (X B) => was (C V)
}