// ArraySequence.java: An expandable array implementing Sequence
// Author: Chuck Allison, March 2004
// NOTE: This version grows by expanding the underlying array
//       by a factor of floor(1.5)

import java.util.*;

public class ArraySequence extends AbstractSequence {
   protected Object[] data;
   protected int count;
   protected static int MIN_ALLOC = 10; // Must be > 1

   // Utility functions
   protected void shuffleRight(int pos) {
      assert 0 <= pos;  // "=" for appending
      assert pos <= count;
      assert count < data.length;
      System.arraycopy(data, pos, data, pos+1, count-pos);
   }
   protected void shuffleLeft(int pos) {
      assert 0 <= pos;
      assert pos < count;
      assert count-pos-1 < data.length;
      System.arraycopy(data, pos+1, data, pos, count-pos-1);
   }
   protected void init(int size) {
      data = new Object[size];
      count = 0;
   }
   private void checkCapacity() {
      assert count <= data.length;
      if (count == data.length) {
         // Grow array
         Object[] newData = new Object[(int)(1.5*data.length)];
         System.arraycopy(data, 0, newData, 0, data.length);
         data = newData;
         assert count < data.length;
      }
   }

   // Class Interface
   public ArraySequence() {
      init(MIN_ALLOC);
   }
   public void addIndex(int pos, Object obj) {
      if (obj == null)
         throw new IllegalArgumentException("Null pointer in ArraySequence.addIndex");
      if (pos < 0 || pos > count)
         throw new IllegalArgumentException("Invalid position in ArraySequence.addIndex");
      checkCapacity();
      if (count > 0)
         shuffleRight(pos);
      data[pos] = obj;
      ++count;
   }
   public void setIndex(int pos, Object obj) {
      if (count == 0)
         throw new IllegalStateException("Underflow error in ArraySequence.setIndex");
      if (obj == null)
         throw new IllegalArgumentException("Null pointer in ArraySequence.setIndex");
      if (pos < 0 || pos >= count)
         throw new IllegalArgumentException("Invalid position in ArraySequence.setIndex");
      data[pos] = obj;
   }
   public Iterator iterator() {
      // Anonymous inner class
      return new Iterator() {
         private int lastIndex = -1;   // The last index visited by next()
         private boolean removeOkay = false;
         public boolean hasNext() {
            return lastIndex+1 < count;
         }
         public Object next() {
            if (hasNext()) {
               removeOkay = true;
               return data[++lastIndex];
            }
            else {
               removeOkay = false;
               throw new NoSuchElementException("Too many calls to next()");
            }
         }
         public void remove() {
            if (!removeOkay)
               throw new IllegalStateException("Attempt to remove via iterator without calling next()");
            assert lastIndex >= 0;
            assert lastIndex < count;
            shuffleLeft(lastIndex--);
            --count;
            removeOkay = false;
         }
      };
   }
}

