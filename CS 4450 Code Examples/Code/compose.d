import std.stdio;
import std.functional;

void main() {
    auto div3 = (double x) => x/3.0;
    auto sq = (double x) => x*x;
    auto pls1 = (double x) => x+1.0;
    alias compose!(div3,sq,pls1) comp;
    writeln(comp(2.0)); // 3 == (2.0+1.0)^^2 / 3.0
    alias pipe!(div3,sq,pls1) pip;
    writeln(pip(2.0));  // 1.44444 == (2.0/3.0)^^2 + 1.0
}
