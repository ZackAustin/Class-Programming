// Author:		Zack Austin
// Class:		CS 3370
// Date:		4/27/14
// Program:		Producer-Consumer Processing.

#include <atomic>
#include <condition_variable>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <mutex>
#include <queue>
#include <thread>
#include <array>

using namespace std;

class ProducerConsumer
{
	static queue<int> q;
	static queue<int> q2;
	static condition_variable q_cond, q2_cond;
	static mutex q_sync, print, q2_sync;
	static atomic_size_t nprod, ncon;
	static ofstream output[10];
	static int numbers[10];
public:
	static const size_t nprods = 4, ncons = 3;
	static atomic_bool quit;

	static void group(int n)
	{
		for (;;)
		{
			// Get lock for group sync mutex
			unique_lock<mutex> q2lck(q2_sync);

			q2_cond.wait(q2lck, [](){return !q2.empty() || !ncon.load(); });
			if (q2.empty() && !ncon.load())
				break;

			auto x = q2.front();

			if (x % 10 == n)
			{
				numbers[n]++;
				q2.pop();
				q2lck.unlock();

				 //Print trace of consumption
				lock_guard<mutex> plck2(print);
				output[n] << x << '\n';
			}
			else
				q2lck.unlock();
		}
	}

	static void consume()
	{
		for (;;)
		{
			// Get lock for sync mutex
			unique_lock<mutex> qlck(q_sync);

			// Wait for queue to have something to process
			q_cond.wait(qlck, [](){return !q.empty() || !nprod.load() || !q2.empty(); });
			if (q.empty() && !nprod.load() && q2.empty())
			{
				// Notify groupers that a consumer has shut down
				--ncon;
				q2_cond.notify_all();
				break;
			}

			//add numbers to second queue
			if (!q.empty())
			{
				auto x = q.front();
				q.pop();

				unique_lock<mutex> q2lck(q2_sync);
				q2.push(x);
				q2lck.unlock();
			}

			//notify grouper threads
			q2_cond.notify_all();
			qlck.unlock();
		}
	}

	static void produce()
	{
		// Generate random ints indefinitely
		while (!quit.load())
		{
			int n = rand();     // Get random int

			// Get lock for queue; push int
			unique_lock<mutex> slck(q_sync);
			q.push(n);
			slck.unlock();
			q_cond.notify_one();
		}

		// Notify consumers that a producer has shut down
		--nprod;
		q_cond.notify_all();
	}

	static void report()
	{
		for (int i = 0; i < 10; i++)
			cout << "Group " << i << " has " << numbers[i] << " numbers\n";
	}
};

queue<int> ProducerConsumer::q, ProducerConsumer::q2;
condition_variable ProducerConsumer::q_cond;
condition_variable ProducerConsumer::q2_cond;
mutex ProducerConsumer::q_sync, ProducerConsumer::print, ProducerConsumer::q2_sync;
atomic_bool ProducerConsumer::quit;
ofstream ProducerConsumer::output[] = { ofstream("group0.bin"), ofstream("group1.bin"), ofstream("group2.bin"), ofstream("group3.bin"), ofstream("group4.bin"),
										ofstream("group5.bin"), ofstream("group6.bin"), ofstream("group7.bin"), ofstream("group8.bin"), ofstream("group9.bin") };
int ProducerConsumer::numbers [] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
atomic_size_t ProducerConsumer::nprod(nprods);
atomic_size_t ProducerConsumer::ncon(ncons);

int main()
{
	vector<thread> prods, cons;
	array<thread, 10> bins;
	for (int i = 0; i < ProducerConsumer::ncons; ++i)
		cons.push_back(thread(&ProducerConsumer::consume));
	for (int i = 0; i < ProducerConsumer::nprods; ++i)
		prods.push_back(thread(&ProducerConsumer::produce));
	for (int i = 0; i < 10; ++i)
		bins[i] = thread(&ProducerConsumer::group, i);

	cout << "Press Enter to quit...";
	cin.get();
	ProducerConsumer::quit = true;

	// Join all threads
	for (auto &p : prods)
		p.join();
	for (auto &c : cons)
		c.join();
	for (auto &b : bins)
		b.join();

	ProducerConsumer::report();

	return 0;
}
