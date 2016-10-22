(* Another version:

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
    
fun power2 (x,0) = 1
|   power2 (x,n) = if n mod 2 = 1 then x*power2(x,n-1) else
        let
            val z = power2(x,n div 2)
        in
            z * z
        end;
        
fun power3 (NONE, n) = power3 (SOME 2, n) 
|   power3 (SOME b, 0) = 1 
|   power3 (SOME b, n) = 
        if n mod 2 = 0 then 
            power3 (SOME (b*b), n div 2) 
        else 
            b * power3 (SOME b, n-1);        