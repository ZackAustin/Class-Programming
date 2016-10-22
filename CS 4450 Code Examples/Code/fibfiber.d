// fibfiber.d: Fibonacci numbers with Fibers
import std.stdio, core.thread;

class FibFiber : Fiber {
	int current = 0;
	int next = 1;
	int n;
	void run() {
		Fiber.yield();
		foreach (i; 1..n) {
			int temp = next;
			next += current;
			current = temp;
			Fiber.yield();
		}
	}
	this(int n) {
		super(&run);	// Required
		this.n = n;
	}
}

void main() {
	auto fibfib = new FibFiber(10);
	foreach (i; 0..10) {
		fibfib.call();
		writeln(fibfib.current);
	}
	fibfib.call();	// To terminate fiber (exit loop)
	assert( fibfib.state == Fiber.State.TERM );
}