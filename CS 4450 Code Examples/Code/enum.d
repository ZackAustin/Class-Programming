import std.stdio;

enum x = 1;
enum Foo {y = 1,z};
enum Bar : byte {a,b,c};

void main() {
    writeln(x,',',typeof(x).stringof);
    writeln(Foo.y,',',cast(int) Foo.y,',',typeof(Foo.y).stringof);
    writeln(Foo.z,',',cast(int) Foo.z,',',typeof(Foo.z).sizeof);
    writeln(Bar.a,',',cast(int) Bar.a,',',typeof(Bar.a).sizeof);
    writeln(Bar.b,',',cast(int) Bar.b);
    writeln(Bar.c,',',cast(int) Bar.c);
}

/* Output
1,int
y,1,Foo
z,2,4
a,0,1
b,1
c,2
*/
