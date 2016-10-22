(*Zack Austin - Homework 11 - 10/30/13*)

(*# 3*)
datatype number = integer of int
| realnum of real;

(*# 4*)
fun plus (integer a) (integer b) = integer (a + b)
  | plus (realnum a) (realnum b) = realnum (a + b)
  | plus (integer a) (realnum b) = realnum (real(a) + b)
  | plus (realnum a) (integer b) = realnum (a + real(b));

(*# 5*)
datatype intnest =
	INT of int |
	LIST of intnest list;

	fun addup (INT a) = a
	| addup (LIST []) = 0
	| addup (LIST (b::bs)) = addup(b) + addup (LIST bs);

(*# 9*)
datatype 'data tree =
EMPTY |
NODE of 'data tree * 'data * 'data tree;

fun appendall (EMPTY) =  []
| appendall (NODE(a,b,c)) =
	appendall a @ b @ appendall c;

(*# 10*)
fun isComplete EMPTY = true
    | isComplete (NODE(EMPTY, _, EMPTY)) = true
    | isComplete (NODE(Node1 as NODE(x, y, z), _, Node2 as NODE(a, b, c))) = isComplete Node1 andalso isComplete Node2
    | isComplete (NODE(_, _, _)) = false;

(*Addition Problem - Fibonacci Sequence*)
datatype 'a stream = Nil | 
   Cons of 'a * (unit -> 'a stream);
   (* A function to generate an infinite sequence of integers *)
	fun intsfrom k = Cons(k, fn () => intsfrom (k+1));

fun fib a = 
	let
		fun doFib a b = Cons(a, fn () => doFib b (a+b))
	in
		doFib 0 1
	end;

(*Additional Program -  SemiMap*)

datatype ('a, 'b) semimap =
KEY of 'a |
PAIR of ('a * 'b);

val stuff = [PAIR (1,"one"), KEY 2];

(*pairCount – returns the number of pairs in the semimap*)

fun pairCount nil = 0
| 	pairCount (KEY _::Ls) = 0 + pairCount(Ls)
|   pairCount (PAIR(_,_)::Ls) = 1 + pairCount(Ls);

(*singCount – returns the number of single keys in the semimap*)

fun singCount nil = 0
| 	singCount (KEY _::Ls) = 1 + singCount(Ls)
|   singCount (PAIR(_,_)::Ls) = 0 + singCount(Ls);

(*getKeys - return all keys in semimap as a list*)

fun getKeys nil = []
|   getKeys (KEY(a)::Ls) = [a] @ getKeys(Ls)
|   getKeys (PAIR(a, _)::Ls) = [a] @ getKeys(Ls);

(*getValues - return all values in semimap as a list*)

fun getValues nil = []
|   getValues (KEY(_)::Ls) = getValues(Ls)
|   getValues (PAIR(_, b)::Ls) = [b] @ getValues(Ls);