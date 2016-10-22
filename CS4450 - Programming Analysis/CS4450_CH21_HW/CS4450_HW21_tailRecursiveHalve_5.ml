Standard ML of New Jersey v110.75 [built: Sat Sep 29 12:51:13 2012]
- (*Zack Austin - Chapter 21 Problem 5, rewriting the Halve function Tail-Recursively - 12/15/13*)
- 
- fun halve L = 
= 	let
= 		fun halvehelp (a :: b :: cs, xs, ys) = halvehelp (cs, a::xs, b::ys)
= 		| halvehelp (a :: nil, xs, ys) = (a :: xs, ys)
= 		| halvehelp (nil, xs, ys) = (xs, ys)
= 	in
= 		halvehelp (L, nil, nil)
= 	end;
val halve = fn : 'a list -> 'a list * 'a list
- 
- halve [1];
val it = ([1],[]) : int list * int list
- halve [1,2];
val it = ([1],[2]) : int list * int list
- halve [1,2,3,4,5,6];
val it = ([5,3,1],[6,4,2]) : int list * int list
- 