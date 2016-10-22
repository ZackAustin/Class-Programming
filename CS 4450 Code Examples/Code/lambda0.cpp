// lambda0.cpp
#include <algorithm>
#include <iostream>
#include <iterator>
#include <vector>
using namespace std;

int main() {
    vector<int> v{1,2,3,4,5};
    transform(begin(v), end(v), begin(v), [](int n){return n + 10;});
    copy(begin(v), end(v), ostream_iterator<int>(cout, " "));
    cout << endl;
    
    sort(begin(v), end(v), [](int m, int n){return m > n;});
    copy(begin(v), end(v), ostream_iterator<int>(cout, " "));
    cout << endl;
}

/* Output:
11 12 13 14 15
15 14 13 12 11 
*/