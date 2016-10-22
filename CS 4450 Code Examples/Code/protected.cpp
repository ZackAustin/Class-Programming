// Illustrates protected inheritance

class Base
{
public:
   void f() {}
   void g() {}
};

class Derived : protected Base
{};

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
   m.f();   // error
   d.f();   // error
}

/* Compiler Output:
Error E2247 c:\uvsc\spring02\3370\protected.cpp 29: 'Base::f()' is not accessible in function main()
Error E2247 c:\uvsc\spring02\3370\protected.cpp 30: 'Base::f()' is not accessible in function main()
*/
