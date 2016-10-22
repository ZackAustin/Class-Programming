Standard ML of New Jersey v110.75 [built: Sat Sep 29 12:51:13 2012]
- (*Zack Austin - HW 9 Problems 3,5,9 *)
- fun squarelist L = map(fn(a) => a * a) L;
val squarelist = fn : int list -> int list
- squarelist [1,2,3,4,5];
val it = [1,4,9,16,25] : int list
- 
- (*Problem 5*)
- fun inclist L = fn(a) => map(fn(x) => x + a) L;
val inclist = fn : int list -> int -> int list
- inclist [1,2,3,4] 10;
val it = [11,12,13,14] : int list
- 
- (*Problem 9*)
- fun bxor L = foldr(fn(a,b) => if a = b then false else true) false L;
val bxor = fn : bool list -> bool
- bxor [];
val it = false : bool
- bxor [true];
val it = true : bool
- bxor [true, false];
val it = true : bool
- bxor [true, false, true, false];
val it = false : bool
- 