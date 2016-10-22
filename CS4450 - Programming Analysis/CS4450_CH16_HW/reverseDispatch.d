//Zack Austin - Chapter 16 HW Additional Problem, Multiple Dispatch - 12/3/13

import std.stdio;

/* Reverse Possible Combinations (in ascending "most derived" order); existing methods marked*:
Y V A*
Y V B
Y V C
Y W A
Y W B*
Y W C
Y X A
Y X B
Y X C*
Z V A*
Z V B
Z V C*
Z W A
Z W B
Z W C
Z X A*
Z X B*
Z X C
*/

/* Reverse keeping only existing methods:
Z X B*
Z X A*
Z V C*
Y X C*
Y W B*
Y V A*
*/

class A {};
class B : A {};
class C : B {};
class V {};
class W : V {};
class X : W {};
class Y {};
class Z : Y {};

string dispatch(Y y, V v, A a)
{
    B b = cast(B) a;
    C c = cast(C) a;
	W w = cast(W) v;
	X x = cast(X) v;
	Z z = cast(Z) y;

    if (z)
	{
		if (x && b)
		{
			return "(Z X B)";
		}
		if (x)
		{
			return "(Z X A)";
		}
		return "(Z V C)";
	}

	// Y
	if (x)
	{
		return "(Y X C)";
	}
	if (w)
	{
		return "(Y W B)";
	}
	return "(Y V A)";
}

void f(Y y, V v, A a)
{
    writeln(dispatch(y,v,a));
}

void main()
{
    auto a = new A;
    auto b = new B;
    auto c = new C;
    auto v = new V;
    auto w = new W;
    auto x = new X;
    auto y = new Y;
    auto z = new Z;

    f(y,v,a);
    f(z,v,a);
    f(y,w,a);
    f(z,w,a);
    f(y,x,a);
    f(z,x,a);
    f(y,v,b);
    f(z,v,b);
    f(y,w,b);
    f(z,w,b);
    f(y,x,b);
    f(z,x,b);
    f(y,v,c);
    f(z,v,c);
    f(y,w,c);
    f(z,w,c);
    f(y,x,c);
    f(z,x,c);
}

/* Output:
(Y V A)
(Z V C)
(Y W B)
(Z V C)
(Y X C)
(Z X A)
(Y V A)
(Z V C)
(Y W B)
(Z V C)
(Y X C)
(Z X B)
(Y V A)
(Z V C)
(Y W B)
(Z V C)
(Y X C)
(Z X B)
*/
