(* The following function takes the union of e and all the sets in x::rest *)
fun combine(e, nil) = nil
|   combine(e, x::rest) = (e::x)::combine(e,rest);

(* Usage
val combine = fn : 'a * 'a list list -> 'a list list
- combine(1,[nil]);
val it = [[1]] : int list list
- combine(2, [nil,[1]]);
val it = [[2],[2,1]] : int list list
*)

fun powerset nil = [nil]
|   powerset (e::rest) =
      let
        val x = powerset rest;
      in
        x @ combine(e,x)
      end;
