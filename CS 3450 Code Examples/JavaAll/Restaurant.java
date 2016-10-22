import java.util.Random;

// The Command
interface Order {
    void orderUp();
}

class Cook {
    public void makeBurger() {
        System.out.println("Making a burger");
    }
    public void makeFries() {
        System.out.println("Making fries");
    }
    public void makeShortStack() {
        System.out.println("Making 2 pancakes");
    }
    public void makeScrambled() {
        System.out.println("Scrambling eggs");
    }
    public void makeHashBrowns() {
        System.out.println("Making hash brown potatoes");
    }
}

class BurgerAndFries implements Order {
    private Cook receiver;
    public BurgerAndFries(Cook c) {
        receiver = c;
    }
    public void orderUp(){
        receiver.makeBurger();
        receiver.makeFries();
    }
}

class FarmersSpecial implements Order {
    private Cook receiver;
    public FarmersSpecial(Cook c) {
        receiver = c;
    }
    public void orderUp() {
        receiver.makeShortStack();
        receiver.makeScrambled();
        receiver.makeHashBrowns();
    }
}

class Waitress {
    public static void serve() {
        Random ran = new Random();
        Order order = null;
        for (int i = 0; i < 8; ++i) {
            // Take order
            switch (ran.nextInt(2)) {
            case 0:
                order = new BurgerAndFries(Restaurant.cook);
                break;
            case 1:
                order = new FarmersSpecial(Restaurant.cook);
                break;
            }

            // Submit and process order (the command)
            order.orderUp();
            System.out.println();
        }
    }
}

class Restaurant {
    static Cook cook = new Cook();
    public static void main(String [] args) {
        Waitress.serve();
    }
}
