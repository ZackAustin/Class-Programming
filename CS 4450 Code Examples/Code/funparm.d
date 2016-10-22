import std.stdio;

T exec(alias f,T)(T t) {
    return f(t);
}

void main() {
    int f(int n) {
        return n+1;
    }
    writeln(exec!(f)(2)); // 3
}