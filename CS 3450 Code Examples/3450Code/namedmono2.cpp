// namedmono2.cpp: Uses CRTP to create Named Expanded Monostate Classes
#include <iostream>
#include <string>
using namespace std;

template<class T, const char* CName, int n>
struct Name {
    typedef T Type;
};

template<class T>
struct NamedMonostate {
protected:
    template<class Name>
    typename Name::Type& get() {
        static typename Name::Type member;
        return member;
    }
};

struct Printer : NamedMonostate<Printer> {
    typedef Name<string, "Printer", 1> ptrname;
    typedef Name<int, "Printer", 1> jobcount;
    typedef Name<int, "Printer", 2> status;
    
    Printer() {
        get<ptrname>() = "HP4550";
        get<jobcount>() = 0;
        get<status>() = IDLE;
    }
public:
    enum Status {IDLE, BUSY, ERROR};
    
    void display_status() {
        cout << get<ptrname>() << ": ";
        cout << get<jobcount>() << ", ";
        cout << get<status>() << endl;
    }
    
    void submit(const string& file) {
        ++get<jobcount>();
        get<status>() = BUSY;
        display_status();
        // Wait until job completes and then...
        --get<jobcount>();
        get<status>() = IDLE;
        display_status();
    }
};

int main() {
    Printer ptr;
    ptr.submit("myfile");

    // Later in another context we want to access the printer
    // At this point imagine we don't know or care about ptr1.
    Printer ptr2;
    ptr2.submit("myfile2");
}

/* Output:
HP4550: 1, 1
HP4550: 0, 0
HP4550: 1, 1
HP4550: 0, 0
*/
