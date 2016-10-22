public interface Sequence
{
   void addFirst(Object o);            // prepends an object
   void addLast(Object o);             // appends an object
   void addIndex(int pos, Object o);   // inserts object at position pos
   Object getIndex(int pos);           // retrieves object at position pos
   Object getFirst();                  // retrieves first object
   Object getLast();                   // retrieves last object
   void removeFirst();                 // deletes first object
   void removeLast();                  // deletes last object
   void removeIndex(int pos);          // deletes object at position pos
   void remove(Object o);              // deletes first object that equals o
   void setFirst(Object o);            // replaces first object
   void setLast(Object o);             // replaces last object
   void setIndex(int pos, Object o);   // replaces object in position pos
   int indexOf(Object o);              // returns index of first object that
                                       //   equals o, or -1 if none found
   void clear();                       // removes all objects
   int size();                         // returns # of objects in sequence
   java.util.Iterator iterator();      // returns an iterator for traversal
}

