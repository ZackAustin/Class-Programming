// accumulate.cpp: Illustrates std::accumulate
#include <array>
#include <functional>
#include <iostream>
#include <numeric>
using namespace std;

int main() {
    array<int,5> nums = {1,2,3,4,5};
    cout << "sum = " << accumulate(nums.begin(),nums.end(),0) << endl;
    auto mult = [](int sofar, int next){return sofar*next;};
    cout << "product = " << accumulate(nums.begin(),nums.end(),1,mult) << endl;
    cout << "product = " << accumulate(nums.begin(),nums.end(),1,multiplies<int>()) << endl;
}

/* Output:
sum = 15
product = 120
*/
