///      ///
/// Test ///
///      ///
public class VisitorTest {
    public static void main(String[] args) {
        Element[] elements = new Element[2];
        elements[0] = new ConcreteElementA();
        elements[1] = new ConcreteElementB();
        ConcreteVisitor1 v1 = new ConcreteVisitor1();
        Test.doit(elements, v1);
        ConcreteVisitor2 v2 = new ConcreteVisitor2();
        Test.doit(elements, v2);
    }
}

// Test is the application context. It only
// knows what it is passed and the right
// thing happens.
class Test {
    public static void doit(Element[] e, Visitor v) {
        for (int i = 0; i < e.length; ++i)
            e[i].accept(v);
    }
}

///         ///
/// Pattern ///
///         ///
abstract class Visitor {
    public abstract void visitConcreteElementA(ConcreteElementA a);
    public abstract void visitConcreteElementB(ConcreteElementB b);

    // Could also have state
}

class ConcreteVisitor1 extends Visitor {
    public void visitConcreteElementA(ConcreteElementA a) {
        System.out.print("Visitor1 Visiting ConcreteElementA: ");
        a.operationA();
    }
    public void visitConcreteElementB(ConcreteElementB b) {
        System.out.print("Visitor1 Visiting ConcreteElementB: ");
        b.operationB();
    }
}

class ConcreteVisitor2 extends Visitor {
    public void visitConcreteElementA(ConcreteElementA a) {
        System.out.print("Visitor2 Visiting ConcreteElementA: ");
        a.operationA();
    }
    public void visitConcreteElementB(ConcreteElementB b) {
        System.out.print("Visitor2 Visiting ConcreteElementB: ");
        b.operationB();
    }
}

interface Element {
    void accept(Visitor v);
}

class ConcreteElementA implements Element {
    public void accept(Visitor v) {
        v.visitConcreteElementA(this);
    }
    public void operationA() {
        System.out.println("ConcreteElementA.operationA()");
    }
}

class ConcreteElementB implements Element {
    public void accept(Visitor v) {
        v.visitConcreteElementB(this);
    }
    public void operationB() {
        System.out.println("ConcreteElementB.operationB()");
    }
}

/* Output:
Visitor1 Visiting ConcreteElementA: ConcreteElementA.operationA()
Visitor1 Visiting ConcreteElementB: ConcreteElementB.operationB()
Visitor2 Visiting ConcreteElementA: ConcreteElementA.operationA()
Visitor2 Visiting ConcreteElementB: ConcreteElementB.operationB()
*/

