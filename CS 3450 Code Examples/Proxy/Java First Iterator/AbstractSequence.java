// AbstractSequence.java: Shared implementation for sequences
// Author: Chuck Allison, March 2004
import java.util.*;

public abstract class AbstractSequence implements Sequence {
   // Utility function:
   // This function returns an iterator "pointing" at the
   // element in position pos. It has been visited, so calling
   // next() does not give's this element's data (it moves to the
   // next element). Calling it with -1 "points" at position "-1".
   Iterator nthIterator(int pos) {
      assert -1 <= pos;    // Allow for position "-1"
      assert pos < size();

      // Move to pos'th element (starting from position "-1")
      Iterator it = iterator();
      for (int i = 0; i <= pos; ++i) {
         assert it.hasNext();
         it.next();
      }
      return it;
   }
   
   public void addFirst(Object obj) {
      addIndex(0, obj);
   }
   public void addLast(Object obj) {
      addIndex(size(), obj);
   }
   public Object getIndex(int pos) {
      if (size() == 0)
         throw new IllegalStateException("Underflow in AbstractSequence.getIndex");
      if (pos < 0 || pos >= size())
         throw new IllegalArgumentException("Index error in AbstractSequence.getIndex");
      return nthIterator(pos-1).next();
   }
   public Object getFirst() {
      return getIndex(0);
   }
   public Object getLast() {
      return getIndex(size()-1);
   }
   public void removeFirst() {
      removeIndex(0);
   }
   public void removeLast() {
      removeIndex(size()-1);
   }
   public void removeIndex(int pos) {
      if (size() == 0)
         throw new IllegalStateException("Underflow in AbstractSequence.removeIndex");
      if (pos < 0 || pos >= size())
         throw new IllegalArgumentException("Index error in AbstractSequence.removeIndex");
      nthIterator(pos).remove();
   }
   public void remove(Object obj) {
      int index = indexOf(obj);
      if (index >= 0)
         removeIndex(index);
   }
   public void setFirst(Object obj) {
      setIndex(0, obj);
   }
   public void setLast(Object obj) {
      setIndex(size()-1, obj);
   }
   public int indexOf(Object obj) {
      if (obj != null) {
         // Find object using equals
         Iterator it = iterator();
         for (int index = 0; index < size(); ++index) {
            assert it.hasNext();
            if (obj.equals(it.next()))
               return index;
         }
      }
      return -1;
   }
   public void clear() {
      Iterator it = iterator();
      while (it.hasNext()) {
         it.next();
         it.remove();
      }
   } 
   public int size() {
      int count = 0;
      for (Iterator it = iterator(); it.hasNext(); it.next())
         ++count;
      return count;
   }
}

