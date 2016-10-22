// Duck.cpp
#include "Duck.h"
#include <iostream>
using namespace std;

void Duck::growup()
{
	flyBehavior = growing->growup (flyBehavior);
}

void Duck::swim() {
   cout << "All ducks float, even decoys!\n";
}

void MallardDuck::display() {
   cout << "I'm a real mallard duck!\n";
}

void RubberDuck::display() {
   cout << "I'm a rubber duck!\n";
}


void DecoyDuck::display() {
   cout << "I'm a decoy duck!\n";
}
