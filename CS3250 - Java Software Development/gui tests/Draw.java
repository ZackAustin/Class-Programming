import java.awt.*;
import javax.swing.*;

public class Draw extends JPanel
{
	public void paintComponent(Graphics g)
	{
		super.paintComponent(g);
		g.setColor(Color.blue);
		g.fillOval(10, 20, 30, 30);
	}
	
	public static void main(String args[])
	{
		JFrame frame = new JFrame();
		Draw draw = new Draw();
		frame.add(draw);
		frame.setSize(200, 150);
		frame.setVisible(true);
	}
}