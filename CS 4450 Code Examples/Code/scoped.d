import std.stdio, std.typecons;

class Foo {
    ~this() {
        writeln("~Foo");
    }
}

void main() {
    writeln("before");

    {
//        Foo f = scoped!(Foo);
        Foo f = new Foo;    // Compare these two lines by commenting one or the other out
    }
    
    writeln("after");
}