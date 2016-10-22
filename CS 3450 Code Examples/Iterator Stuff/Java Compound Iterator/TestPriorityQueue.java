import java.util.*;

public class TestPriorityQueue {
  public static void main (String args[]) {
    PriorityQueue queue = new PriorityQueue(5);
    try {
      System.out.println(queue.removeFirst());
    } catch (NoSuchElementException e) {
      System.out.println("Got expected Exception");
    }
    queue.add("Help", 2);
    queue.add("Me", 2);
    queue.add("Whazzup", 1);
    queue.add("Out", 2);
    queue.add("Of", 2);
    queue.add("Here", 2);
    System.out.println(queue);
    System.out.println(queue.removeFirst());
    System.out.println(queue);
    Iterator it = queue.iterator();
    while (it.hasNext())
       System.out.println(it.next());
    System.out.println();
    System.out.println(queue.remove(2));
    System.out.println();
    System.out.println(queue.contains(new PQ.Entry("Out",2)));
    queue.remove(new PQ.Entry("Here",2));
    Object[] a = queue.toArray();
    for (int i = 0; i < a.length; ++i)
       System.out.println(a[i]);
    queue.clear();
    System.out.println(queue.size());
    System.out.println(queue.isEmpty());
    while (queue.size() != 0) {
      System.out.println(queue.removeFirst());
    }
  }
}