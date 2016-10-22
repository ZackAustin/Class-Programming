// tuple.d

import std.stdio;
import std.typecons;    // Defines Tuple and tuple

void display(string s, int n) {
    writeln("s = ",s," n = ",n);
}

void collect(T...)(T args) {    // Accepts any # of args
    auto tup = tuple(args);
    writeln("tup = ",tup);
}

void main() {
    auto person = tuple("jane doe",1234);
    writeln(person);
    display(person.expand);     // Flatten tuple into separate arguments
    collect("Century",21);      // Varargs will be collected into a tuple
    
    auto maiden = person[0];
    person[0] = "jane dough";   // Jane got married; name change
    writeln(person);
    writeln(person[0],"'s maiden name was ",maiden);

    // Using named fields (similar to C struct)
    alias Tuple!(string,"name",int,"id") Person;
    Person p;
    writeln(p);
    p.name = "john doe";
    p.id = 5678;
    writeln(p);
    p[0] = "jonathan doe";  // Can still use position #
    writeln(p);
}

/* Output:
Tuple!(string,int)("jane doe", 1234)
s = jane doe n = 1234
tup = Tuple!(string,int)("Century", 21)
Tuple!(string,int)("jane dough", 1234)
jane dough's maiden name was jane doe
Tuple!(string,"name",int,"id")("", 0)
Tuple!(string,"name",int,"id")("john doe", 5678)
Tuple!(string,"name",int,"id")("jonathan doe", 5678)
*/