import std.stdio;

void f(int[] a, int pos) {
    writeln(a[pos]);
}

void main() {
    int[] a = [1,2];
    a.f(0);     // 1
    f(a,1);     // 2
}