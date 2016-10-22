(* oddpos.sml *)
fun oddpos nil = nil
|   oddpos [a] = [a]
|   oddpos (x::y::rest) = x::(oddpos rest);

fun evenpos nil = nil
|   evenpos [a] = nil
|   evenpos (x::y::rest) = y::(evenpos rest);

oddpos([1]);
oddpos([1,2]);
oddpos([1,2,3,4,5]);
evenpos([1]);
evenpos([1,2]);
evenpos([1,2,3,4,5]);

(* Output:
[opening oddpos.sml]
val oddpos = fn : 'a list -> 'a list
val evenpos = fn : 'a list -> 'a list
val it = [1] : int list
val it = [1] : int list
val it = [1,3,5] : int list
val it = [] : int list
val it = [2] : int list
val it = [2,4] : int list
*)
