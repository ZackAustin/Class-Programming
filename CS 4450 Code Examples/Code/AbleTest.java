import java.io.*;

interface Printable {
   void print(PrintWriter w);
}

interface Intable {
   int toInt();
}

interface Stringable {
   String toString();
}

class Able implements Printable, Intable, Stringable {
   private int myData;
   public Able(int x) {
      myData = x;
   }
   public void print(PrintWriter w) {
      w.print(myData);
   }
   public int toInt() {
      return myData;
   }
   public String toString() {
      return Integer.toString(myData);
  }
};

public class AbleTest {
   static void testPrintable(Printable p) {
      PrintWriter out = new PrintWriter(System.out);
      p.print(out);
      out.println(); // For a newline
      out.flush();
   }
   static void testIntable(Intable n) {
      int i = n.toInt() + 1;
      System.out.println(i);
   }
   static void testStringable(Stringable s) {
      String buf = s.toString() + "th";
      System.out.println(buf);
   }
   
   public static void main(String[] args) {
     Able a = new Able(7);
     testPrintable(a);
     testIntable(a);
     testStringable(a);
   }
}

/* Output:
7
8
7th
*/
