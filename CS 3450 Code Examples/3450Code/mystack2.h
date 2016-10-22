// MyStack2.h: Illustrates the Pimpl Idiom
#ifndef STACK_OF_INT_H
#define STACK_OF_INT_H

class Impl;    // A forward declaation for the Impl class

class StackOfInt {
public:
   StackOfInt();
   ~StackOfInt();
   void push(int);
   void pop();
   int top() const;
   int size() const;
private:
   Impl* pImpl;
};

#endif
