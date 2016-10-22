// ArrayOfInt.h: A fixed-size array of integers
#ifndef ARRAY_OF_INT_H
#define ARRAY_OF_INT_H

class ArrayOfInt {
public:
   ArrayOfInt();
   void push_back(int);
   void pop_back();
   int back() const;
   int size() const;
private:
   enum {MAXELEMS = 10, ARRAY_ERROR = -99999};
   int data[MAXELEMS];
   int count;
};

#endif
