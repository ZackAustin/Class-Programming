// ArrayOfInt.cpp
#include "ArrayOfInt.h"

ArrayOfInt::ArrayOfInt() {
   count = 0;
}
                                                  
void ArrayOfInt::push_back(int n) {
   if (count < MAXELEMS)
      data[count++] = n;
}

void ArrayOfInt::pop_back() {
   // Removes the top element. Call top() first to get the element.
   if (count > 0)
      --count;
}

int ArrayOfInt::back() const {
   return (count > 0) ? data[count-1]: ARRAY_ERROR;
}

int ArrayOfInt::size() const {
   return count;
}

