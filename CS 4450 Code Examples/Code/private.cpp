// Illustrates private inheritance

class Base
{
public:
   void f() {}
   void g() {}
};

class Derived : private Base
{
public:
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
   d.f();   // error
}

/* Compiler output:
private.cpp: In function ‘int main()’:
private.cpp:7: error: ‘void Base::g()’ is inaccessible
private.cpp:24: error: within this context
private.cpp:24: error: ‘Base’ is not an accessible base of ‘Derived’
private.cpp:6: error: ‘void Base::f()’ is inaccessible
private.cpp:25: error: within this context
private.cpp:25: error: ‘Base’ is not an accessible base of ‘Derived’
*/


