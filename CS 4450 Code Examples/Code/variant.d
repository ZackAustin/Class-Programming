// variant.d: 
import std.variant, std.stdio, std.typecons, std.conv;

void main() {
    Variant[] stuff;
    stuff ~= Variant(1);
    stuff ~= Variant(tuple(2,3));
    stuff ~= Variant("4");
    stuff ~= Variant(5.6);
    
    real sum = 0;
    foreach(x; stuff)
        if (x.type == typeid(Tuple!(int,int))) {
            auto pair = x.get!(Tuple!(int,int));
            sum += pair[0]*pair[1];
        }
        else if (x.type == typeid(string)) {
            string s = x.get!(string);
            sum += to!real(s);
        }
        else
            sum += x.get!(real);
    writeln(sum);   // 16.6

    auto stuff2 = variantArray(1,tuple(2,3),"4",5.6);
    foreach (x; stuff2)
        writeln(x);
}

/* Output:
16.6
1
Tuple!(int, int)(2, 3)
4
5.6
*/