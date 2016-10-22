// bind1.cpp: bind2nd capability
#include <algorithm>
#include <functional>
#include <iostream>
#include <iterator>
using namespace std;
using namespace std::placeholders;

int main() {
    int a[] = {1,2,3,4,5};
    auto f = bind(greater<int>(),_1,3);
    transform(a,a+5,a,f);
    copy(a,a+5,ostream_iterator<int>(cout," "));
    cout << endl;
}

/* Output (which are greater than 3?):
0 0 0 1 1
*/