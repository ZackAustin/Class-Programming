import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class SwingObserverExample {
   static JFrame frame = new JFrame();

   public static void main(String[] args) {
      Toolkit kit = Toolkit.getDefaultToolkit();
      Dimension screenSize = kit.getScreenSize();
      int screenHeight = screenSize.height;
      int screenWidth = screenSize.width;

      // Center frame in screen
      frame.setSize(screenWidth / 2 - 75, screenHeight / 2 - 75);
      frame.setLocation(screenWidth / 4 + 37, screenHeight / 4 + 37);

      // Set title, add button
      frame.setTitle("Listener Example");
      JButton button = new JButton("Should I do it?");

      // Here are the listeners (observers)
      button.addActionListener(new ActionListener() {
         public void actionPerformed(ActionEvent e) {
            System.out.println("Don't do it, you might regret it!");
         }
      });
      button.addActionListener(new ActionListener() {
         public void actionPerformed(ActionEvent e) {
            System.out.println("Come on, do it!");
         }
      });

      frame.getContentPane().add(BorderLayout.CENTER, button);
      frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
      frame.setVisible(true);
   }
}
