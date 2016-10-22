import java.util.*;

interface UnaryFunction {
    void execute(Object o);
}

class Display implements UnaryFunction {
    public void execute(Object o) {
        System.out.println(o);
    }
}

class InternalIter {
    public static void forEach(Collection c, UnaryFunction f) {
        Iterator it = c.iterator();
        while (it.hasNext())
            f.execute(it.next());
    }
    public static void main(String[] args) {
        ArrayList stuff = new ArrayList();
        stuff.add("one");
        stuff.add("two");
        stuff.add("three");
        forEach(stuff, new Display());
    }
}
