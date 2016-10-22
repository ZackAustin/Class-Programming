// Illustrates Parent Links
import java.io.*;
import java.util.*;

public class CompositeTest2 {
    public static void main(String[] args) {
        // Builds the tree on p. 165 of GOF:
        Composite comp1 = new Composite("comp");
        comp1.add(new Leaf("leaf3"));
        comp1.add(new Leaf("leaf4"));
        comp1.add(new Leaf("leaf5"));
        Composite comp2 = new Composite("root");
        comp2.add(new Leaf("leaf1"));
        comp2.add(new Leaf("leaf2"));
        comp2.add(comp1);
        comp2.add(new Leaf("leaf6"));
        Test.doit(comp2);
        Test.doit(new Leaf("leaf7"));
        Test.doit2(comp2);
        Test.doit2(new Leaf("leaf8"));
        Test.doit3(comp2);
        Test.doit3(new Leaf("leaf9")); // Does nothing
        Test.doit4(comp2);
    }
}

class Test {
    public static void doit(Component c) {
        System.out.println("\nVia operation():");
        c.operation();
    }

    public static void doit2(Component c) {
        System.out.println("\nVia an iterator:");
        if (c instanceof Composite) {
            System.out.println(c.getName());
            Iterator iter = c.iterator();
            while (iter.hasNext()) {
                Component c2 = (Component) iter.next();
                if (c2 instanceof Composite)
                    System.out.println(c2.getName());
                else
                    c2.operation();
            }
        }
        else
            c.operation();
    }

    // This test only processes leaves.
    public static void doit3(Component c) {
        System.out.println("\nVia a leaf iterator:");
        LeafIterator iter = new LeafIterator(c.iterator());
        while (iter.hasNext()) {
            Component c3 = (Component) iter.next();
            c3.operation();
        }
    }
    public static void doit4(Component c) {
        Composite comp = (Composite) c;
        System.out.println("Composite: " + comp.getName());
        Writer stdout = new OutputStreamWriter(System.out);
        comp.listChildren(stdout);
        System.out.println();
        comp = (Composite) comp.getChild(2);
        System.out.println("Composite: " + comp.getName() + "(" + comp.getParent().getName() + ")");
        comp.listChildren(stdout);
        System.out.println();
        comp = (Composite) comp.getParent();
        System.out.println("Composite: " + comp.getName());
        comp.listChildren(stdout);
    }
}

///         ///
/// Pattern ///
///         ///

abstract class Component {
    public abstract void operation();
    public abstract Iterator iterator();
    protected String name;
    protected Component(String nam) {
        name = nam;
    }
    String getName() {
        return name;
    }

    // Parent info
    protected Component parent;
    Component getParent() {
        return parent;
    }

    // Hooks for child operations
    public void add(Component c) {
        throw new UnsupportedOperationException();
    }
    public void remove(Component c) {
        throw new UnsupportedOperationException();
    }
    public Component getChild(int idx)  {
        throw new UnsupportedOperationException();
    }
}

class Leaf extends Component {
    public Leaf(String name) {
        super(name);
    }
    public void operation() {
        System.out.println(getName() + ".operation()");
    }
    public Iterator iterator() {
        return new NullIterator();
    }
}

class Composite extends Component {
    private LinkedList children = new LinkedList();

    public Composite(String nam) {
        super(nam);
    }
    public void operation() {
        System.out.println(getName() + ".operation()");
        Iterator i = children.iterator();
        while (i.hasNext())
            ((Component) i.next()).operation();
    }
    public Iterator iterator() {
        return new CompositeIterator(children.iterator());
    }
    public void add(Component c) {
        children.add(c);
        c.parent = this;
    }
    public void remove(Component c) {
        if (c.parent != this)
            throw new IllegalStateException("Parent error in " + c.getName());
        children.remove(c);
        c.parent = null;
    }
    public Component getChild(int idx) {
        return (Component) children.get(idx);
    }
    public void listChildren(Writer w) {
        Iterator it = children.iterator();
        for (int i = 1; it.hasNext(); ++i)
            System.out.println(i + " " + ((Component)it.next()).getName());
    }
}

class NullIterator implements Iterator {
    public boolean hasNext() {
        return false;
    }
    public Object next() {
        return null;
    }
    public void remove() {
        throw new UnsupportedOperationException();
    }
}

class CompositeIterator implements Iterator {
    Stack stack = new Stack();
    public CompositeIterator(Iterator iter) {
        stack.push(iter);
    }
    public boolean hasNext() {
        if (!stack.empty()) {
            Iterator iter = (Iterator) stack.peek();
            if (iter.hasNext())
                return true;
            else {
                // The current iterator is exhausted; unwind
                stack.pop();
                return hasNext();
            }
        }
        else
            return false;
    }
    public Object next() {
        if (hasNext()) {
            Iterator iter = (Iterator) stack.peek();
            Component c = (Component) iter.next();
            if (c instanceof Composite)
                stack.push(c.iterator());
            return c;
        }
        else
            throw new NoSuchElementException();
    }
    public void remove() {
        throw new UnsupportedOperationException();
    }
}

class ReverseCompositeIterator implements Iterator {
    Stack stack = new Stack();
    public ReverseCompositeIterator(ListIterator iter) {
        stack.push(iter);
    }
    public boolean hasNext() {
        if (!stack.empty()) {
            Iterator iter = (Iterator) stack.peek();
            if (iter.hasNext())
                return true;
            else {
                // The current iterator is exhausted; unwind
                stack.pop();
                return hasNext();
            }
        }
        else
            return false;
    }
    public Object next() {
        if (hasNext()) {
            Iterator iter = (Iterator) stack.peek();
            Component c = (Component) iter.next();
            if (c instanceof Composite)
                stack.push(c.iterator());
            return c;
        }
        else
            throw new NoSuchElementException();
    }
    public void remove() {
        throw new UnsupportedOperationException();
    }
}

// This iterator requires calls to hasNext before
// each call to next.
class LeafIterator implements Iterator {
    Iterator iter;
    Object last; // The most recent returned by iter.next()
    public LeafIterator(Iterator it) {
        iter = it;
    }
    public boolean hasNext() {
        while (iter.hasNext()) {
            last = iter.next();
            if (last instanceof Leaf)
                return true;
        }
        last = null;
        return false;
    }
    public Object next() {
        if (last == null)
            throw new NoSuchElementException();
        else
            return last;
    }
    public void remove() {
        throw new UnsupportedOperationException();
    }
}

/* Output:
Via operation():
Composite.operation()
Leaf.operation()
Leaf.operation()
Composite.operation()
Leaf.operation()
Leaf.operation()
Leaf.operation()
Leaf.operation()

Via operation():
Leaf.operation()

Via an iterator:
Composite
Leaf.operation()
Leaf.operation()
Composite
Leaf.operation()
Leaf.operation()
Leaf.operation()
Leaf.operation()

Via an iterator:
Leaf.operation()

Via a leaf iterator:
Leaf.operation()
Leaf.operation()
Leaf.operation()
Leaf.operation()
Leaf.operation()
Leaf.operation()

Via a leaf iterator:
*/
