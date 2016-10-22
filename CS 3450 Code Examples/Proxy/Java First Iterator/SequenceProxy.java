/** A proxy class for sequence implementations.
 * @author Chuck Allison
 * @version Fall 2003
 */
public class SequenceProxy implements Sequence {
   private Sequence seq;
   /** 
    * @param seq A reference to a sequence implementation
    */
   public SequenceProxy(Sequence seq) {
      this.seq = seq;
   }
   /** Attaches the proxy to a new Sequence implementation.
    * @param seq A new sequence implementation
    */
   public void changeSequence(Sequence seq) {
      this.seq = seq;
   }
   public Sequence getSequence() {
      return seq;
   }
   /** Prepends an element to the sequence
    * @param o The element to prepend.
    */
   public void addFirst(Object o) {
      seq.addFirst(o);
   }
   /** Appends an element to the sequence.
    * @param o The element to append.
    */
   public void addLast(Object o) {
      seq.addLast(o);
   }
   /** Inserts an element at a given sequence position.
    * @param pos The insertion point
    * @param o The element to insert
    */
   public void addIndex(int pos, Object o) {
      seq.addIndex(pos, o);
   }
   /** Retrieves the element at a given sequence position.
    * @param pos The position in the sequence
    * @return The indicated sequence element
    */
   public Object getIndex(int pos) {
      return seq.getIndex(pos);
   }
   /** Retrieves the first sequence element
    * @return The indicated sequence element
    */
   public Object getFirst() {
      return seq.getFirst();
   }
   /** Retrieves the last sequence element
    * @return The indicated sequence element
    */
   public Object getLast() {
      return seq.getLast();
   }
   /** Removes the first element from the sequence.
    */
   public void removeFirst() {
      seq.removeFirst();
   }
   /** Removes the last element from the sequence.
    */
   public void removeLast() {
      seq.removeLast();
   }
   /** Removes the element at a given sequence position.
    * @param pos The position of the element to remove.
    */
   public void removeIndex(int pos) {
      seq.removeIndex(pos);
   }
   /** Removes the first occurrence of an object from the sequence.
    * @param o The object to remove.
    */
   public void remove(Object o) {
      seq.remove(o);
   }
   /** Replaces the first sequence element.
    * @param o The replacement object
    */
   public void setFirst(Object o) {
      seq.setFirst(o);
   }
   /** Replaces the last sequence element.
    * @param o The replacement object
    */
   public void setLast(Object o) {
      seq.setLast(o);
   }
   /** Replaces the element at a given sequence position.
    * @param pos The seauence position
    * @param o The replacement object
    */
   public void setIndex(int pos, Object o) {
      seq.setIndex(pos, o);
   }
   /** Searches for an object.
    * @param o The object to find
    * @return The (zero-based) position where the object was found.
    *         Returns -1 of the object is not in the sequence.
    */
   public int indexOf(Object o) {
      return seq.indexOf(o);
   }
   /** Removes all objects fron the sequence.
    * (Just sets the size to zero.)
    */
   public void clear() {
      seq.clear();
   }
   /** Determines the number of elements in the sequence.
    * @return The number of elements.
    */
   public int size() {
      return seq.size();
   }
   /** Reveals the underlying array capacity
    * @return The .length field of the backing array.
    */
   public java.util.Iterator iterator() {
      return seq.iterator();
   }
}

