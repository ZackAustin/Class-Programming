#include <cassert>
#include <iostream>
using namespace std;

/*
Description:
	Clients derive from this abstract class to obtain
	class reference-counting semantics. To properly
	use this class, derived classes should keep their
	constructors protected and provide a separate, static
	"create" function to clients. The create function
	should return a pointer to a new derived object on
	the heap, after calling attach() to register with
	this class. Clients then call detach() on the derived
	object to remove their interest in the counted object.
	This way multiple clients can share a derived object.
	Derived objects will not be destroyed until the last
	client calls detach().
*/

class Counted {
public:
	unsigned long attach() { return ++refCount; };
	unsigned long detach()
   {
      return (refCount > 0) ? ((--refCount > 0) ? refCount
		                                          : (delete this, 0))
		 	                   : 0;
   }

	unsigned long numClients() const { return refCount; }

protected:
	Counted(unsigned long n = 0) { refCount = n; }
	virtual ~Counted() {
      assert(refCount == 0);
      cout << "Counted object destroyed\n";
   }

private:
	unsigned long refCount;
};

// Make Resource a reference-counted class:
class Resource : public Counted {
   // Note: no public constructors!
public:
   static Resource* Create() {
      Resource* p = new Resource;
      p->attach(); // Initial attach
      return p;
   }
};

// A Client uses a Resource
class Client
{
public:
    Client(Resource* p) {
        pRes = p;
        pRes->attach();
    }
    ~Client() {pRes->detach();}

private:
    Resource* pRes;
};

int main() {
   Resource* pR;
   {
      // Create a Resource to be shared:
      pR = Resource::Create();	         // count is 1
      cout << pR->numClients() << endl;
      
      // Use the Resource in 2 clients:
      Client b1(pR);                 		// count is 2
      cout << pR->numClients() << endl;
      Client b2(pR);                 		// count is 3
      cout << pR->numClients() << endl;
      
      // Undo the original Attach:
      pR->detach();               		   // count is 2
      cout << pR->numClients() << endl;
      
      // b2.~Client() will reduce count to 1.
      // b1.~Client() will reduce count to 0
      //   after which the Resource will self-destruct.
   }
   // The following is a chancey operation!
   // (The pR has been deleted!)
   cout << pR->numClients() << endl;      // count is 0
}

/* Output:
1
2
3
2
Counted object destroyed
0
*/
