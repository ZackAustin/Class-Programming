// testmystack.4.cpp: Uses STL
#include "mystack3.h"
#include <deque>
#include <iostream>
using namespace std;

int main() {
   StackOfInt<deque<int> > s;
   for (int i = 0; i < 15; ++i)
      s.push(i);

   while (s.size() > 0) {
      cout << s.top() << ' ';
      s.pop();
   }
}
