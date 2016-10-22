// varargs.d

import std.stdio;
import std.typecons;

// Homogeneous args (passed as dynamic array)
void f(int[] args...) {
    foreach (n; args)
        writef("%d ",n);
    writeln();
}

// Heterogeneous args (passed as tuple)
void g(T...)(T args) {
    writeln(typeof(args).stringof);
    foreach (i,x; args)
        writeln(typeid(T[i]),": ",x);
    writeln(args[2].expand);    // Same as writeln(1,"one")
}

void main () {
    f(1,2,3);
    f(4,5,6,7);
    g(1,"one",tuple(1,"one"),[1.0,2.0]);
}

/* Output:
1 2 3 
4 5 6 7 
(int, string, Tuple!(int,string), double[])
int: 1
immutable(char)[]: one
std.typecons.Tuple!(int,string).Tuple: Tuple!(int,string)(1, "one")
double[]: [1, 2]
1one
*/