// ListSequence.java: A Singly-linked list with an iterator
// Author: Chuck Allison, March 2004
import java.util.*;

public class ListSequence extends AbstractSequence {
   static class Node {
      Object data;
      Node next;
      Node(Object data, Node next) {
         this.data = data;
         this.next = next;
      }
   }
   protected Node first = new Node(null,null);  // Artificial header node

   // List-specific implementation
   public void addIndex(int pos, Object obj) {
      if (obj == null)
         throw new IllegalArgumentException("Null pointer in ListSequence.addIndex");
      if (pos < 0 || pos > size())
         throw new IllegalArgumentException("invalid position in ListSequence.addIndex");
      Node prevNode = ((ListSeqIterator) nthIterator(pos-1)).getCurrentNode();
      prevNode.next = new Node(obj, prevNode.next);
   }
   public void setIndex(int pos, Object obj) {
      if (size() == 0)
         throw new IllegalStateException("underflow error in ListSequence.setIndex");
      if (obj == null)
         throw new IllegalArgumentException("null pointer in ListSequence.setIndex");
      if (pos < 0 || pos >= size())
         throw new IllegalArgumentException("invalid position in ListSequence.setIndex");
      ListSeqIterator it = (ListSeqIterator) nthIterator(pos);
      it.getCurrentNode().data = obj;
   }
   // Inner iterator class
   class ListSeqIterator implements Iterator {
      private Node currNode = first;   // The last node seen by next()
      private Node prevNode = null;    // The node before currNode
      private boolean removeOkay = false;

      public boolean hasNext() {
         assert currNode != null;      // Class invariant
         return currNode.next != null;
      }
      public Object next() {
         assert currNode != null;
         if (currNode.next == null) {
            // We ran off the right end
            removeOkay = false;
            throw new NoSuchElementException("Too many calls to next()");
         }
         else {
            prevNode = currNode;
            currNode = currNode.next;
            removeOkay = true;
            return currNode.data;
         }
      }
      public void remove() {
         if (!removeOkay)
            throw new IllegalStateException("Attempt to remove via iterator without calling next()");
         assert currNode != null;
         assert prevNode != null;
         prevNode.next = currNode.next;
         currNode = prevNode;
         removeOkay = false;
      }

      // Extra, non-client function
      Node getCurrentNode() {
         return currNode;  // Most recent node visited by next()
      }
   }
   public Iterator iterator() {
      return new ListSeqIterator();
   }
}

