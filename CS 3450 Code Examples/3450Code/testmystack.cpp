// testmystack.cpp
#include "mystack2.h"
#include <iostream>
using namespace std;

int main() {
   StackOfInt s;
   for (int i = 0; i < 15; ++i)
      s.push(i);

   while (s.size() > 0) {
      cout << s.top() << ' ';
      s.pop();
   }
}
