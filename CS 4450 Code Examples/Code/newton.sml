use "iterate.sml";

fun newton_sqrt (a, x0) =
    Cons (x0, fn () => newton_sqrt (a, (x0 + a/x0)/2.0));

iterate (newton_sqrt(4.0, 29.0), 0.000000001);
