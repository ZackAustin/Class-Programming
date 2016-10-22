(* power3.sml:

Uses the fact that x^n = either x^(n/2)*x^(n/2)*x
or x^(n/2)*x^(n/2), depending on whether n is odd or not. For example:
x^13 = x^(1101b) = x^(1100b)*x = x^(110b)*x^(110b)*x

*)

fun power(x,0) = 1
|   power(x,n) =
    let
	    val s = power(x, n div 2)
    in
        if n mod 2 = 1 then s*s*x else s*s
    end;
