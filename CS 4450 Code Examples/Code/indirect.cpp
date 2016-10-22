class Base1 {};
class Base2 : private Base1 {};


class Derived : public Base2
{};

int main()
{
   Derived d;
   Base1* pb1 = &d;
   Base2* pb2 = &d;
}

/* Compile Output:
indirect.cpp: In function int main():
indirect.cpp:11: error: Base1 is an inaccessible base of Derived
*/

