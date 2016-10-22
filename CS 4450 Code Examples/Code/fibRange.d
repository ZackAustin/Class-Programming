import std.stdio;

struct fibRange {
    int end;
    int current = 0;
    int next = 1;
    int count = 0;
    int front() const {
        return current;
    }
    void popFront() {
        auto temp = current;
        current = next;
        next = temp + current;
        ++count;
    }
    bool empty() const {
        return count == end;
    }
    this(int e) {
        end = e;
    }
}

void main() {
    foreach (n; fibRange(5)) 
        writeln(n);
}