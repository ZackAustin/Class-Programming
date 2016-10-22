import std.stdio;
import std.algorithm;
void main() {
    auto values = [ 1, 2, 3, 4, 5 ];
    writeln(values
        .map!(a => a * 10)
        .map!(a => a / 3)
        .filter!(a => !(a % 2)));
}

/* Output:
[6, 10, 16]
*/
