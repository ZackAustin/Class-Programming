Standard ML of New Jersey v110.75 [built: Sat Sep 29 12:51:13 2012]
- (*CS4450 HW7 Problem 5*)
- fun eval(nil,x) = 0.0
= |	  eval(L::Ls, x:real) =
= 		L + x * eval(Ls,x);
val eval = fn : real list * real -> real
- 
- 
- eval([1.0,5.0,3.0],2.0);
val it = 23.0 : real
- eval([0.0,~2.0,0.0,1.0], 3.0);
val it = 21.0 : real
- eval([~3.0,5.0,~7.0,3.0],2.0);
val it = 3.0 : real
- 
- (*Zack Austin - 9/21/13*)