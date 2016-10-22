import std.stdio, std.string;

void main() {
	// Delimited strings (brackets nest)
	auto s = q"[this is [a] string]";
	writeln(s);
	s = q"FOO
a
    multiline
        string
FOO";	// Delimiter must start in column 1
	writeln(chomp(s));

	// Raw strings
	s = r"\r\n";
	writeln(s);
	s = `\r\n`;
	writeln(s);

    // Code string
    s = q{void f() {return true;}};
    writeln(s);
}

/*
this is [a] string
a
    multiline
        string
\r\n
\r\n
void f() {return true;}
*/
