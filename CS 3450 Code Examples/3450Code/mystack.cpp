// MyStack.cpp
#include "mystack.h"

StackOfInt::StackOfInt() {
   count = 0;
}
                                                  
void StackOfInt::push(int n) {
   if (count < MAXELEMS)
      data[count++] = n;
}

void StackOfInt::pop() {
   // Removes the top element. Call top() first to get the element.
   if (count > 0)
      --count;
}

int StackOfInt::top() const {
   return (count > 0) ? data[count-1] : STK_ERROR;
}

int StackOfInt::size() const {
   return count;
}

