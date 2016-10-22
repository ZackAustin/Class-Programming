#include <iostream>
using namespace std;

class Base {
public:
    void theAlgorithm() {
        fixedop1();
        missingop1();
        fixedop2();
        missingop2();
    }
    void fixedop1() {
        cout << "fixedop1\n";
    }
    void fixedop2() {
        cout << "fixedop2\n";
    }
    virtual void missingop1() = 0;
    virtual void missingop2() = 0;
};

class Derived : public Base {
    void missingop1() {
        cout << "missingop1\n";
    }
    void missingop2() {
        cout << "missingop2\n";
    }
};

int main() {
    Derived d;
    d.theAlgorithm();
}
