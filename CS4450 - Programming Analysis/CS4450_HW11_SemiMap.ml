Standard ML of New Jersey v110.75 [built: Sat Sep 29 12:51:13 2012]
- (*Additional Program -  SemiMap*)

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
datatype ('a,'b) semimap = KEY of 'a | PAIR of 'a * 'b
val stuff = [PAIR (1,"one"),KEY 2] : (int,string) semimap list
val pairCount = fn : ('a,'b) semimap list -> int
val singCount = fn : ('a,'b) semimap list -> int
val getKeys = fn : ('a,'b) semimap list -> 'a list
val getValues = fn : ('a,'b) semimap list -> 'b list
- 
- pairCount stuff;
val it = 1 : int
- singCount stuff;
val it = 1 : int
- getKeys stuff;
val it = [1,2] : int list
- getValues stuff;
val it = ["one"] : string list
- 