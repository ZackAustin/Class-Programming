// testmystack3.cpp: Uses templates
#include "mystack3.h"
#include "arrayofint.h"
#include <iostream>
using namespace std;

int main() {
   StackOfInt<ArrayOfInt> s;
   for (int i = 0; i < 15; ++i)
      s.push(i);

   while (s.size() > 0) {
      cout << s.top() << ' ';
      s.pop();
   }
}
