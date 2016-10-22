// crtp.cpp
#include <iostream>
using namespace std;

template<class T>       
class Base {
protected:
   static int n;
public:
   static int getCount() {
      return n;
   }
};

template<class T>
int Base<T>::n = 0;

class A : public Base<A> {
public:
   A() {
      ++n;
   }
};

class B : public Base<B> {
public:
   B() {
      ++n;
   }
};

int main() {
   A a1, a2, a3;
   cout << A::getCount() << endl; // 3
   B b;
   cout << B::getCount() << endl; // 1
}
