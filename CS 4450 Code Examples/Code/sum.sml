use "stream.sml";

fun sum Nil = Cons(0, fn () => Nil)
|   sum strm =
    let
        fun next_term (sofar, s) =
            Cons (sofar, fn () =>
                case s of
                    Nil => Nil |
                    _ => next_term(sofar + head s, tail s));
    in
        next_term (head strm, tail strm)
    end;

fun sum2 Nil = Cons(0, fn () => Nil)
|   sum2 (Cons(a,rest)) =
    let
        fun next_term (sofar, s) =
            Cons (sofar, fn () =>
                case s of
                    Nil => Nil |
                    _ => next_term(sofar + head s, tail s))
    	val seed = 0 + a
    in
        next_term (seed, force rest)
    end;

fun foldl_ _ init Nil = Cons(init, fn () => Nil)
|   foldl_ f init (Cons(a,rest)) =
    let
        fun next_node (sofar, s) =
            Cons (sofar, fn () =>
                case s of
                    Nil => Nil |
                    _ => next_node(f (head s,sofar), tail s))
    	val seed = f(a,init)
    in
        next_node (seed, force rest)
    end;
