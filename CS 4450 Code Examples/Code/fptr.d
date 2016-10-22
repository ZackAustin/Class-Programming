import std.stdio;

int f1(int n) {return n+1;}
int f2(int n) {return n+2;}
int f3(int n) {return n+3;}

void main() {
    auto funs = [&f1, &f2, &f3];
    foreach (f; funs)
        writeln(f(1));
    writeln(typeof(f1).stringof);
    writeln(typeof(&f1).stringof);
}