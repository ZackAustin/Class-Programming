#include "Duck.h"
//#include "Turkey.h"

#include <iostream>
using namespace std;

int main() {
   Duck* pond[4];
   pond[0] = new MallardDuck;
   pond[1] = new RubberDuck;
   pond[2] = new DecoyDuck;

   for (int i = 0; i < 3; ++i) {
	   cout << endl;
	   pond[i]->display();
	   pond[i]->testDuck();
   }
   cout << "\n!!!!!   TIME PASSES !!!!!\n\n";
    for (int i = 0; i < 3; ++i) {
	   pond[i]->growup();
   }
	 for (int i = 0; i < 3; ++i) {
	   cout << endl;
	   pond[i]->display();
	   pond[i]->testDuck();
   }

}

