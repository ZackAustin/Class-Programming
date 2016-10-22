// Duck.h: The Duck Hierarchy from Chapter 1
#ifndef DUCK_H
#define DUCK_H

#include "FlyBehavior.h"
#include "QuackBehavior.h"

class Duck {
public:
   Duck(FlyBehavior* fb, QuackBehavior* qb)
      : flyBehavior(fb), quackBehavior(qb) {}
   ~Duck() {
      delete flyBehavior;
      delete quackBehavior;
   }
   void performFly() {
      flyBehavior->fly();
   }
   void performQuack() {
      quackBehavior->quack();
   }
   void swim();
   virtual void display() = 0;
private:
   FlyBehavior* flyBehavior;
   QuackBehavior* quackBehavior;
};

class MallardDuck : public Duck {
public:
   MallardDuck()
      : Duck(new FlyWithWings, new Quack) {}
   void display();
};

class RubberDuck : public Duck {
public:
   RubberDuck()
      : Duck(new FlyNoWay, new Squeak) {}
   void display();
};

#endif

