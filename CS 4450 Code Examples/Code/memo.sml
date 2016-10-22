(* Memoize a function with signature: unit -> string *)

fun memo f =
    let
        val first_time = ref true
        val result = ref ""
    in
        fn () =>
            if !first_time then (
                result := f();
                first_time := false;
                !result
            )
            else (
                print "found in cache\n";
                !result
            )
    end;