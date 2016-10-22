// Program6.java: A GUI for a ToDoList.
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.util.*;
import java.io.*;

public class Program6 {
   // GUI-level objects (must be visible throughout package)
   static ListFrame frame;
   static ToDoList items = new ToDoList();
   static boolean saveRequired = false;
   static AddHandler addHandler = new AddHandler();
   static SaveHandler saveHandler = new SaveHandler();
   static QuitHandler quitHandler = new QuitHandler();

   public static void main(String[] args) {
      try {
         // Set default look-and-feel
         UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
      } catch (Exception e) {}

      // Create and launch frame
      frame = new ListFrame();
      frame.addWindowListener(
         new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
               quitHandler.actionPerformed(null);
            }
         });
      initialize(); // For testing only
      frame.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE);
      frame.show();  
   }
   static void initialize() {
      // Fill list box for testing
      addHandler.addEntry("Get Haircut", 2);
      addHandler.addEntry("Take dog to vet", 3);
      addHandler.addEntry("Cash paycheck", 4);
      addHandler.addEntry("Ask for vacation day Friday", 1);
      addHandler.addEntry("Renew Driver's License", 3);
      addHandler.addEntry("Pay attention to wife", 1);
      addHandler.addEntry("Lift weights", 0);
      addHandler.addEntry("Play guitar", 0);
      addHandler.addEntry("Christmas shopping", 2);
      addHandler.addEntry("Order filets from butcher", 3);
      addHandler.addEntry("Get roof fixed", 4);
      addHandler.addEntry("Call fence contractor", 4);
      addHandler.addEntry("Prepare C++ seminar", 3);
      addHandler.addEntry("Correct 3240 homework", 3);
      addHandler.addEntry("Correct 4450 tests", 4);
      addHandler.addEntry("Get to bed early!", 2);
      addHandler.addEntry("Buy \"I Can't Believe it's not Tofu!\"", 0);
      addHandler.addEntry("Lose weight", 1);
      addHandler.addEntry("Pay mortgage", 4);
      addHandler.addEntry("Write Letter of Recommendation", 3);
      addHandler.addEntry("Replenish food storage", 2);
   }
}

class ListFrame extends JFrame {
   JList list;  // Must be visible for handlers

   public ListFrame() {
      // Get screen dimensions
      Toolkit kit = Toolkit.getDefaultToolkit();
      Dimension screenSize = kit.getScreenSize();
      int screenHeight = screenSize.height;
      int screenWidth = screenSize.width;

      // Center frame in screen
      setSize(screenWidth / 2 - 75, screenHeight / 2 - 75);
      setLocation(screenWidth / 4 + 37, screenHeight / 4 + 37);

      // Set title, add the button panel
      setTitle("(Unnamed ToDoList)");
      Container cp = getContentPane();
      cp.setLayout(new BorderLayout());   // Optional
      cp.add(new ButtonPanel(), BorderLayout.SOUTH);

      // Define scrollable listbox
      list = new JList(new DefaultListModel());
      list.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
      JScrollPane sp = new JScrollPane(list);
      cp.add(sp, BorderLayout.CENTER);
   }
}

class ButtonPanel extends JPanel {
   public ButtonPanel() {
      // Create buttons
      JButton addButton = new JButton("Add");
      JButton removeButton = new JButton("Remove");
      JButton clearButton = new JButton("Clear");
      JButton saveButton = new JButton("Save");
      JButton loadButton = new JButton("Load");
      JButton quitButton = new JButton("Quit");

      // Add buttons to panel
      add(addButton);
      add(removeButton);
      add(clearButton);
      add(saveButton);
      add(loadButton);
      add(quitButton);

      // Add handlers to buttons
      addButton.addActionListener(Program6.addHandler);
      removeButton.addActionListener(new RemoveHandler());
      clearButton.addActionListener(new ClearHandler());
      saveButton.addActionListener(Program6.saveHandler);
      loadButton.addActionListener(new LoadHandler());
      quitButton.addActionListener(Program6.quitHandler);
   }
}

class AddHandler implements ActionListener {
   // Nested class for dialog
   private static class AddDialog extends JDialog {
      private JTextField itemPriority = new JTextField("");
      private JTextField itemDescription = new JTextField("");
      private boolean status;
      public AddDialog(JFrame owner) {
         super(owner, "Add a Todo item", true);  // Make modal
   
         // Use a GridLayout for the two fields
         JPanel panel = new JPanel();
         panel.setLayout(new GridLayout(2,2));
         panel.add(new JLabel("Priority:"));
         panel.add(itemPriority);
         panel.add(new JLabel("Description:"));
         panel.add(itemDescription);
         getContentPane().add(panel, BorderLayout.CENTER);
   
         // Add buttons to bottom of dialog
         JButton okButton = new JButton("OK");
         okButton.addActionListener(new
            ActionListener() {
               public void actionPerformed(ActionEvent e) {
                  status = true;
                  setVisible(false);
               }
            });
         JButton cancelButton = new JButton("Cancel");
         cancelButton.addActionListener(new
            ActionListener() {
               public void actionPerformed(ActionEvent e) {
                  status = false;
                  setVisible(false);
               }
            });
         JPanel buttonPanel = new JPanel();
         buttonPanel.add(okButton);
         buttonPanel.add(cancelButton);
         getContentPane().add(buttonPanel, BorderLayout.SOUTH);
         pack(); // No need for setSize(); this auto-fits
      }
      public boolean getStatus() {
         return status;  // True = OK, False = Cancel
      }
      public int getPriority() {
         String text = itemPriority.getText();
         return text.length() == 0 ? 0 : Integer.parseInt(text);
      }
      public String getDescription() {
         return itemDescription.getText();
      }
   }
   public void actionPerformed(ActionEvent e) {
      AddDialog dialog = new AddDialog(Program6.frame);
      dialog.setLocationRelativeTo(Program6.frame);
      dialog.show();
      if (dialog.getStatus()) {
         // Add new entry
         int priority = dialog.getPriority();
         if (priority < 0 || Program6.items.numPriorities() <= priority)
            JOptionPane.showMessageDialog(null, "Invalid priority!",
                                          "Add Error", JOptionPane.PLAIN_MESSAGE);
         else
            addEntry(dialog.getDescription(), priority);
      }
   }
   static void addEntry(String description, int priority) {
      // Add to ToDoList
      ToDoList items = Program6.items;
      items.add(description, priority);

      // Add to List Model
      DefaultListModel model = (DefaultListModel) Program6.frame.list.getModel();
      model.removeAllElements();
      Iterator it = items.iterator();
      while (it.hasNext()) {
         PQ.Entry entry = (PQ.Entry) it.next();
         model.addElement(entry.getPriority() + ": " + entry.getData());
      }
      Program6.saveRequired = true;
   }
}

class RemoveHandler implements ActionListener {
   public void actionPerformed(ActionEvent e) {
      JList list = Program6.frame.list;
      int index = list.getSelectedIndex();
      if (index >= 0) {
         String s = (String) list.getSelectedValue();
         int choice = JOptionPane.showConfirmDialog(null, "Remove " + s + "?");
         if (choice == 0) {
            DefaultListModel model = (DefaultListModel) list.getModel();
            model.removeElementAt(index);
            ToDoList items = Program6.items;
            items.remove(index);
            assert items.size() == model.size();
            Program6.saveRequired = items.size() > 0;
         }
      }
   }
}

class SaveHandler implements ActionListener {
   public void actionPerformed(ActionEvent e) {
      JList list = Program6.frame.list;
      ListModel model = list.getModel();
      int size = model.getSize();
      JFileChooser chooser = new JFileChooser(new File("."));
      int returnVal = chooser.showSaveDialog(Program6.frame);
      if (returnVal == JFileChooser.APPROVE_OPTION) {
         String fileName = chooser.getSelectedFile().getAbsoluteFile().toString();
         try {
            Program6.items.store(fileName);
            Program6.frame.setTitle(fileName);
            Program6.saveRequired = false;
         }
         catch (IOException x) {
            JOptionPane.showMessageDialog(null, x.toString(), "Save Error!",
                                          JOptionPane.PLAIN_MESSAGE);
         }
      }
   }
}
class ClearHandler implements ActionListener {
   public void actionPerformed(ActionEvent e) {
      if (Program6.saveRequired) {
         int choice = JOptionPane.showConfirmDialog(null, "Save ToDoList?");
         if (choice == 0)
            Program6.saveHandler.actionPerformed(e);
         else if (choice == 2)
            return;
      }
      else if (JOptionPane.showConfirmDialog(null, "Clear ToDoList?") != 0)
         return;
      JList list = Program6.frame.list;
      DefaultListModel model = (DefaultListModel) list.getModel();
      model.clear();
      ToDoList items = Program6.items;
      items.clear();
      assert items.size() == model.size();
      Program6.frame.setTitle("(Unnamed ToDoList)");
      Program6.saveRequired = false;
   }
}

class LoadHandler implements ActionListener {
   public void actionPerformed(ActionEvent e) {
      if (Program6.saveRequired)
         Program6.saveHandler.actionPerformed(e);
      JFileChooser chooser = new JFileChooser(new File("."));
      int returnVal = chooser.showOpenDialog(Program6.frame);
      if (returnVal == JFileChooser.APPROVE_OPTION) {
         String fileName = chooser.getSelectedFile().getAbsoluteFile().toString();
         try {
            Program6.items = ToDoList.retrieve(fileName);
            Program6.frame.setTitle(fileName);

            // Refresh the list model
            DefaultListModel model = (DefaultListModel) Program6.frame.list.getModel();
            model.removeAllElements();
            Iterator it = Program6.items.iterator();
            while (it.hasNext()) {
               PQ.Entry entry = (PQ.Entry) it.next();
               model.addElement(entry.getPriority() + ": " + entry.getData());
            }
         }
         catch (IOException x) {
            JOptionPane.showMessageDialog(null, x.toString(), "Save Error!",JOptionPane.PLAIN_MESSAGE);
         }
         catch (ClassNotFoundException x) {
            JOptionPane.showMessageDialog(null, x.toString(), "Save Error!",JOptionPane.PLAIN_MESSAGE);
         }
      }
   }
}

class QuitHandler implements ActionListener {
   public void actionPerformed(ActionEvent e) {
      if (Program6.saveRequired) {
         int choice;
         choice = JOptionPane.showConfirmDialog(null, "Save ToDoList?");
         if (choice == 0)
            Program6.saveHandler.actionPerformed(null);
         else if (choice == 2)
            return;
      }
      System.exit(0);
   }
}
