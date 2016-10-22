///      ///
/// Test ///
///      ///
public class CommandTest {
    public static void main(String[] args) {
        Foo f = new Foo();
        ConcreteCommand cmd = new ConcreteCommand(f);
        cmd.setState("Altered State");
        Test.doit(cmd);
    }
}

class Test {
// Test is the application context. It only
// knows what it is passed and the right
// thing happens.
    public static void doit(Command cmd) {
        cmd.execute();
    }
}

///         ///
/// Pattern ///
///         ///
interface Command {
    void execute();
}

class ConcreteCommand implements Command {
    private String state;
    private Foo receiver;

    public ConcreteCommand(Foo receiver) {
        this.receiver = receiver;
    }
    public void setState(String state) {
        this.state = state;
    }
    public String getState() {
        return state;
    }
    public void execute() {
        receiver.action(state);
    }
}

class Foo {
    public void action(String state) {
        System.out.println("Foo.action(" + state + ")");
    }
}

/* Output:
Foo.action(Altered State)
*/

