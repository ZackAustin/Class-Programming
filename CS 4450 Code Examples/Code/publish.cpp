// Illustrates private inheritance

class Base
{
public:
   void f() {}
   void g() {}
};

class Derived : Base
{
public:
   using Base::f; // makes f public for clients (overrides private)
   void h()
   {
      f();  // Derived can access non-private
      g();  // members of Base as usual.
   }
};

int main()
{
   Derived d;
   d.h();   // okay
   d.g();   // error
   d.f();   // Now okay
}

/* Compiler output:
publish.cpp: In function ‘int main()’:
publish.cpp:7: error: ‘void Base::g()’ is inaccessible
publish.cpp:25: error: within this context
publish.cpp:25: error: ‘Base’ is not an accessible base of ‘Derived’
*/


