class Singleton {
    private static Singleton theInstance;
    private int theData = 2;
    public int getData() {
        return theData;
    }
    private Singleton() {}
    public static Singleton getInstance() {
        if (theInstance == null)
            theInstance = new Singleton();
        return theInstance;
    }
    public static void main(String[] args) {
        Singleton s = Singleton.getInstance();
        System.out.println(s.getData());
    }
}

