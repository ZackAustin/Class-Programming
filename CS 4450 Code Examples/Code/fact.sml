(* A total factorial function *)

fun factorial n =
	let
		fun fact 0 = 1
		|   fact m = m * fact (m-1)
	in
		case Int.compare(n,0) of
			GREATER => SOME (fact n)
	      | EQUAL => SOME 1
	      | LESS => NONE
	end;
	
factorial 5;

fun processfac n =
    case factorial n of
        SOME m => Int.toString m |
        NONE => "undefined";
        
processfac 5;
processfac ~1;

getOpt (factorial 5,0);
getOpt (factorial ~1,0);

(* Output:
val factorial = fn : int -> int option
val it = SOME 120 : int option
val processfac = fn : int -> string
val it = "120" : string
val it = "undefined" : string
val it = 120 : int
val it = 0 : int
*)
