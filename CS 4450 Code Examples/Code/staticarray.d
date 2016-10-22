import std.stdio;

void f(int[3] data) {   // Passed by value
    writeln(typeid(typeof(data)));
    data[0] = 100;
}

void g(int[] data) {    // Passed by reference
    writeln(typeid(typeof(data)));
    data[0] = 100;
}

void main() {
    int[3] a = [1,2,3];
    f(a);
    foreach (n; a) writeln(n);
    g(a);
    foreach (n; a) writeln(n);

    a = a.init;
    writeln(a);
}

/* Output:
int[3]
1
2
3
int[]
100
2
3
*/