use "stream.sml";

fun iterate(strm, eps:real) =
    let
        val last = head strm
        val current = next strm
    in
        if abs(current-last) > eps then
            iterate (tail strm, eps)
        else
            current
    end;