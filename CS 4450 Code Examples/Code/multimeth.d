// multimeth.d
import std.stdio;

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

class A {};
class B : A {};
class C : B {};
class V {};
class W : V {};
class X : W {};
class Y {};
class Z : Y {};

string dispatch(A a, V v, Y y) {
    B b = cast(B) a;
    C c = cast(C) a;
	W w = cast(W) v;
	X x = cast(X) v;
	Z z = cast(Z) y;

    if (c) {
        if (x) {
            return "(C X Y)";
        }
        if (z) {
            return "(C V Z)";
        }
    }
    if (b) {
        if (x && z) {
            return "(B X Z)";
        }
        if (w) {
            return "(B W Y)";
        }
    }
    // A
    if (x && z) {
        return "(A X Z)";
    }
    if (z) {
        return "(A V Z)";
    }
    return "(A V Y)";
}

void f(A a, V v, Y y) {
    writeln(dispatch(a,v,y));
}

void main() {
    auto a = new A;
    auto b = new B;
    auto c = new C;
    auto v = new V;
    auto w = new W;
    auto x = new X;
    auto y = new Y;
    auto z = new Z;
    
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

/* Output:
 (A V Y)
 (A V Z)
 (A V Y)
 (A V Z)
 (A V Y)
 (A X Z)
 (A V Y)
 (A V Z)
 (B W Y)
 (B W Y)
 (B W Y)
 (B X Z)
 (A V Y)
 (C V Z)
 (B W Y)
 (C V Z)
 (C X Y)
 (C X Y)
 */
