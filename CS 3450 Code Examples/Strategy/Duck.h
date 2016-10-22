// Duck.h: The Duck Hierarchy from Chapter 1
#ifndef DUCK_H
#define DUCK_H

#include "FlyBehavior.h"
#include "QuackBehavior.h"
#include "Growable.h"

class Duck {
public:
   Duck(FlyBehavior* fb, QuackBehavior* qb, Growable* g)
      : flyBehavior(fb), quackBehavior(qb), growing(g) {}
   virtual ~Duck() {
      delete flyBehavior;
      delete quackBehavior;
   }

   void testDuck() {
	   performFly();
	   performQuack();
   }
   void swim();
   void growup();
   virtual void display() = 0;


private:
	
	void performFly() {
      flyBehavior->fly();
   }
   void performQuack() {
      quackBehavior->quack();
   }
protected:
   FlyBehavior* flyBehavior;
   QuackBehavior* quackBehavior;
   Growable *growing;
};

class MallardDuck : public Duck {
public:
   MallardDuck()
      : Duck(new FlyNoWay, new Quack, new LearnToFly) {}
   void display();
   void growup();
};

class RubberDuck : public Duck {
public:
   RubberDuck()
      : Duck(new FlyNoWay, new Squeak, new DontLearn) {}
   void display();
};

class DecoyDuck : public Duck {
public:
	DecoyDuck() :
		Duck (new FlyNoWay, new MuteQuack, new DontLearn) {}
	void display();
};


#endif

