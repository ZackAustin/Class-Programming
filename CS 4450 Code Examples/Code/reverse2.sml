fun reverse stuff =
    let
        fun rev (nil, sofar) = sofar
        |   rev (x::xs, sofar) = rev (xs, x::sofar)
    in
        rev (stuff, nil)
    end;
