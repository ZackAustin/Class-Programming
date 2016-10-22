#include <iostream>
using namespace std;

void f(int, char) {cout << "int/char\n";}
void f(char, int) {cout << "char/int\n";}

int main() {
    f('a', 'b');
}