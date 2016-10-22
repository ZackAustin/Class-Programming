class Base1 {};
class Base2 : public virtual Base1 {};
class Base3 : public virtual Base1 {};
class Derived : public Base2, public Base3 {};

int main()
{
   Derived d;
   Base1* pb1 = &d;  // Now okay
   Base2* pb2 = &d;
   Base3* pb3 = &d;
}

