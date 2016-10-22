// fiber.d: Illustrates fibers (coroutines)
import std.stdio, core.thread;

class DerivedFiber : Fiber {
	this() { super( &run ); }
private :
	void run() { printf( "Derived fiber running.\n" ); }
}

void fiberFunc() {
 	printf( "Composed fiber running.\n" );
 	Fiber.yield(); 
 	printf( "Composed fiber running.\n" ); 
} 

void main() {
	// create instances of each type
	Fiber derived = new DerivedFiber();
	Fiber composed = new Fiber( &fiberFunc );
	// call both fibers once
	derived.call();
	composed.call();
	printf( "Execution returned to calling context.\n" );
	composed.call();
	// since each fiber has run to completion, each should have state TERM
	assert( derived.state == Fiber.State.TERM );
	assert( composed.state == Fiber.State.TERM );
}