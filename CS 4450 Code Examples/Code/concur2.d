// Interleaved execution
import std.stdio, std.concurrency, std.exception, std.typecons;

void main() {
    auto low = 0, high = 100;
    auto tid = spawn(&writer);
    foreach(i; low..high) {
        writeln("Main thread: ", i);
        tid.send(thisTid, i);
        enforce(receiveOnly!Tid() == tid);
    }
}

void writer() {
    bool term = false;
    while (!term) {
        receive(
            (Tid tid, int msg) {writeln("Secondary thread: ", msg); tid.send(thisTid);},
            (OwnerTerminated x) {term = true;}
        );
    }
}