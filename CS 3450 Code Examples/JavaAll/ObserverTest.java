import java.util.*;

///      ///
/// Test ///
///      ///
public class ObserverTest {
    public static void main(String[] args) {
        ConcreteSubject s = new ConcreteSubject();
        ConcreteObserver o1 = new ConcreteObserver();
        s.addObserver(o1);
        ConcreteObserver o2 = new ConcreteObserver();
        s.addObserver(o2);
        s.setState(1);
        Test.doit(s);
        s.deleteObserver(o2);
        s.setState(2);
        Test.doit(s);
        s.deleteObservers();
        Test.doit(s);
    }
}

class Test {
// Test is the application context. It only
// knows what it is passed and the right
// thing happens.
    public static void doit(Observable s) {
        s.notifyObservers();
    }
}

///         ///
/// Pattern ///
///         ///
class ConcreteSubject extends Observable {
    private int state;

    public void setState(int n) {
        state = n;
        setChanged();
    }
    public Object getState() {
        return new Integer(state);
    }
    public void notifyObservers() {
        System.out.println("Notifying...");
        super.notifyObservers();
    }
}

class ConcreteObserver implements Observer {
    public void update(Observable s, Object o) {
        ConcreteSubject c = (ConcreteSubject)s;
        System.out.println("Updating " + this + " from Subject " + s + ": state = " + c.getState());
    }
}

/* Output:
Notifying...
Updating ConcreteObserver@ffa0badc from Subject ConcreteSubject@fe98badc: state = 1
Updating ConcreteObserver@fc5cbadc from Subject ConcreteSubject@fe98badc: state = 1
Notifying...
Updating ConcreteObserver@fc5cbadc from Subject ConcreteSubject@fe98badc: state = 2
Notifying...
*/

