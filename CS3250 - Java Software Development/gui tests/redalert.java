import java.awt.event.*;
import javax.swing.*;

class redalert extends JFrame implements ActionListener
{
	private JButton redAlertButton;
	
	public redalert()
	{
		redAlertButton = new JButton("Red Alert");
		add(redAlertButton);
		redAlertButton.addActionListener(this);
	}
	
	public void actionPerformed(ActionEvent e)
	{
		if (e.getActionCommand().equals("Red Alert"))
		{
			System.out.println("Shields up!");
		}
	}
	
	public static void main(String[] args)
	{
		redalert frame = new redalert();
		frame.setSize(200, 100);
		frame.setVisible(true);
	}	
}