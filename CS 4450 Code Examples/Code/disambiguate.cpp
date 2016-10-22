class Base1
{
public:
   virtual void f(){}
};

class Base2 : public virtual Base1
{
public:
   void f(){}
};

class Base3 : public virtual Base1
{
public:
   void f(){}
};

class Derived : public Base2, public Base3
{
public:
   void f()
   {
      // If this is what you want:
      Base2::f();
      Base3::f();
   }
};

int main()
{
   Derived d;
   d.f();
}

