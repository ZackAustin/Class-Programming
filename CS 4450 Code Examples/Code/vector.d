// Shows array-wise expressions

// Note: results of array-wise ops must be stored in a
// pre-allocated variable of exact size.

import std.algorithm;
import std.stdio;

int dotprod(int[] x, int[] y) {
    auto prod = new int[x.length];
    prod[] = x[]*y[];
    return reduce!((a,b)=>a+b)(prod);
}

void main() {
    auto a = [1, 2, 3];
    auto b = [4, 5, 6];
    auto c = new int[3];
    c[] = a[] * b[] + 1;
    writeln(c);             // [5 11 19]
    writeln(dotprod(a,b));  // 32 (= 4 + 10 + 18)
//    writeln(c[]+1);         // ERROR: can't use expression (not assigned to pre-allocated result)
}