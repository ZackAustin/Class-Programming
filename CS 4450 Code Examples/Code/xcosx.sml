use "iterate.sml";

fun cosine x0 =
    Cons (x0, fn () => cosine (Math.cos x0));
    
iterate (cosine 0.0, 0.000000001);
