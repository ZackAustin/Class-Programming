#include "DuckStates.h"
#include <iostream>
using namespace std;

Duck::Duck(int num) {
	duck_number = num;
	state = FlyingState::instance();
}

void Duck::report() {
	cout << "Duck number " << duck_number << ": " << state->msg() << endl;
}

void Duck::stuff_happens(Event e) {
	state->handle_event(e, this);
}

void FlyingState::handle_event(Event e, Duck* d) {
	if (e == Shoot) {
		d->set_state (DeadState::instance());
	} else {
		cout << "You can't do that! I'm flying!" << endl;
	}
}

void DeadState::handle_event(Event e, Duck* d) {
	if (e == Cook) {
		d->set_state (DinnerState::instance());
	} else {
		cout << "You can't do that to a dead duck!" << endl;
	}
}

void DinnerState::handle_event(Event e, Duck* d) {
	if (e == Eat) {
		d->set_state (GoneState::instance());
	} else {
		cout << "Are you trying to ruin your dinner?" << endl;
	}
}
void GoneState::handle_event(Event e, Duck* d) {
	// Once it's gone, it's gone!
	cout << "The Ghost of the eaten Duck will haunt you!" << endl;
}

DuckState* FlyingState::instance() {
	static FlyingState ins;
	return &ins;
}
DuckState* DeadState::instance() {
	static DeadState ins;
	return &ins;
}
DuckState* DinnerState::instance() {
	static DinnerState ins;
	return &ins;
}
DuckState* GoneState::instance() {
	static GoneState ins;
	return &ins;
}