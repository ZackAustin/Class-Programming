import std.stdio;

void f(bool b, lazy void g) {
    if (b) {
        g;
    }
}

void main() {
    f(false, writeln("executing g"));
    f(true, writeln("executing g"));
}

/* Output:
executing g
*/
