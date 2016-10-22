// adder.d: A D version of the functions on page 202 of Webber
import std.stdio;

// Returns a function closure that links into this function (funToAddX) itself
auto funToAddX(int x) {
//    return (int y) { return x + y; };   // A shorthand function literal
    return (int y) => x+y;              // A lambda expression (parens needed in return context)
}

void main() {
   auto f = funToAddX(3);
   writeln(typeof(f).stringof);  // int delegate()
   writeln(f(5));               // 8
}
 