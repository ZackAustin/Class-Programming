import java.io.*;
import java.util.*;
import TestSuite.*;
// Add your package import here

public class SequenceTest extends Test {
   SequenceProxy seq;
   public SequenceTest(SequenceProxy seq) {
      this.seq = seq;
   }
   public void changeSequence(SequenceProxy seq) {
      this.seq = seq;
   }
   public void run() throws IOException {
      boolean assertsEnabled = false;
      assert assertsEnabled = true; // Note assignment
      Integer ten = new Integer(10);
      if (assertsEnabled)
      {
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
      it.remove();   // Remove forty
      test(seq.size() == 4);
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

      // Special test for FixedArray
      if (assertsEnabled && seq.getSubject() instanceof FixedArray) {
         int capacity = seq.capacity();
         test(capacity == seq.size());
         try {
            seq.addFirst(ten);
            fail(1);
         }
         catch (Throwable x) {
            succeed();
         }
         try {
            seq.addLast(ten);
            fail(1);
         }
         catch (Throwable x) {
            succeed();
         }
         try {
            seq.addIndex(0, ten);
            fail(1);
         }
         catch (Throwable x) {
            succeed();
         }
      }

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

   }
   public static void main(String[] args) throws IOException
   {
      SequenceProxy p = new SequenceProxy(new FixedArray(5));
      SequenceTest f = new SequenceTest(p);
      f.setSink(new BufferedWriter(new OutputStreamWriter(System.out)));
      f.run();
      f.report();
      f.flush();
      p.changeSubject(new DynamicArray());
      f.reset();
      f.run();
      f.report();
      f.close();
   }
}

/* Output with asserts enabled:
Test "SequenceTest":
	     Passed: 58
	     Failed: 0
Test "SequenceTest":
	     Passed: 54
	     Failed: 0
*/

/* Output with asserts disabled:
Test "SequenceTest":
        Passed: 44
        Failed: 0
Test "SequenceTest":
        Passed: 44
        Failed: 0
*/

