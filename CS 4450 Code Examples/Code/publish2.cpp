// Illustrates protected inheritance

class Base
{
public:
   void f() {}
   void g() {}
};

class Derived : protected Base
{
public:
   using Base::f;
};

class MoreDerived : public Derived
{
public:
   void h()
   {
      f();  // f and g are protected as far
      g();  // as MoreDerived is concerned
   }
};

int main()
{
   Derived d;
   MoreDerived m;

   m.h();   // okay
   m.f();   // okay
   d.f();   // okay
   m.g();   // error
   d.g();   // error
}

/* Compiler Output:
publish2.cpp: In function ‘int main()’:
publish2.cpp:7: error: ‘void Base::g()’ is inaccessible
publish2.cpp:34: error: within this context
publish2.cpp:34: error: ‘Base’ is not an accessible base of ‘MoreDerived’
publish2.cpp:7: error: ‘void Base::g()’ is inaccessible
publish2.cpp:35: error: within this context
publish2.cpp:35: error: ‘Base’ is not an accessible base of ‘Derived’
*/
