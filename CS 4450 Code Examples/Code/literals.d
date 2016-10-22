import std.stdio;

void main() {
    auto targetSalary = 15_000_000;
    writeln(targetSalary);
    auto s = r"String with a \";
    writeln(s);
    auto abc = x"616263";
    writeln(abc);
    writeln(typeid(typeof(s)));
    auto sq = (double x) { return x*x; };
    writeln(typeid(typeof(sq)));    // double delegate()
}