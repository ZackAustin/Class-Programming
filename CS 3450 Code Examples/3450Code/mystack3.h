// MyStack3.h: Makes the implementation a template parameter
// In template jagon, Impl is called a "policy"
#ifndef STACK_OF_INT_H
#define STACK_OF_INT_H

template<class Impl>
class StackOfInt {
public:
   void push(int);
   void pop();
   int top() const;
   int size() const;
private:
   Impl impl;     // Pointer not mandatory here
};

template<class Impl>
void StackOfInt<Impl>::push(int n) {
   impl.push_back(n);
}

template<class Impl>
void StackOfInt<Impl>::pop() {
   impl.pop_back();
}

template<class Impl>
int StackOfInt<Impl>::top() const {
   return impl.back();
}

template<class Impl>
int StackOfInt<Impl>::size() const {
   return impl.size();
}

#endif

