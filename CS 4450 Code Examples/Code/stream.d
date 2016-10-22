import std.concurrency, std.stdio, std.exception;

void fibstream() {
    int curr = 0, next = 1;
    bool term = false;
    while (!term)
        receive(
            (Tid tid) {
                tid.send(curr);
                int temp = curr + next;
                curr = next;
                next = temp;
            },
            (OwnerTerminated x) {term = true;}
        );
}

void oddstream() {
    int curr = 1;
    bool term = false;
    while (!term)
        receive(
            (Tid tid) {tid.send(curr); curr += 2;},
            (OwnerTerminated x) {term = true;}
        );
}

void sumstream(Tid caller, Tid stream) {
    int sum = 0;
    bool term = false;
    while (!term)
        receive(
            (Tid tid) {
                enforce(tid == caller);
                stream.send(thisTid);
                sum += receiveOnly!int();
                caller.send(sum);
            },
            (OwnerTerminated x) {term = true;}
        );
}

void main() {
    Tid tid = spawn(&sumstream, thisTid, spawn(&oddstream));
    foreach (i; 0..10) {
        tid.send(thisTid);
        writeln(receiveOnly!int());
    }
}