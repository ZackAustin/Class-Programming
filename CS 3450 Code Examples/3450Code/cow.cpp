#include <cassert>
#include <iostream>
#include <cstring>
using namespace std;

// String cooperates with its Proxy (Impl) to copy on write.
class String {
    // The Proxy - keeps a reference count
    struct Impl {
        char* stuff;    // The actual character sequence
        int count;      // The reference count
        Impl(const char* s) {
            strcpy(stuff = new char[strlen(s) + 1], s);
            count = 1;
        }
        ~Impl() {
            assert(count == 0);
            cout << "Deleting character array at: " << &stuff << endl;
            delete [] stuff;
        }
    };

    // String's only data
    Impl* pImpl;

    void attach(Impl* p) {
        pImpl = p;
        ++pImpl->count;
    }
    void detach() {
        if (--pImpl->count == 0) {
            cout << "deleting string at " << &pImpl->stuff << endl;
            delete pImpl;
        }
    }
public:
    String(const char* s = "") {
        pImpl = new Impl(s);
    }
    String(const String& s) {
        attach(s.pImpl);
    }
    String& operator=(const String& s) {
        if (this != &s) {
            detach();
            attach(s.pImpl);
        }
        return *this;
    }
    ~String() {
        cout << "String destructor (" << &pImpl << ")\n";
        detach();
    }
    void write(int pos, char c) {
        if (pImpl->count > 1) {
            // Make a unique copy
            Impl* p = new Impl(pImpl->stuff);
            --pImpl->count;
            pImpl = p;
        }
        if (pos < strlen(pImpl->stuff))
            pImpl->stuff[pos] = c;
    }
    void audit() const {
        cout << "contents = " << pImpl->stuff << endl;
        cout << "address = " << &pImpl->stuff << endl;
        cout << "count = " << pImpl->count << endl << endl;
    }
};

int main() {
    String s1("hello");
    s1.audit();
    String s2(s1);
    s2.audit();
    String s3;
    s3.audit();
    s3 = s2;
    s3.audit();
    s3.write(0,'j');
    s3.audit();
    s2.audit();
    s1.audit();
}

