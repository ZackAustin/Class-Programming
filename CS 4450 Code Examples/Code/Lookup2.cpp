#include <iostream>

class Base
{
public:
   void f(){}
};

class Derived : public Base
{
   void f(){}
};

int main()
{
   Derived d;
   d.f();     // Line 17: Access error!
}

/* Compiler Output (g++):
Lookup2.cpp: In function �int main()�:
Lookup2.cpp:11: error: �void Derived::f()� is private
Lookup2.cpp:17: error: within this context
*/

