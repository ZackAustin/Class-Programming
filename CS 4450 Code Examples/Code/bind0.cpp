// bind0.cpp
#include <array>
#include <algorithm>
#include <functional>
#include <iostream>
#include <iterator>
using namespace std;
using namespace std::placeholders;

int main() {
    auto bf = bind(plus<int>(),10,_1);    // Fix x as 10
    cout << bf(99) << endl;               // Complete the call
    
    array<int,5> a = {1,2,3,4,5};         // New init. syntax!
    transform(a.begin(), a.end(), a.begin(), bf);
    copy(a.begin(), a.end(), ostream_iterator<int>(cout, " "));
    cout << endl;
}

/* Output:
109
11 12 13 14 15
*/