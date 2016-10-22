//
// States of Duck
//
#ifndef DUCK_STATE_H
#define DUCK_STATE_H
#include <iostream>
using std::string;

class Duck;
class DuckState;
enum Event { Shoot = 0, Cook = 1, Eat = 2};

class Duck
{
private:
	int duck_number;
	DuckState* state;
public:
	Duck(int num);
	void report();
	void set_state(DuckState* ds) { state = ds; }
	void stuff_happens(Event e);
};

class DuckState {
public:
	virtual void handle_event(Event e, Duck* d) = 0;
	virtual string msg() = 0;
};

class FlyingState : public DuckState {
public:
	void handle_event(Event e, Duck* d);
	static DuckState* instance();
	string msg() { return "I'm flying in the air!"; }
};
class DeadState : public DuckState {
public:
	void handle_event(Event e, Duck* d);
	static DuckState* instance();
	string msg() { return "I'm a dead duck!"; }
};
class DinnerState : public DuckState {
public:
	void handle_event(Event e, Duck* d);
	static DuckState* instance();
	string msg() { return "I'm on the dinner table!"; }
};
class GoneState : public DuckState {
public:
	void handle_event(Event e, Duck* d);
	static DuckState* instance();
	string msg() { return "There is nothing left of me!"; }
};

#endif