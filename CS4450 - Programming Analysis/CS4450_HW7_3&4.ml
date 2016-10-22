Standard ML of New Jersey v110.75 [built: Sat Sep 29 12:51:13 2012]
- fun less(e,nil) = nil
= |	  less(e,L::Ls) =
= 		if L >= e then less(e,Ls)
= 		else L::less(e,Ls);
val less = fn : int * int list -> int list
- 
- 
- less(10,[1,5,10,25,3,2]);
val it = [1,5,3,2] : int list
- 
- 
- fun repeats(a::nil) = false
= |	  repeats(a::b::cs) =
= 		if(a = b) then true
= 		else repeats(b::cs);
stdIn:12.8 Warning: calling polyEqual
stdIn:10.5-13.22 Warning: match nonexhaustive
          a :: nil => ...
          a :: b :: cs => ...
  
val repeats = fn : ''a list -> bool
- repeats([1,2,2,4]);
val it = true : bool
- repeats[1,2,3,4];
val it = false : bool
- 
- (*Zack Austin 9/21/13*)
- 