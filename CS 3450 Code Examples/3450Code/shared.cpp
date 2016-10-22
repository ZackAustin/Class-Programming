// Illustrates shared_ptr
#include <cassert>
#include <cstdio>
#include <iostream>
#include <stdexcept>
#include <vector>
#include "boost/shared_ptr.hpp"
using namespace std;
using namespace boost;

class Foo {
public:
    Foo(){}
    ~Foo() {
        cout << "destroying a Foo\n";
    }
};

class File {
    FILE* f;
public:
    File(const char* fname) {
        f = fopen(fname,"r");
        if (!f)
            throw runtime_error("no such file");
    }
    ~File() {
        fclose(f);
        cout << "file closed\n";
    }
};

void deleter(FILE* f) {
    fclose(f);
    cout << "FILE* closed\n";
}

int main() {
    vector<shared_ptr<Foo> > v;
    v.push_back(shared_ptr<Foo>(new Foo));
    v.push_back(shared_ptr<Foo>(new Foo));
    v.push_back(shared_ptr<Foo>(new Foo));

    // Safely use a file
    shared_ptr<File> theFile(new File("shared.cpp"));

    // The following uses a deleter, but no wrapper class!
    FILE* f = fopen("shared.cpp", "r");
    assert(f);
    shared_ptr<FILE> anotherFile(f, &deleter);

    // Could just do this (but there will be no trace)
    FILE* f2 = fopen("shared.cpp", "r");
    assert(f2);
    shared_ptr<FILE> the3rdFile(f2, &fclose);
}

/* Output:
FILE* closed
file closed
destroying a Foo
destroying a Foo
destroying a Foo
*/
