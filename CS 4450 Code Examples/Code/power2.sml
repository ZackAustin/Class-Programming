(* Uses the Russian Peasant Algorithm for efficiency *)
fun power(x,n) =
    let
	    fun phelp (_,0) = 1
	    |   phelp (arg, p) =
	        if p mod 2 = 1 then
	            arg*phelp(arg*arg, p div 2)
	        else
	            phelp(arg*arg, p div 2)
	in
	    phelp(x, n)
	end;