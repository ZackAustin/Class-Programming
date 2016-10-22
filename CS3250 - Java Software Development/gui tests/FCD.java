import java.awt.event.*;
import javax.swing.*;
import java.io.*;

class FCD extends JFrame implements ActionListener
{
	private JButton redAlertButton;
	final JFileChooser fc = new JFileChooser();
	
	public FCD()
	{
		redAlertButton = new JButton("Red Alert");
		add(redAlertButton);
		redAlertButton.addActionListener(this);
	}
	
	public void actionPerformed(ActionEvent e)
	{
		if (e.getActionCommand().equals("Red Alert"))
		{
			int returnVal = fc.showOpenDialog(FCD.this);
			
			if (returnVal == JFileChooser.APPROVE_OPTION)
			{
				File file = fc.getSelectedFile();
				System.out.println(file + " file opened.");
			}
			else System.out.println("no file opened.");
		}
	}
	
	public static void main(String[] args)
	{
		FCD frame = new FCD();
		frame.setSize(200, 100);
		frame.setVisible(true);
	}	
}