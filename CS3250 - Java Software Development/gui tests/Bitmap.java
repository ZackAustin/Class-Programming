import java.awt.*;
import javax.swing.*;
import java.awt.event.*;
import javax.imageio.ImageIO;
import java.io.*;
import java.util.*;
import java.awt.image.BufferedImage;
import javax.swing.JFrame;
import java.awt.Frame;
import java.awt.Container;
import java.awt.Component;

public class Bitmap extends JPanel
{
	BufferedImage img = null;
	
	public void paintComponent(Graphics g)
	{
		if (img != null)
		{
			g.drawImage(img, 10, 10, 180, 120, this);
		}
	}
	
	public static void main(String args[])
	{
		
		JFrame frame = new JFrame();
		Container cp = frame.getContentPane();
		Button Open = new Button("Open File");
		Button ZoomOut = new Button("Zoom Out");
		Button ZoomIn = new Button("Zoom In");
		Panel buttonPanel = new Panel();
		buttonPanel.setLayout(new FlowLayout(0));
		buttonPanel.add(Open);
		buttonPanel.add(ZoomOut);
		buttonPanel.add(ZoomIn);
		
		
		Bitmap draw = new Bitmap();
		frame.add(draw);
		frame.setSize(200, 150);
		frame.setVisible(true);
		frame.add("North", buttonPanel);
		try
		{
			draw.img = ImageIO.read(new File("dunluce.jpg"));
		}
		catch (IOException x)
		{
			x.printStackTrace();
		}
		
		frame.setDefaultCloseOperation(3);
		
		draw.repaint();
	}
}