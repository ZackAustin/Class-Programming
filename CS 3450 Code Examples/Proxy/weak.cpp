// Illustrates weak_ptr
#include <iostream>
#include "boost/shared_ptr.hpp"
#include "boost/weak_ptr.hpp"
using namespace std;
using namespace boost;

template<class T>
void inspect_ptr(const shared_ptr<T>& p) {
    cout << "address: " << static_cast<void*>(p.get()) << endl;
    if (p)
        cout << "contents: " << *p << endl;
    cout << "unique: " << p.unique() << endl;
    cout << "use count: " << p.use_count() << endl << endl;
}

template<class T>
void inspect_weak(const weak_ptr<T>& p) {
    cout << "use count: " << p.use_count() << endl;
    cout << "expired: " << p.expired() << endl;
    shared_ptr<T> observable(p.lock());
    cout << "observable:\n";
    inspect_ptr(observable);
    cout << endl;
}

int main() {
    shared_ptr<int> p(new int(7));
    cout << boolalpha;
    inspect_ptr(p);

    // Create a second reference
    shared_ptr<int> p2(p);
    inspect_ptr(p2);

    // Create a weak reference
    weak_ptr<int> w(p);
    inspect_weak(w);

    // Disconnect one of the shared references
    p2.reset();
    inspect_ptr(p);
    inspect_ptr(p2);
    inspect_weak(w);

    // Disconnect the last reference
    p.reset();
    inspect_ptr(p);
    inspect_ptr(p2);
    inspect_weak(w);
}
