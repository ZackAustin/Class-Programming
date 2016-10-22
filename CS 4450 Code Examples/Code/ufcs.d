import std.stdio;

int f(int n) {
    return n+1;
}

int g(int n) {
    return n*2;
}

void main() {
    writeln(2.f.g);     // 6
}
