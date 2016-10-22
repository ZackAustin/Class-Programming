#include <iostream>
#include <string>
using namespace std;

template<class T>
string f(T) {
    return "yes";
}

int main() {
    cout << f(1) << endl;
    cout << f("two") << endl;
}
