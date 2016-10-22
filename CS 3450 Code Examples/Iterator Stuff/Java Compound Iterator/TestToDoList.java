import java.io.*;
import java.util.*;

class TestToDoList {
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
