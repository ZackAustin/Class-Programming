use "memo.sml";

fun exec g = (
    print(g () ^ "\n");
    print(g () ^ "\n")
);

exec (memo (fn () => "hello"));

(* Output:
hello
found in cache
hello
val it = () : unit
*)