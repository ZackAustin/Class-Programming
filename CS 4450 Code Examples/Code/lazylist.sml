(* Reference: http://lyle.smu.edu/~yuhangw/classes/cse3342_f09/slides-10-1-2009.pdf *)

datatype 'a lazyList  = Nil | Cons of 'a * (unit -> 'a lazyList); 

fun head Nil = raise Empty
|   head (Cons(h,_)) = h; 

fun tail Nil = raise Empty
|   tail (Cons(_,t)) = t;

fun next Nil = raise Empty
|   next (Cons(_,t)) = case t() of
        Nil => raise Empty |
        x as _ => head x;

fun intfrom k = Cons(k, fn () => intfrom (k+1));

fun isOdd Nil = Nil
|   isOdd (Cons (n, rest)) = Cons(n mod 2 = 0, fn () => isOdd (rest()));

val nums = intfrom 5;
head nums;
next nums;
val bools = isOdd nums;
head bools;
next bools;

(*
datatype 'a lazyList = Cons of 'a * (unit -> 'a lazyList) | Nil
val head = fn : 'a lazyList -> 'a
val tail = fn : 'a lazyList -> unit -> 'a lazyList
val next = fn : 'a lazyList -> 'a
val intfrom = fn : int -> int lazyList
val isOdd = fn : int lazyList -> bool lazyList
val nums = Cons (5,fn) : int lazyList
val it = 5 : int
val it = 6 : int
val bools = Cons (false,fn) : bool lazyList
val it = false : bool
val it = true : bool
*)

fun force f = f ();
