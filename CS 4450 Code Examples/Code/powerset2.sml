fun powerset2 set =
    let
        (* A function to add an element to each subset in a list *)
        fun combine (e, subsets) = map (fn aset => e::aset) subsets
    in
        foldr (fn (e, sofar) => combine(e,sofar) @ sofar) [nil] set
    end;
