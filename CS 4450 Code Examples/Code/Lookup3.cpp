#include <iostream>

class Base
{
public:
   void f(int){}
};

class Derived : public Base
{
   void f(){}
};

int main()
{
   Derived d;
   d.f(123);     // Line 17: Overload error!

   Base* p = &d;
   p->f(123);    // okay, looks in scope of Base
}

/* Compiler Output: (g++)
Lookup3.cpp: In function Ôint main()Õ:
Lookup3.cpp:17: error: no matching function for call to ÔDerived::f(int)Õ
Lookup3.cpp:11: note: candidates are: void Derived::f()
*/

