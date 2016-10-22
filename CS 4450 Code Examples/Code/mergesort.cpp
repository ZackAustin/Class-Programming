// mergesort.cpp (Array version - very efficient)
#include <cassert>
#include <cstddef>
#include <iostream>
using namespace std;

void merge(int* p, int n, int* q, int m) {
   enum {MAXLEN = 1000};
   assert(m + n <= MAXLEN);
   static int temp[MAXLEN];

   // First, extract in order until one empties
   int i = 0, j = 0, k = 0;
   while (i < n && j < m)
      if (p[i] < q[j])
         temp[k++] = p[i++];
      else
         temp[k++] = q[j++];

   // Empty out the remaining list
   while (i < n)
      temp[k++] = p[i++];
   while (j < m)
      temp[k++] = q[j++];

   // Copy back to p:
   cout << "\tmerged: ";
   for (int i = 0; i < n+m; ++i) {
      cout << temp[i] << " ";
      p[i] = temp[i];
   }
   cout << endl;
}

int* mergesort(int* x, int n) {
   if (n > 1) {
      cout << "sorting " << n << " elements starting with " << *x << endl;
      int nleft = n/2;
      int nright = n - nleft;
      merge(mergesort(x,nleft), nleft, mergesort(x+nleft,nright), nright);
   }
   else
      cout << "==> returning singleton: " << *x << endl;
   return x;
}

int main() {
//   int a[] = {8,2,4,6,9,7,10,1,5,3};
   int a[] = {5,4,3,2,1};
   size_t n = sizeof a / sizeof a[0];
   mergesort(a, n);
   for (int i = 0; i < n; ++i)
      cout << a[i] << ' ';
   cout << endl;
}

/* Output:
sorting 10 elements starting with 8
sorting 5 elements starting with 7
sorting 3 elements starting with 1
sorting 2 elements starting with 5
==> returning singleton: 3
==> returning singleton: 5
	      merged: 3 5 
==> returning singleton: 3
==> returning singleton: 1
	      merged: 1 3 5 
==> returning singleton: 1
sorting 2 elements starting with 7
==> returning singleton: 10
==> returning singleton: 7
	      merged: 7 10 
==> returning singleton: 7
	      merged: 1 3 5 7 10 
==> returning singleton: 1
sorting 5 elements starting with 8
sorting 3 elements starting with 4
sorting 2 elements starting with 6
==> returning singleton: 9
==> returning singleton: 6
	      merged: 6 9 
==> returning singleton: 6
==> returning singleton: 4
	      merged: 4 6 9 
==> returning singleton: 4
sorting 2 elements starting with 8
==> returning singleton: 2
==> returning singleton: 8
	      merged: 2 8 
==> returning singleton: 2
	      merged: 2 4 6 8 9 
==> returning singleton: 2
	      merged: 1 2 3 4 5 6 7 8 9 10 
==> returning singleton: 1
1 2 3 4 5 6 7 8 9 10 
*/

