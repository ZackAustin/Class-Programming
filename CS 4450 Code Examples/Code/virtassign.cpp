#include <iostream>
using namespace std;

class Base1
{
   int x;
public:
   Base1(int x) {cout << "Base1(int)\n"; this->x = x;}
   Base1(const Base1& b1) {cout << "Base1(const Base1&)\n"; x = b1.x;}
   Base1& operator=(const Base1& b1)
   {
      cout << "Base1::operator=\n";
      if (this != &b1)
         x = b1.x;
      return *this;
   }
};

class Base2 : public virtual Base1
{
   int y;
public:
   Base2(int x, int y) : Base1(x) {cout << "Base2(int, int)\n"; this->y = y;}
   Base2(const Base2& b2) : Base1(b2) {cout << "Base2(const Base2&)\n"; y = b2.y;}
   Base2& operator=(const Base2& b2)
   {
      cout << "Base2::operator=\n";
      if (this != &b2)
      {
         Base1::operator=(b2);
         y = b2.y;
      }
      return *this;
   }
};

class Base3 : public virtual Base1
{
   int z;
public:
   Base3(int x, int z) : Base1(x) {cout << "Base3(int, int)\n"; this->z = z;}
   Base3(const Base3& b3) : Base1(b3) {cout << "Base3(const Base3&)\n"; z = b3.z;}
   Base3& operator=(const Base3& b3)
   {
      cout << "Base3::operator=\n";
      if (this != &b3)
      {
         Base1::operator=(b3);
         z = b3.z;
      }
      return *this;
   }
};

class Derived : public Base2, public Base3
{
   int w;
public:
   Derived(int x, int y, int z, int w)
      : Base1(x), Base2(x, y), Base3(x, z)
   {
      this->w = w;
   }
   Derived(const Derived& d)
      : Base1(d), Base2(d), Base3(d)
   {
      w = d.w;
   }
   Derived& operator=(const Derived& d)
   {
      if (this != &d)
      {
         // This is wrong!
         Base1::operator=(d);
         Base2::operator=(d);
         Base3::operator=(d);
         w = d.w;
      }
      return *this;
   }
};

int main()
{
   Derived d1(1,2,3,4);
   Derived d2(5,6,7,8);
   d2 = d1;
}

/* Output:
*/
