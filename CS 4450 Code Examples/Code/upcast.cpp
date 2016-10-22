class Base1 {};
class Base2 {};
class Base3 {};

class Derived : public Base1, protected Base2, private Base3
{};

int main()
{
   Derived d;
   Base1* pb1 = &d;
   Base2* pb2 = &d;
   Base3* pb3 = &d;
}

/* Compiler output:
upcast.cpp: In function ‘int main()’:
upcast.cpp:12: error: ‘Base2’ is an inaccessible base of ‘Derived’
upcast.cpp:13: error: ‘Base3’ is an inaccessible base of ‘Derived’
*/

