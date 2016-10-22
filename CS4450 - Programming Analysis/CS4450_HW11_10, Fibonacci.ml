Standard ML of New Jersey v110.75 [built: Sat Sep 29 12:51:13 2012]
- datatype 'data tree =
EMPTY |
NODE of 'data tree * 'data * 'data tree;
datatype 'a tree = EMPTY | NODE of 'a tree * 'a * 'a tree
- 
- (*# 10*)
fun isComplete EMPTY = true
    | isComplete (NODE(EMPTY, _, EMPTY)) = true
    | isComplete (NODE(Node1 as NODE(x, y, z), _, Node2 as NODE(a, b, c))) = isComplete Node1 andalso isComplete Node2
    | isComplete (NODE(_, _, _)) = false;
val isComplete = fn : 'a tree -> bool
- val tree123 = NODE(NODE(EMPTY,1,EMPTY),2,NODE(EMPTY,3,EMPTY));
val tree123 = NODE (NODE (EMPTY,1,EMPTY),2,NODE (EMPTY,3,EMPTY)) : int tree
- isComplete tree123;
val it = true : bool
- val bigTree = NODE(NODE(EMPTY,1,EMPTY),2,NODE(EMPTY,3,NODE(EMPTY,4,EMPTY)));
val bigTree = NODE (NODE (EMPTY,1,EMPTY),2,NODE (EMPTY,3,NODE #)) : int tree
- isComplete bigTree;
val it = false : bool
- 
- (*Addition Problem - Fibonacci Sequence*)
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
datatype 'a stream = Cons of 'a * (unit -> 'a stream) | Nil
val intsfrom = fn : int -> int stream
val fib = fn : 'a -> int stream
- fun force f = f ();
val force = fn : (unit -> 'a) -> 'a
- fun printStrm _ Nil = ()
|   printStrm 0 _ = ()
|   printStrm n (Cons(x,rest)) = (
        print(Int.toString x ^ "\n");
        printStrm (n-1) (force rest)
    );
[autoloading]
[library $SMLNJ-BASIS/basis.cm is stable]
[autoloading done]
val printStrm = fn : int -> int stream -> unit
- val f = fib ();
val f = Cons (0,fn) : int stream
- printStrm 10 f;
0
1
1
2
3
5
8
13
21
34
val it = () : unit
- 