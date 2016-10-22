// QuackBehavior.h
#ifndef QUACK_BEHAVIOR_H
#define QUACK_BEHAVIOR_H

class QuackBehavior {
public:
   virtual ~QuackBehavior() {}
   virtual void quack() = 0;
};

class Quack : public QuackBehavior {
public:
   void quack();
};

class Squeak : public QuackBehavior {
public:
   void quack();
};

class MuteQuack : public QuackBehavior {
public:
   void quack();
};

#endif

