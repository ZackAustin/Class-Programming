(* oddpos2.sml: even in terms of odd *)
fun oddpos nil = nil
|   oddpos [a] = [a]
|   oddpos (x::y::rest) = x::(oddpos rest);
    
fun evenpos nil = nil
|   evenpos (x::xs) = oddpos(xs);
