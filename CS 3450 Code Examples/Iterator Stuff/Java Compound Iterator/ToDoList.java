import java.io.*;
import java.util.*;

/** A ToDoList using a PriorityQueue
 */
public class ToDoList implements Cloneable, Serializable
{
   static final long serialVersionUID = -7237940369851920117L;
   private PriorityQueue data;
   /** This is just to illustrate transient: */
   public ToDoList() {
      data = new PriorityQueue();
   }
   public ToDoList(int numPriorities) {
      data = new PriorityQueue(numPriorities);
   }
   public void add(String item, int priority) {
      data.add(item, priority);
   }
   public PQ.Entry getFirst() {
      return data.getFirst();
   }
   public PQ.Entry get(int pos) {
      return data.get(pos);
   }
   public PQ.Entry removeFirst() {
      return data.removeFirst();
   }
   public PQ.Entry remove(int pos) {
      return data.remove(pos);
   }
   public int size() {
      return data.size();
   }
   public int numPriorities() {
      return data.numPriorities();
   }
   public void clear() {
      data.clear();
   }
   public Iterator iterator() {
      return data.iterator();
   }
   public String toString() {
      return data.toString();
   }
   public boolean equals(Object o) {
      if (this == o)
         return true;
      if (!(o instanceof ToDoList))
         return false;
      ToDoList tdl = (ToDoList) o;
      return tdl.data.equals(data);
   }
   public int hashCode() {
      return data.hashCode();
   }
   public Object clone() {
      try {
         ToDoList tdl = (ToDoList) super.clone();
         tdl.data = (PriorityQueue) data.clone();
         return tdl;
      }
      catch (CloneNotSupportedException x) {
         throw new InternalError("Clone failure");
      }
   }
   public void store(String fileName) throws IOException {
      if (fileName == null)
         throw new NullPointerException("Missing filename for store");
      ObjectOutputStream out = null;
      try {
         out = new ObjectOutputStream(new FileOutputStream(fileName));
         out.writeObject(this);
      }
      finally {
         if (out != null)
            out.close();
      }
   }
   public static ToDoList retrieve(String fileName) throws IOException, ClassNotFoundException {
      if (fileName == null)
         throw new NullPointerException("Missing filename for retrieve");
      ObjectInputStream in = null;
      ToDoList newList;
      try {
         in = new ObjectInputStream(new FileInputStream(fileName));
         newList = (ToDoList) in.readObject();
      }
      finally {
         if (in != null)
            in.close();
      }
      return newList;
   }
   public static void main(String[] args) throws Exception {
      ToDoList tdl = new ToDoList();
      tdl.clear();
      tdl.add("Get haircut", 2);
      tdl.add("Deposit paycheck", 4);
      tdl.add("Pick up dry cleaning", 3);
      tdl.add("Clean garage", 0);
      tdl.add("Buy propane for grill", 1);
      tdl.add("Go to work", 0);
      System.out.println(tdl);
      System.out.println(tdl.hashCode());
      tdl.store("TDL.dat");
      ToDoList tdl2 = ToDoList.retrieve("TDL.dat");
      System.out.println("Equal? " + tdl.equals(tdl2));
      tdl2.remove(1);
      System.out.println(tdl2);
      System.out.println(tdl2.hashCode());
      ToDoList tdl3 = (ToDoList) tdl2.clone();
      System.out.println("Equal? " + tdl3.equals(tdl2));
      Iterator iter = tdl2.iterator();
      while (iter.hasNext())
         System.out.println(iter.next());
   }
}
