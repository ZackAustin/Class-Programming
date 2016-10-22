// Growable base class
//

#include "FlyBehavior.h"

class Growable
{
public:
	virtual FlyBehavior* growup(FlyBehavior*) = 0;
	virtual ~Growable() {}
};


// Note: The growup() method in LearnToFly uses
// Cargill's "Transfer of Ownership" pattern, with
// its inherent advantages and pitfalls.
//
class LearnToFly : public Growable
{
public:
	FlyBehavior* growup (FlyBehavior* old) {
		delete old;
		return new FlyWithWings();
	}
};

class DontLearn : public Growable
{
public:
	FlyBehavior* growup (FlyBehavior* old) {
		return old;
	}
};
