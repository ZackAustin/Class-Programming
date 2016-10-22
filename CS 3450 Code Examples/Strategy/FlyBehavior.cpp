// FlyBehavior.cpp
#include "FlyBehavior.h"
#include <iostream>
using namespace std;

void FlyWithWings::fly() {
   cout << "I'm flying with wings!\n";
}

void FlyNoWay::fly() {
   cout << "I can't fly!\n";
}

void FlyNotYet::fly() {
	cout << "I'm too young to fly!\n";
}