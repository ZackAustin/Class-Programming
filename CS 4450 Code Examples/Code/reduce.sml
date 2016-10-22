(* Consider how to calculate the sum of a list: *)
fun sum nil = 0
|   sum (h::t) = (op +)(h, sum t);

(* I'm using the prefix version of + for generality - most functions are prefix, not infix.
    Now consider a multiply function: *)
fun mult nil = 1
|   mult (h::t) = (op * )(h, mult t);

(* The only substantive differences between these two functions are:
    1) The "seed value" (0 vs. 1) used for the empty list
    2) The "glueing" binary operation (+ vs. * )

We can capture this pervasive list-processing pattern by making these two items
input parameters to a single, curried, higher-level function we'll call "reduce".

Just put "reduce" in front of the accumulating function and seed value: *)
    
fun reduce _ x nil = x  (* Ignore f here *)
|   reduce f x (h::t) = f (h, reduce f x t);

(* Here, f is any binary operation (+, *, etc.) in prefix form, and x is the seed value.
   We can now rewrite sum and mult in terms of reduce: *)

val sum = reduce (op +) 0;
val mult = reduce (op * ) 1;

(* Here are some other useful one-liners: *)
val anytrue = reduce (fn (x,y) => x orelse y) false;
val alltrue = reduce (fn (x,y) => x andalso y) true;
fun append a b = reduce (op ::) b a;

(* The following returns a list where f is applied to each element of the original list: *)
fun map f = reduce (fn (x, sofar) => (f x)::sofar) nil;

(* So... curried functions are *factories*, in the sense that they can generate
    families of functions from a single function definition, by means of partial
    function application. By the way, in ML reduce is called foldr ("fold-right", meaning
    it traverses the list right-to-left. There is also a foldl that traverses a list
    left-to-right. *)

(* There is a "gotcha" though! For reasons best left unexplored here, when you
    use "val" to create a function with partial application, the result can't be a
    polymorphic function (meaning it can't have any type variables). For example, the 
    following will not work:
    
val reverse = foldl (op ::) nil;    BAD!

    Since the type of the list can't be determined, this is an attempt to bind to a
    polymorphic function at the top level. NO CAN DO (you get a "value restriction"
    warning). Instead, just use fun: *)
    
fun reverse x = foldl (op ::) nil x;

(* We're not *executing* (aka "applying") a function here, just *defining* one 
   (the call to foldl is in the body of reverse, not at the top level), so ML
    doesn't complain. The examples above like sum and anytrue, worked because the results
    of the function calls weren't polymorphic (the list types were known: int or bool. 
    MORAL: to create a polymorphic function from an expression, use fun, not val. *)
