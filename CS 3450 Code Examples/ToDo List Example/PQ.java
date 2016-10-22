/** An interface for priority queues.
 * @version Program 5
 */
public interface PQ extends java.util.Collection {
   /** A class to hold an object and its priority
    */
   class Entry implements java.io.Serializable {
      private Object data;
      private int priority;

      public Entry(Object data, int priority) {
         this.data = data;
         this.priority = priority;
      }
      public boolean equals(Object o) {
         if (this == o)
            return true;
         else if (!(o instanceof Entry))
            return false;
         else {
            Entry other = (Entry) o;
            return data.equals(other.data) && priority == other.priority;
         }
      }
      public int hashCode() {
         return 37*data.hashCode() + priority;
      }
      /** Forms a string of the form "(object, priority)".
       * @return The string representation of the Entry.
       */
      public String toString() {
         return "(" + data + "," + priority + ")";
      }
      public Object getData() {
         return data;
      }
      public int getPriority() {
         return priority;
      }
   }
         
   /** Adds an object at the indicated priority.
    * @param data The object
    * @param priority The object's priority
    * @return true if the object was added, false if it was already there
    */
   boolean add(Object data, int priority);
   /** Retrieves the first object of highest priority.
    * @return The highest-priority object
    */
   Entry getFirst();
   /** Removes the first object of highest priority.
    * @return The highest-priority object
    */
   Entry removeFirst();
   /** Retrieves the object in priority position 'pos'.
    * @return The pos'th object
    */
   Entry get(int pos);
   /** Removes the object in priority position 'pos'.
    * @return The pos'th object
    */
   Entry remove(int pos);
}

