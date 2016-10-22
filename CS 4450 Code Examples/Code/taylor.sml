(* Use streams to generate a Taylors Series *)
use "iterate.sml";

fun exp x =
    let
        fun exp1 (sofar, n, num, denom) =
            Cons (sofar, fn () => exp1(sofar+num/denom,n+1,num*x,denom*(real (n+1))))
    in
        exp1 (1.0,1,x,1.0)
    end;

(* Compute exp(x) *)    
iterate (exp 1.0, 0.0000000001);
iterate (exp 2.0, 0.0000000001);

fun next_trig_term (x, sofar, n, sn, num, denom) =
    Cons(sofar,
        fn () => next_trig_term(x,sofar+sn*num/denom,n+2,~sn,num*x*x,
                                denom*(real (n+1))*(real (n+2))));
                                
fun cos x = next_trig_term(x, 1.0, 2, ~1.0, x*x, 2.0);

(* Compute cos x *)    
iterate (cos 0.0, 0.0000000001);
iterate (cos (Math.pi/6.0), 0.0000000001);

fun sin x = next_trig_term (x, x, 3, ~1.0, x*x*x, 6.0);

(* Compute sin x *)    
iterate (sin 0.0, 0.0000000001);
iterate (sin (Math.pi/6.0), 0.0000000001);

(*
datatype 'a stream = Cons of 'a * (unit -> 'a stream) | Nil
val head = fn : 'a stream -> 'a
val tail = fn : 'a stream -> unit -> 'a stream
val force = fn : (unit -> 'a) -> 'a
val nextCons = fn : 'a stream -> 'a stream
val next = fn : 'a stream -> 'a
val filter = fn : ('a -> bool) -> 'a stream -> 'a stream
val map = fn : ('a -> 'b) -> 'a stream -> 'b stream
val list2stream = fn : 'a list -> 'a stream
val it = () : unit
val iterate = fn : real stream * real -> real
val it = () : unit
val exp = fn : real -> real stream
val it = 2.71828182846 : real
val it = 7.38905609893 : real
val next_trig_term = fn : real * real * int * real * real * real -> real stream
val cos = fn : real -> real stream
val it = 1.0 : real
val it = 0.866025403784 : real
val sin = fn : real -> real stream
val it = 0.0 : real
val it = 0.5 : real
*)