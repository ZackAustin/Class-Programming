import std.stdio, std.string;

void main() {
    writeln("Enter a string: ");
    auto s = chomp(readln());
    write(s,": ");
    bool result = true;
    while (s.length > 1) {
        if (s[0] != s[$ - 1]) {
            result = false;
            break;
        }
        s = s[1..$-1];
    }
    writeln(result ? "palindrome" : "non-palindrome");
}
    