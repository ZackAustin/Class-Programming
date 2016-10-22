// variant2.d: Discriminated unions in D using Algebraic (a bounded Variant)
import std.variant, std.stdio, std.typecons;

alias Algebraic!(int,Tuple!(int,int)) OneTwo;

void main() {
    OneTwo[] stuff;
    stuff ~= OneTwo(1);
    stuff ~= OneTwo(tuple(2,3));
    writeln(stuff);
    writeln(sumonetwo(stuff));
}

int sumonetwo(OneTwo[] a) {
    int sum = 0;
    foreach (x; a) {
        writeln("Processing ",x);
        if (x.type == typeid(int))
            sum += x.get!(int);
        else {
            auto pair = x.get!(Tuple!(int,int));
            sum += pair[0]*pair[1];
        }
    }
    return sum;       
}

/* Output:
[1, Tuple!(int, int)(2, 3)]
Processing 1
Processing Tuple!(int,int)(2, 3)
7
*/