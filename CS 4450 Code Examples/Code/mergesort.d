// mergesort.d
import std.stdio;

void merge(int[] p,int[] q) {
   auto n = p.length, m = q.length;
   int[] temp = new int[n+m];

   // Extract in order until one empties
   int i = 0, j = 0, k = 0;
   while (i < n && j < m) {
      if (p[i] < q[j])
         temp[k++] = p[i++];
      else
         temp[k++] = q[j++];
   }
   
   // Empty out the remaining list
   if (i < n)
      temp[k..$] = p[i..$];
   else
      temp[k..$] = q[j..$];

   // Copy back to p and q (which are contiguous ranges of a larger array):
   p[0..n] = temp[0..n];
   q[0..m] = temp[n..$];
}

int[] mergesort(int[] x) {
   auto n = x.length;
   if (n > 1) {
      writefln("sorting  %d elements starting with %d",n, x[0]);
      auto m = n/2;
      merge(mergesort(x[0..m]), mergesort(x[m..$]));
   }
   else
      writefln("==> returning singleton: %d",x[0]);
   return x;
}

void main() {
   int[] a = [8,2,4,6,9,7,10,1,5,3];
   mergesort(a);
   foreach (n; a)
      writef("%d ",n);
   writeln();
}

/* Output:
sorting  10 elements starting with 8
sorting  5 elements starting with 8
sorting  2 elements starting with 8
==> returning singleton: 8
==> returning singleton: 2
sorting  3 elements starting with 4
==> returning singleton: 4
sorting  2 elements starting with 6
==> returning singleton: 6
==> returning singleton: 9
sorting  5 elements starting with 7
sorting  2 elements starting with 7
==> returning singleton: 7
==> returning singleton: 10
sorting  3 elements starting with 1
==> returning singleton: 1
sorting  2 elements starting with 5
==> returning singleton: 5
==> returning singleton: 3
1 2 3 4 5 6 7 8 9 10 
*/

