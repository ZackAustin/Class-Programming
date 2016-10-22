// StackOfInt.h: A fixed-size integer stack
#ifndef STACK_OF_INT_H
#define STACK_OF_INT_H

class StackOfInt {
public:
   StackOfInt();
   void push(int);
   void pop();
   int top() const;
   int size() const;
private:
   enum {MAXELEMS = 10, STK_ERROR = -99999};
   int data[MAXELEMS];
   int count;
};

#endif
