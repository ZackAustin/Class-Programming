import std.stdio;

void f(bool flag, lazy void exp) {
    if (flag) {
        exp;
        exp;
    }
}

void main() {
    int x;
    f(false,x+=3);
    writeln(x);     // 0
    f(true,x+=3);
    writeln(x);     // 3
}