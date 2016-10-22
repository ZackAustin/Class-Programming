Standard ML of New Jersey v110.75 [built: Sat Sep 29 12:51:13 2012]
- (*Zack Austin - HW 9 Problems 22, 25, Additional*)
- fun evens L = foldr(fn(a,b) => if a mod 2 <> 0 then b else a::b) [] L;
val evens = fn : int list -> int list
- evens [1,2,3,4];
val it = [2,4] : int list
- evens [1,4,2,3];
val it = [4,2] : int list
- 
- (*Problem 25*)
- fun eval L = fn(x) => foldr(fn(a,b) => a + x * b) 0.0 L;
val eval = fn : real list -> real -> real
- eval [1.0, 5.0, 3.0] 2.0;
val it = 23.0 : real
- eval [0.0, ~2.0, 0.0, 1.0] 5.0;
val it = 115.0 : real
- 
- (*Addition Problem Curried Function Compose*)
- fun compose L = fn(x) => foldr(fn(a,b) => a(b)) x L;
val compose = fn : ('a -> 'a) list -> 'a -> 'a
- val c = compose [~, fn (x) => x + 1];
val c = fn : int -> int
- c 4;
val it = ~5 : int
- 