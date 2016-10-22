import java.util.*;

///      ///
/// Test ///
///      ///
public class CompositeTest {
    public static void main(String[] args) {
        // Builds the tree on p. 165 of GOF:
        Composite comp1 = new Composite();
        comp1.add(new Leaf());
        comp1.add(new Leaf());
        comp1.add(new Leaf());
        Composite comp2 = new Composite();
        comp2.add(new Leaf());
        comp2.add(new Leaf());
        comp2.add(comp1);
        comp2.add(new Leaf());
        Test.doit(comp2);
        Test.doit(new Leaf());
        Test.doit2(comp2);
        Test.doit2(new Leaf());
        Test.doit3(comp2);
        Test.doit3(new Leaf()); // Does nothing
    }
}

class Test {
// Test is the application context. It only
// knows what it is passed and the right
// thing happens.
    public static void doit(Component c) {
        System.out.println("\nVia operation():");
        c.operation();
    }

/// This test needs to differentiate the Component types
/// It only calls operation on Leaves. Otherwise leaves 
/// will execute mutiple times.
    public static void doit2(Component c) {
        System.out.println("\nVia an iterator:");
        if (c instanceof Composite) {
            System.out.println("Composite");
            Iterator iter = c.iterator();
            while (iter.hasNext()) {
                Component c2 = (Component) iter.next();
                if (c2 instanceof Composite)
                    System.out.println("Composite");
                else
                    c2.operation();
            }
        }
        else
            c.operation();
    }

/// This test only processes leaves.
    public static void doit3(Component c) {
        System.out.println("\nVia a leaf iterator:");
        LeafIterator iter = new LeafIterator(c.iterator());
        while (iter.hasNext()) {
            Component c3 = (Component) iter.next();
            c3.operation();
        }
    }
}

///         ///
/// Pattern ///
///         ///

abstract class Component {
    public abstract void operation();
    public abstract Iterator iterator();

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
    public void operation() {
        System.out.println("Leaf.operation()");
    }
    public Iterator iterator() {
        return new NullIterator();
    }
}

class Composite extends Component {
    private ArrayList children = new ArrayList();

    public void operation() {
        System.out.println("Composite.operation()");
        Iterator i = children.iterator();
        while (i.hasNext())
            ((Component) i.next()).operation();
    }
    public Iterator iterator() {
        return new CompositeIterator(children.iterator());
    }
    public void add(Component c) {
        children.add(c);
    }
    public void remove(Component c) {
        children.remove(c);
    }
    public Component getChild(int idx) {
        return (Component) children.get(idx);
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
