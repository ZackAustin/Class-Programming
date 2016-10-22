import java.io.Serializable;
import java.util.*;

public class PriorityQueue
extends AbstractCollection
implements Cloneable, PQ, Serializable {
   static final long serialVersionUID = 3290404607405629726L;
   private static final int MIN_PRIORITIES = 5;
   private LinkedList queue[];

   /** A utility ctor to save work.
    * @param c The incoming collection (could be null, which causes an empty queue to be created)
    * @param The number of priorities for the queue
    */
   PriorityQueue(Collection c, int numPriorities) {
      if (numPriorities <= 0)
         throw new IllegalArgumentException("Illegal number of priorities");
      queue = new LinkedList[numPriorities];
      if (c != null)
         addAll(c);
   }
   /** Creates a PriorityQueue with MIN_PRIORITIES (5) priorities.
    */
   public PriorityQueue() {
      this(MIN_PRIORITIES);
   }
   /** Adds a collection to the queue.
    * The incoming objects are given a priority of 0.
    * @param c The incoming collection
    */
   public PriorityQueue(Collection c) {
      this(c, MIN_PRIORITIES);
   }
   /** Creates a queue with a given number of priorities.
    * @param numPriorities The number of priorities.
    */
   public PriorityQueue(int numPriorities) {
      this(null, numPriorities);
   }
   /** A copy constructor. Clones the incoming array of lists.
    * @param pq The incoming PriorityQueue
    */
   public PriorityQueue(PriorityQueue pq) {
      if (pq != null) {
         queue =  new LinkedList[pq.queue.length];
         for (int i = 0; i < queue.length; ++i)
            queue[i] =  new LinkedList(pq.queue[i]);
      }
      else
         throw new RuntimeException("null PriorityQueue in copy constructor");
   }

   /** Determines the number of elements in the queue. (Sums the sizes of each linked list.)
    * @return The total number of queue elements
    */
   public int size() {
      int size = 0;
      for (int i = 0; i < queue.length; ++i)
         if (queue[i] != null)
            size += queue[i].size();
      return size;
   }
   /** Determines the number of priorities in this queue.
    * @return The number of priorities.
    */
   public int numPriorities() {
      return queue.length;
   }
   /** An override of Collection.add(Object).
    * Gives the incoming object the default priority of 0.
    * @param data The object to add to the queue.
    * @return <b>true</b> (because an element is always added,
    * following the convention in the Collection interface)
    */
   public boolean add(Object data) {
      return add(data, 0);
   }
   /** Adds an object to the list for the given priority.
    * @param data The object to add.
    * @param priority The object's priority
    * @return <b>true</b> (because an element is always added, following the convention in the
    * Collection interface)
    */
   public boolean add(Object data, int priority) {
      if (data == null)
         throw new NullPointerException("null object in PriorityQueue.add");
      if (queue[priority] == null)
         queue[priority] = new LinkedList();
      else if (queue[priority].contains(data))
         return false;
      return queue[priority].add(data);
   }
   /** Removes all elements from the queue. An override of Collection.clear for
    * efficiency (because the superclass method uses an iterator to remove each element).
    */
   public void clear() {
      for (int i = 0; i < queue.length; ++i)
         if (queue[i] != null)
            queue[i].clear();
   }
   /** Convenience method that calls remove(0).
    * @return The first queue element after removing it.
    * @throws NuSuchElementException if the queue is empty (actually thrown by the iterator)
    */
   public PQ.Entry removeFirst() {
      return remove(0);
   }
   /** Convenience method that calls get(0).
    * @return The first queue element.
    * @throws NuSuchElementException if there queue is empty (actually thrown by the iterator)
    */
   public PQ.Entry getFirst() {
      return get(0);
   }
   /** Returns the object in index 'pos' according to priority order
    * @param pos The zero-based index of the object to return
    * @return The object in position 'pos'.
    * @throws NuSuchElementException if there is no pos'th element (actually thrown by the iterator)
    */
   public PQ.Entry get(int pos) {
      Iterator iter = iterator();
      PQ.Entry entry = (PQ.Entry) iter.next();
      for (int i = 0; i < pos; ++i)
         entry = (PQ.Entry) iter.next();
      assert entry != null;
      return entry;
   }
   /** Removes the object in index 'pos' according to priority order
    * @param pos The zero-based index of the object to return
    * @return The object in position 'pos', after removing it.
    * @throws NuSuchElementException if there is no pos'th element (actually thrown by the iterator)
    */
   public PQ.Entry remove(int pos) {
      Iterator iter = iterator();
      PQ.Entry entry = (PQ.Entry) iter.next();
      for (int i = 0; i < pos; ++i)
         entry = (PQ.Entry) iter.next();
      assert entry != null;
      iter.remove();
      return entry;
   }
   /** Returns an iterator acording to priority order.
    * The first element is the first element in the list of highest priority (the
    * last in the array of lists). When this list is exhausted, it moves to the
    * next-to-last list, an so on.
    * @return The priority-based iterator.
    */
   public Iterator iterator() {
      return new Iterator() {
         int priority = queue.length - 1;
         // Invariant: listIter is the cursor for the current row
         // (which is queue[priority]).
         Iterator listIter = (queue[priority] == null) ? null : queue[priority].iterator();
         // Invariant: count is the # of elements already visited by next()
         int count = 0;
         boolean removeOK = false;

         public boolean hasNext() {
            return count < size();
         }
         public Object next() {
            for (;;) {
               if (listIter != null && listIter.hasNext()) {
                  Object next = listIter.next();
                  count++;
                  removeOK = true;
                  return new PQ.Entry(next, priority);
               }
               else
                  // Get next lower-priority iterator
                  if (--priority < 0)
                     throw new NoSuchElementException(); // Ran out
                  listIter = (queue[priority] == null) ? null : queue[priority].iterator();
            }
         }
         public void remove() {
            if (!removeOK)
               throw new IllegalStateException();
            listIter.remove();
            --count; // We removed an element
            removeOK = false;
         }
      };
   }
   /** Returns a string representation of the queue. Displays the list for each
    * priority on a row by itself, beginning with priority 0. A sample string might look like:
    * "{0: [Clean garage, Go to work], 1: [Buy propane for grill], 2: [Get haircut], 3: , 4: [Deposit paycheck]}"
    * @return The representation string.
    */
   public String toString() {
      StringBuffer buf = new StringBuffer("{");
      for (int i = 0; i < queue.length; i++) {
         if (i != 0)
            buf.append(", ");
         buf.append(i + ": ");
         if (queue[i] != null && queue[i].size() > 0)
            buf.append(queue[i].toString());
      }
      buf.append("}");
      return buf.toString();
   }
   /** Implements Cloneable
    * @return A clone of <b>this</b>
    */
   public Object clone() {
      // We can just use the copy constructor here
      return new PriorityQueue(this);
   }
   /** Computes a hash code for this queue.
    * @return The hash code.
    */
   public int hashCode() {
      int hash = 1;
      Iterator iter = iterator();
      while (iter.hasNext()) {
         Object obj = iter.next();
         hash = 37*hash + obj.hashCode();
      }
      return hash;
   }
   /** Implements Object.equals for PriorityQueues.
    * @return true if the queues hold the same values in the same order.
    */
   public boolean equals(Object o) {
      if (this == o)
         return true;
      if (!(o instanceof PriorityQueue))
         return false;
      PriorityQueue p = (PriorityQueue) o;
      boolean result = false;
      if (size() == p.size()) {
         // I don't use LinkedList.equals() since I allow nulls in queue.
         Iterator iter1 = iterator();
         Iterator iter2 = p.iterator();
         while (iter1.hasNext() && iter2.hasNext())
            if (!(iter1.next().equals(iter2.next())))
               break;
         result = !iter1.hasNext() && !iter2.hasNext();
      }
      return result;
   }
}