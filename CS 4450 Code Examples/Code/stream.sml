(* stream.sml: Based on work on streams in Abelson and Sussman *)
datatype 'a stream  = Nil | Cons of 'a * (unit -> 'a stream); 

fun head Nil = raise Empty
|   head (Cons(h,_)) = h; 

fun thunk Nil = raise Empty
|   thunk (Cons(_,t)) = t;

fun force f = f ();

fun tail s = force (thunk s);   (* Same as (thunk s)() *)

fun next Nil = raise Empty
|   next c = head (tail c);

fun nth 0 s = head s
|   nth n s = nth (n-1) (tail s);

fun filter _ Nil = Nil
|   filter f (Cons (h,t)) =
	if (f h) then
		Cons (h, fn () => filter f (force t))
    else
		filter f (force t);

fun map_ _ Nil = Nil
|   map_ f (Cons(h,t)) = Cons(f h, fn() => map_ f (force t));

(* foldl_ gives a stream of intermediate results *)
fun foldl_ _ c Nil = Cons(c, fn() => Nil)
|   foldl_ f c (Cons(h,t)) =
	let
		val v = f (h,c)
	in
		Cons(v, fn () => foldl_ f v (force t))
	end;

fun drop _ Nil = Nil
|   drop 0 strm = strm
|   drop n (Cons(_,t)) = drop (n-1) (force t);

fun printStrm _ Nil = ()
|   printStrm 0 _ = ()
|   printStrm n (Cons(x,rest)) = (
        print(Int.toString x ^ "\n");
        printStrm (n-1) (force rest)
    );

fun strm2list _ Nil = nil
|   strm2list 0 _ = nil
|   strm2list n (Cons(h,t)) = h::(strm2list (n-1) (force t));

fun list2strm nil = Nil
|   list2strm (h::t) = Cons(h, fn () => list2strm t);
