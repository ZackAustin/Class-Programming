abstract class Base {
    public final void theAlgorithm() {
        fixedop1();
        missingop1();
        fixedop2();
        missingop2();
    }
    final void fixedop1() {
        System.out.println("fixedop1");
    }
    final void fixedop2() {
        System.out.println("fixedop2");
    }
    abstract void missingop1();
    abstract void missingop2();
};

class Derived extends Base {
    void missingop1() {
        System.out.println("missingop1");
    }
    void missingop2() {
        System.out.println("missingop2");
    }
};

class Skeleton {
    public static void main(String[] args) {
        Derived d = new Derived();
        d.theAlgorithm();
    }
}
