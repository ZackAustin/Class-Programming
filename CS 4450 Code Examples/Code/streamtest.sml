use "stream.sml";

(* A function to generate an infinite sequence of integers *)
fun intsfrom k = Cons(k, fn () => intsfrom (k+1));

val nums = intsfrom 1;
head nums;
next nums;
nth 4 nums;

fun intrange (k, n) = if k > n then Nil else Cons(k, fn () => intrange (k+1, n));

val nums2 = intrange (5,8);
head nums2;
next nums2;
nth 2 nums2;
nth 3 nums2;
nth 4 nums2 handle Empty => ~1;

val bools = map_ (fn x => x mod 2 = 0) nums;
head bools;
next bools;
next (tail bools);

val takeeven = filter (fn x => x mod 2 = 0);
val x = takeeven (intsfrom 1);
head x;
next x;
next (tail x);

val takeodd = filter (fn x => x mod 2 = 1);


(* Compose streams *)
val sum = foldl_ (fn (v,sofar) => v+sofar) 0 (intsfrom 1);
nth 0 sum;
nth 1 sum;
nth 2 sum;

printStrm 5 sum;

strm2list 5 sum;
strm2list 10 (filter (fn(x) => x mod 2 = 1 orelse x mod 3 = 0) sum);

fun isPrime(n) = 
    let
        fun primeHelper(m, nextDiv) =
            nextDiv*nextDiv > m orelse
                if m mod nextDiv = 0 then
                    false
                else
                    primeHelper(m, nextDiv+1);
    in
        n = 2 orelse n > 2 andalso primeHelper(n,2)
    end;

val primes = filter isPrime nums;
printStrm 30 primes;

val sum2 = foldl_ (fn (v,sofar) => v+sofar) 0 (Cons(1,fn()=>Nil));
nth 0 sum2;
nth 1 sum2 handle Empty => ~1;
printStrm 10 sum2;

val products = foldl_ (fn (v,sofar) => v*sofar) 1 (takeodd (intsfrom 1));
printStrm 5 products;
