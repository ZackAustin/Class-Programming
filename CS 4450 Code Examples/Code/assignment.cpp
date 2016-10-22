// Derived copy and assignment with simple inheritance
#include <iostream>
using namespace std;

class Base
{
   int x;
public:
   Base(int x)
   {
      this->x = x;
   }
   Base(const Base& b)
   {
      x = b.x;
   }
   Base& operator=(const Base& b)
   {
      if (this != &b)
         x = b.x;
      return *this;
   }
   friend ostream& operator<<(ostream& os, const Base& b)
   {
      return os << b.x;
   }
};

class Derived : public Base
{
   int y;
public:
   Derived(int x, int y) : Base(x)
   {
      this->y = y;
   }
   Derived(const Derived& d) : Base(d)
   {
      y = d.y;
   }
   Derived& operator=(const Derived& d)
   {
      if (this != &d)
      {
         Base::operator=(d);
         y = d.y;
      }
      return *this;
   }
   friend ostream& operator<<(ostream& os, const Derived& d)
   {
      os << static_cast<const Base&>(d);
      return os << ',' << d.y;
   }
};

int main()
{
   Derived d1(1,2);
   cout << d1 << endl;
   Derived d2(3,4);
   cout << d2 << endl;
   d2 = d1;
   cout << d2 << endl;
}

