Standard ML of New Jersey v110.75 [built: Sat Sep 29 12:51:13 2012]
- f(x) = 1;
stdIn:1.2 Error: unbound variable or constructor: f
stdIn:1.4 Error: unbound variable or constructor: x
- 
- fun f(x) = 1;
val f = fn : 'a -> int
- fun f(x,y) = 1;
val f = fn : 'a * 'b -> int
- 
- 
- fun f(x) = 1;
val f = fn : 'a -> int
- 
- fun f2(x,y) = 1;
val f2 = fn : 'a * 'b -> int
- fun f(x) = x;
val f = fn : 'a -> 'a
- f(x,y) = x;
stdIn:10.10 Error: unbound variable or constructor: x
stdIn:10.5 Error: unbound variable or constructor: y
stdIn:10.3 Error: unbound variable or constructor: x
- fun f(x,y) = x;
val f = fn : 'a * 'b -> 'a
- fun f(g) = g(1);
val f = fn : (int -> 'a) -> 'a
- fun f(g,x) = g(x);
val f = fn : ('a -> 'b) * 'a -> 'b
- fun f(g,x,y) = g(x,y);
val f = fn : ('a * 'b -> 'c) * 'a * 'b -> 'c
- fun f(g,h,x) = g(h(x));
val f = fn : ('a -> 'b) * ('c -> 'a) * 'c -> 'b
- fun f(g,x) = g(g(x));
val f = fn : ('a -> 'a) * 'a -> 'a
- 