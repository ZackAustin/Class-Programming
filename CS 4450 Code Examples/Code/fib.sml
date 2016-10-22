(* Naive and tail-recursive Fibonacci functions.
   
   Compare fib 41 to fib2 41
 *)
 
fun fib 0 = 0
|   fib 1 = 1
|   fib n = fib (n-1) + fib (n-2);

fun fib2 n =
    let
        fun fibhelp (n,a,b) = if n > 0 then fibhelp(n-1,a+b,a) else a
    in
        fibhelp (n,0,1)
    end;

fib2 43;
fib 43;   