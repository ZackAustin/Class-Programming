import java.util.*;

class Iterator1 {
    public static void traverse(Collection c) {
        Iterator it = c.iterator();
        while (it.hasNext()) {
            Object obj = it.next();
            System.out.println(obj);
        }
    }
    public static void main(String[] args) {
        ArrayList stuff = new ArrayList();
        stuff.add("one");
        stuff.add("two");
        stuff.add("three");
        traverse(stuff);
    }
}
