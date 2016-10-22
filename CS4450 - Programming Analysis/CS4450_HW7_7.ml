Standard ML of New Jersey v110.75 [built: Sat Sep 29 12:51:13 2012]
- (*CS4450 HW7 Problem 7*)
- fun pivotCompare(n,f) =
= 		if n < f then true else false;
val pivotCompare = fn : int * int -> bool
- 
- fun quicksort(nil,f) = nil
= |	  quicksort(pivot :: rest, f) =
= 		let 
= 			fun split(nil) = (nil,nil)
= 			|	split(x :: xs) =
= 					let 
= 						val(below,above) = split(xs)
= 					in
= 						if f(x,pivot) then (x :: below, above)
= 						else (below, x :: above)
= 					end;
= 			val (below, above) = split(rest)
= 		in
= 			quicksort(below,f) @ [pivot] @ quicksort(above,f)
= 		end;
val quicksort = fn : 'a list * ('a * 'a -> bool) -> 'a list
- 
- quicksort ([4,3,2,1], pivotCompare);
val it = [1,2,3,4] : int list
- quicksort ([4,2,3,1,5,3,6],pivotCompare);
val it = [1,2,3,3,4,5,6] : int list
- 
- 
- (*Zack Austin - 9/21/13*)