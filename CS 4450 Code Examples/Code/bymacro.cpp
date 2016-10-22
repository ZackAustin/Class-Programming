// bymacro.cpp: Illustrates call-by-macro-expansion with expressions
// Consider the following:
//          procedure sub1(x: int; y: int; z: int);
//            begin
//	            k := 1;         // k is global
//              y := x;         // y = k + 1 == 2
//              k := 5;
//              z := x;         // z = k + 1 == 6
//            end;
//         
//          sub1(k+1, j, i);   // k is global


#include <iostream>
using namespace std;

int i, j, k;

#define sub1(x, y, z)   \
   k = 1;               \
   y = x;               \  // j = 1+1
   k = 5;               \
   z = x;               \  // i = 5+1

int main()
{
   sub1(k+1, j, i);
   cout << i << ',' << j << ',' << k << endl;
}

/* Output:
6,2,5
*/

