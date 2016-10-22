// MyStack2.cpp: Provides wrappers for Impl functions
#include "mystack2.h"

struct Impl {
   enum {MAXELEMS = 10, STK_ERROR = -99999};
   int data[MAXELEMS];
   int count;
};

StackOfInt::StackOfInt() {
   pImpl = new Impl;
   pImpl->count = 0;
}

StackOfInt::~StackOfInt() {
   delete pImpl;
}
                                                  
void StackOfInt::push(int n) {
   if (pImpl->count < Impl::MAXELEMS)
      pImpl->data[pImpl->count++] = n;
}

void StackOfInt::pop() {
   // Removes the top element. Call top() first to get the element.
   if (pImpl->count > 0)
      --pImpl->count;
}

int StackOfInt::top() const {
   return (pImpl->count > 0) ? pImpl->data[pImpl->count-1]
                             : Impl::STK_ERROR;
}

int StackOfInt::size() const {
   return pImpl->count;
}

