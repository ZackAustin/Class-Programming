class Base1 {};
class Base2 : public Base1 {};
class Base3 : public Base1 {};
class Derived : public Base2, public Base3 {};

int main()
{
   Derived d;
   Base1* pb1 = &d;
   Base2* pb2 = &d;
   Base3* pb3 = &d;
}

/* Compiler Output:
ambiguous.cpp: In function ‘int main()’:
ambiguous.cpp:9: error: ‘Base1’ is an ambiguous base of ‘Derived’
*/


