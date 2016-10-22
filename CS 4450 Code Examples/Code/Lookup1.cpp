#include <iostream>

class A;

class B
{
public:
   void f(A*){}
private:
   void f(B*){}
};

int main()
{
   B b;
   A* p;

   b.f(p);  // Okay: calls B::f(A*);
   b.f(0);  // Line 19: Overload error
   b.f(&b); // Line 20: Access error
}

/* Compiler Output (g++):
Lookup1.cpp: In function �int main()�:
Lookup1.cpp:19: error: call of overloaded �f(int)� is ambiguous
Lookup1.cpp:8: note: candidates are: void B::f(A*)
Lookup1.cpp:10: note:                 void B::f(B*)
Lookup1.cpp:10: error: �void B::f(B*)� is private
Lookup1.cpp:20: error: within this context
*/

