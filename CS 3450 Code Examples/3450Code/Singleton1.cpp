// Singleton1.cpp: Uses a local static
#include <iostream>
using namespace std;

class Singleton {
   int theData;
   Singleton() {
      theData = 2;
   }
public:
   static Singleton& getInstance() {
      static Singleton theInstance;
      return theInstance;
   }
   int getData() const {
      return theData;
   }
};

int main() {
   Singleton& s = Singleton::getInstance();
   cout << s.getData() << endl;
}
