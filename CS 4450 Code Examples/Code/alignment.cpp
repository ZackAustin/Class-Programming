#include <iostream>
using namespace std;

struct Foo {
    double x;
    char y;
    double z;
};

int main() {
    cout << sizeof(Foo);
}
