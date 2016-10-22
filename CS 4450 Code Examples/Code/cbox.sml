datatype color = Red | Green | Blue;
datatype 'a cbox = Contents of 'a option | Box of int * color * 'a cbox;

exception BadBox;

fun makebox (siz, col, box) = if siz <= 0 then raise BadBox else
    case box of
        Contents _ => Box (siz, col, box) |
        Box (s,_,_) =>
            if siz <= s then raise BadBox else Box (siz, col, box);

fun boxcount (Contents _) = 0
|   boxcount (Box (_,_,box)) = 1 + boxcount box;

val b = makebox (3, Red, Contents (SOME "surprise!"));
val b = makebox (4, Blue, b);
val b = makebox (5, Green, b);

boxcount b;

fun cstring Red = "Red"
|   cstring Green = "Green"
|   cstring Blue = "Blue";

fun tracebox (Contents x) = ()
|   tracebox (Box (s,c,b)) =
    (
        print (Int.toString s);
        print ", ";
        print (cstring c);
        print "\n";
        tracebox b
    );
    
tracebox b;

fun openbox (Contents x) =  x
|   openbox (Box (_,_,box)) = openbox box;

openbox b;

fun insert (siz, col, box) = if siz <= 0 then raise BadBox else
    case box of
        Contents _ => Box (siz, col, box)
    |   Box (s,c,cb) => case Int.compare(siz, s) of
            GREATER => Box (siz, col, box)
        |   EQUAL => raise BadBox
        |   LESS => Box (s, c, insert (siz, col, cb));

val b = insert (6, Green, b);
val b = insert (2, Red, b);
(* val b = insert (2, Red, b); *) (* ERROR *)
tracebox b;

fun makebox2 (nil, x) = Contents x
|   makebox2 ((siz, col)::t, x) = insert (siz, col, makebox2 (t,x));

val b2 = makebox2([(5,Red),(4,Blue),(3,Green)],SOME 100);
boxcount b2;
openbox b2;
tracebox b2;

fun difflist1 (Box (s, _, Box(s2,c,box))) = (s-s2)::difflist1 (Box(s2,c,box))
|   difflist1 _ = nil;
   
fun difflist (Box (s, _, b as Box(s2,_,_))) = (s-s2)::difflist b
|   difflist _ = nil;

difflist1 b;
difflist b;

(* System response:
datatype color = Blue | Green | Red
datatype 'a cbox = Contents of 'a option |Box of int * color * 'a cbox
exception BadBox
val makebox = fn : int * color * 'a cbox -> 'a cbox
val boxcount = fn : 'a cbox -> int
val b = Box (3,Red,Contents (SOME "surprise!")) : string cbox
val b = Box (4,Blue, Box (3,Red,Contents #)) : string cbox
val b = Box (5,Green, Box (4,Blue, Box #)) : string cbox
val it = 3 : int
val cstring = fn : color -> string
val tracebox = fn : 'a cbox -> unit
5, Green
4, Blue
3, Red
val it = () : unit
val openbox = fn : 'a cbox -> 'a option
val it = SOME "surprise!" : string option
val insert = fn : int * color * 'a cbox -> 'a cbox
val b = Box (6,Green,Box (5,Green, Box #)) : string cbox
val b = Box (6,Green,Box (5,Green, Box #)) : string cbox
6, Green
5, Green
4, Blue
3, Red
2, Red
val it = () : unit
val makebox2 = fn : (int * color) list * 'a option -> 'a cbox
val b2 = Box (5,Red, Box (4,Blue,Box #)) : int cbox
val it = 3 : int
val it = SOME 100 : int option
5, Red
4, Blue
3, Green
val it = () : unit
val it = () : unit
val difflist1 = fn : 'a cbox -> int list
val difflist = fn : 'a cbox -> int list
val it = [1,1,1,1] : int list
val it = [1,1,1,1] : int list
*)
