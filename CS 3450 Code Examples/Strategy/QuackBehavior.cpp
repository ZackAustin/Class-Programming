// QuackBehavior.cpp
#include "QuackBehavior.h"
#include <iostream>
using namespace std;

void Quack::quack() {
   cout << "Quack!\n";
}

void Squeak::quack() {
   cout << "Squeak!\n";
}

void MuteQuack::quack() {
   cout << "<< Silence >>\n";
}

