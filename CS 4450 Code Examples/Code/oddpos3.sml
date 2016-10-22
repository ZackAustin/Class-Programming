(* oddpos3.sml: Illustrates and *)
fun oddpos nil = nil
|   oddpos (x::xs) = x::evenpos xs
and evenpos nil = nil
|   evenpos (x::xs) = oddpos(xs);

(* Sample:
- oddpos [1,2,3,4,5,6];
val it = [1,3,5] : int list
- evenpos [1,2,3,4,5,6];
val it = [2,4,6] : int list
*)
