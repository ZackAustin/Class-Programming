import java.util.*;
import java.io.*;
import TestSuite.Test;
// Add your package import here:

public class PriorityQueueTest extends Test {
  PriorityQueue queue = new PriorityQueue(5);
  boolean assertsEnabled = false;
  {
     // Get assert status
     assert assertsEnabled = true;
  }
  
  void testExceptions() throws IOException {
     try {
       queue.removeFirst();
       fail(1);
     }
     catch (NoSuchElementException e) {
       succeed();
     }
     try {
       queue.getFirst();
       fail(1);
     }
     catch (NoSuchElementException e) {
       succeed();
     }
     try {
       queue.get(0);
       fail(1);
     }
     catch (NoSuchElementException e) {
       succeed();
     }
  }
  void testCreate() throws IOException {
     queue.add("A", 0);
     test(queue.size() == 1);
     test(queue.getFirst().equals(new PQ.Entry("A", 0)));
     queue.add("B", 1);
     queue.add("C", 2);
     queue.add("D", 3);
     queue.add("E", 4);
     queue.add("F", 2);
     queue.add("G");
     test(queue.size() == 7);
     test(queue.numPriorities() == 5);
     String s = "{0: [A, G], 1: [B], 2: [C, F], 3: [D], 4: [E]}";
     test(queue.toString().equals(s));
     PriorityQueue queue2 = new PriorityQueue((queue));
     test(queue.equals(queue2));
  }
  void testIterator() throws IOException {
     Iterator it = queue.iterator();
     test(it.hasNext());
     PQ.Entry e = (PQ.Entry) it.next();
     test(e.getData().equals("E") && e.getPriority() == 4);
     test(it.hasNext());
     e = (PQ.Entry) it.next();
     test(e.getData().equals("D") && e.getPriority() == 3);
     test(it.hasNext());
     e = (PQ.Entry) it.next();
     test(e.getData().equals("C") && e.getPriority() == 2);
     test(it.hasNext());
     e = (PQ.Entry) it.next();
     test(e.getData().equals("F") && e.getPriority() == 2);
     test(it.hasNext());
     e = (PQ.Entry) it.next();
     test(e.getData().equals("B") && e.getPriority() == 1);
     test(it.hasNext());
     e = (PQ.Entry) it.next();
     test(e.getData().equals("A") && e.getPriority() == 0);
     test(it.hasNext());
     e = (PQ.Entry) it.next();
     test(e.getData().equals("G") && e.getPriority() == 0);
     test(!it.hasNext());
     try {
        it.next();
        fail(1);
     }
     catch(NoSuchElementException x) {
        succeed();
     }
     it = queue.iterator();
     it.next();
     it.remove();
     test(!queue.contains(new PQ.Entry("E", 4)));
     try {
        it.remove();
        fail(1);
     }
     catch(IllegalStateException x) {
        succeed();
     }
     queue.add("E", 4);
  }
  void testRemove() throws IOException {
     test(queue.contains(new PQ.Entry("C", 2)));
     test(queue.remove(2).equals(new PQ.Entry("C", 2)));
     test(!queue.contains(new PQ.Entry("C", 2)));
     test(queue.contains(new PQ.Entry("G", 0)));
     queue.remove(new PQ.Entry("G",0));
     test(!queue.contains(new PQ.Entry("G", 0)));
  }
  void testSerialize() throws IOException {
     ObjectOutputStream out =
        new ObjectOutputStream(new FileOutputStream("pq.dat"));
     out.writeObject(queue);
     out.close();
     ObjectInputStream in =
        new ObjectInputStream(new FileInputStream("pq.dat"));
     PriorityQueue queue2 = null;
     try {
        queue2 = (PriorityQueue) in.readObject();
        test(queue.equals(queue2));
     }
     catch (Exception x) {
        fail(x.toString() + " while deserializing");
     }
     test(queue.containsAll(queue2));
  }
  void testArray() throws IOException {
     Object[] a = queue.toArray();
     test(a.length == 5);
     test(a[0].equals(new PQ.Entry("E", 4)));
     test(a[1].equals(new PQ.Entry("D", 3)));
     test(a[2].equals(new PQ.Entry("F", 2)));
     test(a[3].equals(new PQ.Entry("B", 1)));
     test(a[4].equals(new PQ.Entry("A", 0)));
     
     ArrayList alist = new ArrayList();
     for (int i = 0; i < a.length; ++i)
        alist.add(((PQ.Entry)a[i]).getData());
     PriorityQueue queue2 = new PriorityQueue(alist);
     String s = "{0: [E, D, F, B, A], 1: , 2: , 3: , 4: }";
     test(queue2.toString().equals(s));
     test(queue2.size() == a.length);
     test(queue2.get(0).equals(new PQ.Entry("E", 0)));
     test(queue2.get(1).equals(new PQ.Entry("D", 0)));
     test(queue2.get(2).equals(new PQ.Entry("F", 0)));
     test(queue2.get(3).equals(new PQ.Entry("B", 0)));
     test(queue2.get(4).equals(new PQ.Entry("A", 0)));
  }
  void testClone() throws IOException {
     PriorityQueue queue2 = (PriorityQueue) queue.clone();
     test(queue2.equals(queue));
     queue2.remove(2);
     test(!queue2.equals(queue));
     queue2.removeAll(queue2);
     test(queue2.size() == 0);
  }

  public void run() throws IOException {
     // The following must be called in order!
     testExceptions();
     testCreate();
     testIterator();
     testRemove();
     testSerialize();
     testArray();
     testClone();
  }
  public static void main(String[] args) throws Exception {
     PriorityQueueTest t = new PriorityQueueTest();
     t.setSink(new BufferedWriter(new OutputStreamWriter(System.out)));
     t.run();
     t.report();
     t.close();
  }
}