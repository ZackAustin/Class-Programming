Standard ML of New Jersey v110.75 [built: Sat Sep 29 12:51:13 2012]
- (*# 3*)
datatype number = integer of int
| realnum of real;
datatype number = integer of int | realnum of real
- 
- 
- (*# 4*)
fun plus (integer a) (integer b) = integer (a + b)
  | plus (realnum a) (realnum b) = realnum (a + b)
  | plus (integer a) (realnum b) = realnum (real(a) + b)
  | plus (realnum a) (integer b) = realnum (a + real(b));
val plus = fn : number -> number -> number
- plus (integer 5) (integer 5);
val it = integer 10 : number
- plus (realnum 5.0) (integer 5);
val it = realnum 10.0 : number
- 
- 
- (*# 5*)
datatype intnest =
	INT of int |
	LIST of intnest list;

	fun addup (INT a) = a
	| addup (LIST []) = 0
	| addup (LIST (b::bs)) = addup(b) + addup (LIST bs);
datatype intnest = INT of int | LIST of intnest list
val addup = fn : intnest -> int
- addup (LIST[INT 1, INT 2, INT 3]);
val it = 6 : int
- 
- 
- (*# 9*)
datatype 'data tree =
EMPTY |
NODE of 'data tree * 'data * 'data tree;

fun appendall (EMPTY) =  []
| appendall (NODE(a,b,c)) =
	appendall a @ b @ appendall c;
datatype 'a tree = EMPTY | NODE of 'a tree * 'a * 'a tree
val appendall = fn : 'a list tree -> 'a list
- val tree123 = NODE(NODE(EMPTY, 1, EMPTY),2,NODE(EMPTY,3,EMPTY));
val tree123 = NODE (NODE (EMPTY,1,EMPTY),2,NODE (EMPTY,3,EMPTY)) : int tree
- val tree123 = NODE(NODE(EMPTY, [1], EMPTY),[2],NODE(EMPTY,[3],EMPTY));
val tree123 = NODE (NODE (EMPTY,[#],EMPTY),[2],NODE (EMPTY,[#],EMPTY))
  : int list tree
- appendall tree123;
val it = [1,2,3] : int list
- 