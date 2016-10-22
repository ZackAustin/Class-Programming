// fibfiber2.d: An infinite Fibonacci stream
import std.stdio, core.thread;

class FibFiber2 : Fiber {
	int current = 0;
	int next = 1;
	int n;
	bool done;
	void run() {
		Fiber.yield();
		while (!done) {
			int temp = next;
			next += current;
			current = temp;
			Fiber.yield();
		}
	}
	this() {
		super(&run);	// Required
		this.n = n;
		done = false;
	}
	void stop() {
		done = true;
	}
}

void main() {
	auto fibfib2 = new FibFiber2();
	foreach (i; 0..10) {
		fibfib2.call();
		writeln(fibfib2.current);
	}
	fibfib2.stop();	// set fibfiber2.done to true
	fibfib2.call();	// Resume to exit loop
	assert( fibfib2.state == Fiber.State.TERM );
}