// FlyBehavior.h
#ifndef FLY_BEHAVIOR_H
#define FLY_BEHAVIOR_H

class FlyBehavior {
public:
   virtual void fly() = 0;
   virtual ~FlyBehavior() {}
};

class FlyWithWings : public FlyBehavior {
public:
   void fly();
};

class FlyNoWay : public FlyBehavior {
public:
   void fly();
};

class FlyNotYet : public FlyBehavior {
public:
	void fly();
};

#endif

