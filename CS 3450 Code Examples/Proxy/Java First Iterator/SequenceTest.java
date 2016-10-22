import java.io.*;
import java.util.*;
import TestSuite.*;
//import cns3250.prog4.*;

public class SequenceTest extends Test {
   Sequence seq;
   public SequenceTest(Sequence seq) {
      this.seq = seq;
   }
   public void run() throws IOException {
      Integer ten = new Integer(10);
      // Test exceptions/assertions.
      // An exception should occur for each case below.
      try {
         seq.getFirst();
         fail(1);
      }
      catch (Throwable x) {
         succeed();
      }
      try {
         seq.removeFirst();
         fail(1);
      }
      catch (Throwable x) {
         succeed();
      }
      try {
         seq.setFirst(ten);
         fail(1);
      }
      catch (Throwable x) {
         succeed();
      }
      try {
         seq.getLast();
         fail(1);
      }
      catch (Throwable x) {
         succeed();
      }
      try {
         seq.removeLast();
         fail(1);
      }
      catch (Throwable x) {
         succeed();
      }
      try {
         seq.setLast(ten);
         fail(1);
      }
      catch (Throwable x) {
         succeed();
      }
      try {
         seq.getIndex(0);
         fail(1);
      }
      catch (Throwable x) {
         succeed();
      }
      try {
         seq.setIndex(0, ten);
         fail(1);
      }
      catch (Throwable x) {
         succeed();
      }
      try {
         seq.removeIndex(0);
         fail(1);
      }
      catch (Throwable x) {
         succeed();
      }
      try {
         seq.addIndex(1, ten);
         fail(1);
      }
      catch (Throwable x) {
         succeed();
      }

      // Add an element
      test(seq.size() == 0);
      seq.addFirst(ten);
      test(seq.getFirst() == ten);
      test(seq.getLast() == ten);
      test(seq.size() == 1);

      // Add some more
      Integer twenty = new Integer(20);
      Integer thirty = new Integer(30);
      seq.addLast(twenty);
      seq.addLast(thirty);
      test(seq.getIndex(1) == twenty);
      test(seq.getLast() == thirty);
      test(seq.size() == 3);

      // Search for some values
      test(seq.indexOf(new Integer(20)) != -1);
      Integer forty = new Integer(40);
      test(seq.indexOf(forty) == -1);
      seq.addIndex(seq.size(), forty);
      test(seq.indexOf(forty) == seq.size()-1);
      test(seq.indexOf(new Integer(40)) != -1);
      Integer fifteen = new Integer(15);
      seq.addIndex(1, fifteen);
      test(seq.getIndex(1) == fifteen);
      test(seq.size() == 5);

      // Iterator test
      // (Order should be 10, 15, 20, 30, 40)
      Iterator it = seq.iterator();
      test(it.hasNext());
      test(it.next() == ten);
      test(it.hasNext());
      test(it.next() == fifteen);
      test(it.hasNext());
      test(it.next() == twenty);
      test(it.hasNext());
      test(it.next() == thirty);
      test(it.hasNext());
      test(it.next() == forty);
      test(!it.hasNext());
      it.remove();         // Remove forty
      test(seq.size() == 4);
      try {
         // Run off end of list
         it.next();
         fail(1);
      }
      catch (NoSuchElementException x) {
         succeed();
      }
      seq.addLast(forty);  // Add it back
      test(seq.size() == 5);

      // Try to remove fifteen
      it = seq.iterator();
      it.next();
      test(it.next() == fifteen);
      it.remove();
      try {
         // Can't remove twice
         it.remove();
         fail(1);
      }
      catch (IllegalStateException x) {
         succeed();
      }
      test(seq.size() == 4);
      it = seq.iterator();
      it.next();
      test(it.next() == twenty);
      seq.addIndex(1, fifteen);
      test(seq.getIndex(1) == fifteen);

      // Test removals
      seq.removeFirst();
      test(seq.getFirst() == fifteen);
      test(seq.size() == 4);
      seq.removeIndex(2);
      test(seq.getIndex(2) == forty);
      test(seq.size() == 3);
      seq.removeLast();
      test(seq.getLast() == twenty);
      test(seq.size() == 2);
      seq.remove(twenty);
      test(seq.getFirst() == fifteen);
      test(seq.getLast() == fifteen);
      test(seq.getIndex(0) == fifteen);
      test(seq.size() == 1);
      it = seq.iterator();
      test(it.hasNext());
      test(it.next() == fifteen);
      it.remove();
      test(seq.size() == 0);

      // Test clear
      seq.addFirst(ten);
      seq.addFirst(twenty);
      test(seq.size() == 2);
      seq.clear();
      test(seq.size() == 0);
      it = seq.iterator();
      test(!it.hasNext());

   }
   public static void main(String[] args) throws IOException {
      SequenceProxy proxy = new SequenceProxy(new ListSequence());
      SequenceTest f = new SequenceTest(proxy);
      f.setSink(new BufferedWriter(new FileWriter("prog4.out")));
      f.run();
      f.report();
      f.reset();
      proxy.changeSequence(new ArraySequence());
      f.run();
      f.report();
      f.close();
   }
}

