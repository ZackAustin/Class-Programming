#include <typeinfo>
#include <iostream>
using namespace std;

class A {
public:
    virtual ~A(){}
};
class B : public A {
public:
};

int main() {
    A* p = new B;
    if (dynamic_cast<B*>(p))
        cout << "It's a B\n";
    cout << typeid(p).name() << endl;
    cout << typeid(*p).name() << endl;
    cout << typeid(2).name() << endl;
}
