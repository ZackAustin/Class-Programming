import std.stdio;

struct Date {
    int month, day, year;
}

void main() {
    auto s = Date();
    writeln(s);
    s = Date(7,24);
    writeln(s);
    s.year = 2013;
    writeln(s);
    Date b = {10,1,1951};
    writeln(b);
}