#define func(a, b) a = 6; b = 6;

#include <algorithm>
#include <cstddef>
#include <iostream>
#include <iterator>
using namespace std;

int main()
{
        int a[10] = {0};
        int index = 2;
        const size_t ASZ = sizeof(a) / sizeof(*a);
        func(index, a[index]);
        copy(a, a + ASZ, ostream_iterator<int>(cout, " "));
}

/* Outout:
0 0 0 0 0 0 6 0 0 0
*/
