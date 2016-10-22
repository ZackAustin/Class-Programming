// sigsum.cpp: See Slide 20 for Chapter 18
#include <iostream>
using namespace std;

void sigsum(int& n, int& ans) {
    ans = 0;
    int i = 1;
    while (i <= n)
        ans += i++;
}

int f() {
    int x = 10, y;  // y is uninitialized
    x = 10;
    sigsum(x,y);
    return y;
}

int g() {
    int x = 10;
    sigsum(x,x);
    return x;
}

int main() {
    cout << f() << '\n';    // 55
    cout << g() << '\n';    // 0
}