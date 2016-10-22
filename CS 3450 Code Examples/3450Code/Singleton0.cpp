// Singleton0.cpp: Uses a static pointer
#include <iostream>
using namespace std;

class Singleton {
   int theData;
   static Singleton* theInstance;
   Singleton() {
      theData = 2;
   }
public:
   static Singleton* getInstance() {
      if (!theInstance)
		  theInstance = new Singleton;
      return theInstance;
   }
   int getData() const {
      return theData;
   }
};

Singleton* Singleton::theInstance = 0;

int main() {
   Singleton* s = Singleton::getInstance();
   cout << s->getData() << endl;
}

