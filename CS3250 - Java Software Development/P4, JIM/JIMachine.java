import java.awt.event.*;
import javax.swing.*;
import java.awt.*;
import java.io.*;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;

class JIMachine extends JFrame implements ActionListener
{
	private JButton openButton;
	private JButton zoomInButton;
	private JButton origSizeButton;
	private JButton zoomOutButton;
	private JButton quitButton;
	private Panel buttonPanel;
	private final JFileChooser fc = new JFileChooser();
	private File openFile;
	private imagePainter draw;
	
	public JIMachine()
	{
		//gui setup
		openButton = new JButton("Open");
		zoomInButton = new JButton("Zoom In");
		origSizeButton = new JButton("100%");
		zoomOutButton = new JButton("Zoom Out");
		quitButton = new JButton("Quit");
		
		//Flow Panel for Buttons
		buttonPanel = new Panel();
		buttonPanel.setLayout(new FlowLayout(0));
		buttonPanel.add(openButton);
		buttonPanel.add(zoomInButton);
		buttonPanel.add(origSizeButton);
		buttonPanel.add(zoomOutButton);
		buttonPanel.add(quitButton);
		
		openButton.addActionListener(this);
		zoomInButton.addActionListener(this);
		origSizeButton.addActionListener(this);
		zoomOutButton.addActionListener(this);
		quitButton.addActionListener(this);
		
		//innerclass creation
		draw = new imagePainter();
	}
	
	public void actionPerformed(ActionEvent e)
	{
		if (e.getSource() == openButton)
			openFilePerformed();
		else if (e.getSource() == zoomInButton)
			zoomInPerformed();
		else if (e.getSource() == origSizeButton)
			originalSizePerformed();
		else if (e.getSource() == zoomOutButton)
			zoomOutPerformed();
		else if (e.getSource() == quitButton)
			System.exit(0);
	}
	
	private void openFilePerformed()
	{
		//file dialog
		int returnVal = fc.showOpenDialog(JIMachine.this);
			
		if (returnVal == JFileChooser.APPROVE_OPTION)
		{
			//file was set, grab that file path, store it for use.
			openFile = new File(fc.getSelectedFile() + "");
				
			//reset innerclass instance variables for new print object.
			draw.zoomRatio = 0;
			draw.height = draw.ORIG_HEIGHT;
			draw.width = draw.ORIG_WIDTH;
			drawImage();
		}	
	}
	
	private void zoomInPerformed()
	{
		draw.zoomRatio += 0.25;
		if (draw.zoomRatio != 0.0)
		{
			double heightAddition = Math.abs(draw.ORIG_HEIGHT * draw.zoomRatio);
			draw.height += heightAddition;
			double widthAddition = Math.abs(draw.ORIG_WIDTH * draw.zoomRatio);
			draw.width += widthAddition;
		}
		else
		{
			draw.height = draw.ORIG_HEIGHT;
			draw.width = draw.ORIG_WIDTH;
		}
		drawImage();
	}
	
	private void originalSizePerformed()
	{
		draw.zoomRatio = 0;
		draw.height = draw.ORIG_HEIGHT;
		draw.width = draw.ORIG_WIDTH;
		drawImage();
	}
	
	private void zoomOutPerformed()
	{
		draw.zoomRatio -= 0.25;
		
		if (draw.zoomRatio != 0.0)
		{
			double heightSubtraction = Math.abs(draw.ORIG_HEIGHT * draw.zoomRatio);
			double tmpHeight = draw.height - heightSubtraction;
			double widthSubtraction = Math.abs(draw.ORIG_WIDTH * draw.zoomRatio);
			double tmpWidth = draw.width - widthSubtraction;
			if (tmpHeight > 1 && tmpWidth > 1)
			{
				draw.height = tmpHeight;
				draw.width = tmpWidth;
			}
			else draw.zoomRatio += 0.25;
		}
		else
		{
			draw.height = draw.ORIG_HEIGHT;
			draw.width = draw.ORIG_WIDTH;
		}
		drawImage();
	}
	
	private void drawImage()
	{
		try
		{
			draw.img = ImageIO.read(openFile);
		}
		catch (IOException x)
		{
			x.printStackTrace();
		}
		draw.repaint();
	}
	
	class imagePainter extends JPanel
	{
		BufferedImage img = null;
		double zoomRatio;
		final int ORIG_HEIGHT = 360;
		final int ORIG_WIDTH = 240;
		double height;
		double width;
		
		public imagePainter()
		{
			height = ORIG_HEIGHT;
			width = ORIG_WIDTH;
			zoomRatio = 0.0;
		}
	
		public void paintComponent(Graphics g)
		{
			super.paintComponent(g);
			if (img != null)
				g.drawImage(img, 10, 10, (int) height, (int) width, this);
		}
	}
	
	public static void main(String[] args)
	{
		JIMachine frame = new JIMachine();
		frame.setSize(600, 500);
		frame.add(frame.buttonPanel, BorderLayout.PAGE_START);
		frame.add(frame.draw, BorderLayout.CENTER);
		frame.setVisible(true);
		frame.setDefaultCloseOperation(3);
	}
}