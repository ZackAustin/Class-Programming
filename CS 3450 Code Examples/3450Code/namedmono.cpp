// namedmono.cpp: Illustrates Steve Dewhurst's Named Expanding Monostate
#include <iostream>
#include <string>
using namespace std;

// The int n is used to distinguish classes of the same type T
// (This allows multiple instances of NamedMonostate::get for the same type T below)
template<class T, int n>
struct Name {
    typedef T Type;
};

// NamedMonostate::get is a member template; unique versions are instantiated
// on demand. NOTE: The use of Name here is a parameter - it does not have to
// be "Name", but it is indeed expected to receive a template argument of the
// type Name above (did that make any sense?).
struct NamedMonostate {
    template<class Name>
    typename Name::Type& get() {
        static typename Name::Type member;
        return member;
    }
};

// Create Name instances for each desired monostate data member
// (The numbers are arbitrary)
typedef Name<string, 1> ptrname;
typedef Name<int, 1> jobcount;
typedef Name<int, 2> status;
enum Status {IDLE, BUSY, ERROR};

void ptrinit() {
    NamedMonostate theptr;
    theptr.get<ptrname>() = "HP4550";
    theptr.get<jobcount>() = 0;
    theptr.get<status>() = IDLE;
}

void display_status() {
    NamedMonostate theptr;
    cout << theptr.get<ptrname>() << ": ";
    cout << theptr.get<jobcount>() << ", ";
    cout << theptr.get<status>() << endl;
}

void submit(const string& file) {
    NamedMonostate theptr;
    ++theptr.get<jobcount>();
    theptr.get<status>() = BUSY;
    display_status();
    // Wait until job completes and then...
    --theptr.get<jobcount>();
    theptr.get<status>() = IDLE;
    display_status();
}

int main() {
    ptrinit();
    submit("myfile");
}

