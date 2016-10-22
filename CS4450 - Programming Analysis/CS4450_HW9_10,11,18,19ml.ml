Standard ML of New Jersey v110.75 [built: Sat Sep 29 12:51:13 2012]
- (*Zack Austin - HW 9 Problems 10,11,18,19*)
- fun duplist L = foldr(fn(a,b) => a::a::b) [] L;
val duplist = fn : 'a list -> 'a list
- duplist [1,3,2];
val it = [1,1,3,3,2,2] : int list
- 
- (*Problem 11*)
- fun mylength L = foldr(fn(a,b) => b + 1) 0 L;
val mylength = fn : 'a list -> int
- mylength [1,3,2];
val it = 3 : int
- mylength [1,3,2,4,3,4,2];
val it = 7 : int
- 
- (*Problem 18*)
- fun min L = foldr(fn(a,b) => if a <= b then a else b) (hd L) L;
val min = fn : int list -> int
- min [1,3,2,4,6,7];
val it = 1 : int
- min [8,3,2,4,6,7];
val it = 2 : int
- 
- (*Problem 19*)
- fun member (e, L) = foldr(fn(a,b) => if e  = a then true else b) false L;
stdIn:16.44 Warning: calling polyEqual
val member = fn : ''a * ''a list -> bool
- member (3, [1,2,3]);
val it = true : bool
- member (23, [1,2,3,4,5,6]);
val it = false : bool
- 