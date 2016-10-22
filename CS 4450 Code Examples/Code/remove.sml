(* Remove all occurrences of an item from a list *)

fun remove (_,nil) = nil
|   remove (a,x::xs) = if x = a then remove (a,xs) else x::remove (a,xs);

fun remove2 (a, xs) = foldr (fn (x,sofar) => if x = a then sofar else x::sofar)
                             nil xs;
fun remove3 _ nil = nil
|   remove3 a (x::xs) = if x = a then remove3 a xs else x::remove3 a xs;
                             
fun remove4 a xs =  foldr (fn (x,sofar) => if x = a then sofar else x::sofar)
                           nil xs;

fun removeDup nil = nil
|   removeDup (x::xs) = x::removeDup (remove4 x xs);

fun removeDup2 stuff = foldr (fn (x,sofar) => x::remove4 x sofar) nil stuff;
