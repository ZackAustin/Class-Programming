#include <iostream>
#include <string>
using namespace std;

template<class Iter, class F>
void forEach(Iter start, Iter stop, F f) {
    while (start != stop)
        f(*start++);
}

template<class T>
void f(const T& t) {
    cout << t << endl;
}

int main() {
    string a[] = {"one", "two", "three"};
    forEach(a, a+3, &f<string>);
}
