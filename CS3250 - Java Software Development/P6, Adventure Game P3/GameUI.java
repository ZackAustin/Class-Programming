import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.text.DefaultCaret;
import java.util.*;
import java.io.*;
import javax.swing.text.DefaultCaret;
import javax.swing.BorderFactory;
import javax.swing.border.Border;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;

public class GameUI extends JFrame implements MouseListener, ActionListener
{
	private JTextArea gameTextArea;
	private JScrollPane gameText;

	private JLabel gridCells[];
	private ImageIcon cellImages[];
	protected JPanel gridPanel;
	private JPanel textAreaPanel;
	private JPanel centerPanel;
	GridBagConstraints dynamicField = new GridBagConstraints();

	private JTextField userMessages;
	private JPanel messagePanel;

	private JButton load;
	private JButton save;
	private JButton quit;
	private JPanel buttonPanel;
	private JPanel sidePanel;

	private JLabel marginResizer;

	private File openFile;
	private File saveFile;
	private final JFileChooser fc = new JFileChooser();

	private Player player;
	protected ArrayList<BufferedImage> images = new ArrayList<>(Adventure.GRID_SIZE);

	private boolean firstTimeSaved = true;
	private boolean saveFileSet = false;
	private boolean openFileSet = false;

	public GameUI(String title, Player player)
	{
		super(title);
		this.player = player;
	
		setupUIButtons();

		setupUserMessages();

		//Holds both the Grid and TextArea so they'll get dynamic resizing.
		centerPanel = new JPanel(new GridBagLayout());

		setupMapDisplay();

		setupKeyBinds();

		setupTextArea();

		userMessages.requestFocusInWindow();
		setMinimumSize(new Dimension(300, 200));
		setDefaultCloseOperation(3);
	}

	private void setupUIButtons()
	{
		//buttons
		load = new JButton("Load Game");
		load.addActionListener(this);
		save = new JButton("Save Game");
		save.addActionListener(this);
		save.setMaximumSize(load.getPreferredSize());
		quit = new JButton("Quit");
		quit.setMaximumSize(load.getPreferredSize());
		quit.addActionListener(this);

		buttonPanel = new JPanel();
		buttonPanel.setLayout(new BoxLayout(buttonPanel, BoxLayout.PAGE_AXIS));

		buttonPanel.setBorder(BorderFactory.createEmptyBorder(20, 2, 50, 2));
		buttonPanel.add(Box.createHorizontalGlue());
		buttonPanel.add(load);
		buttonPanel.add(Box.createRigidArea(new Dimension(0, 5)));
		buttonPanel.add(save);
		buttonPanel.add(Box.createRigidArea(new Dimension(0, 5)));
		buttonPanel.add(quit);

		add(buttonPanel, BorderLayout.LINE_START);
	}

	private void setupUserMessages()
	{
		//command messages
		userMessages = new JTextField();
		userMessages.addActionListener(this);

		messagePanel = new JPanel(new GridBagLayout());
		GridBagConstraints textFieldPadding = new GridBagConstraints();
		textFieldPadding.fill = GridBagConstraints.HORIZONTAL;
		textFieldPadding.ipadx = 10;
		textFieldPadding.ipady = 10;
		textFieldPadding.insets = new Insets(5, 45, 5, 45);
		textFieldPadding.weightx = 0.2;
		textFieldPadding.gridy = 0;

		messagePanel.add(userMessages, textFieldPadding);
		add(messagePanel, BorderLayout.PAGE_END);
	}

	private void setupMapDisplay()
	{
		//map display
		gridPanel = new JPanel();
		gridPanel.setLayout(new GridLayout(Adventure.ROW_SIZE, Adventure.COLUMN_SIZE));
		gridCells = new JLabel[25];
		//cellImages = new ImageIcon[25];
		drawGrid();
		gridPanel.setBorder(BorderFactory.createEmptyBorder(20, 20, 15, 0));
		updateGrid();

		dynamicField.fill = GridBagConstraints.BOTH;
		dynamicField.gridx = 0;
		dynamicField.gridy = 0;
		dynamicField.weightx = 0.6;
		dynamicField.weighty = 0.6;
		dynamicField.ipadx = 0;
		dynamicField.ipady = 0;
		dynamicField.gridwidth = 3;

		centerPanel.add(gridPanel, dynamicField);

		//blank-resized-margin

		marginResizer = new JLabel("");

		dynamicField.gridx = 3;
		dynamicField.weightx = 0.02;
		dynamicField.weighty = 0.02;
		dynamicField.gridwidth = 1;

		centerPanel.add(marginResizer, dynamicField);
	}

	private void setupKeyBinds()
	{
		//Keybinds
		KeyStroke leftArrowKey = KeyStroke.getKeyStroke(KeyEvent.VK_LEFT, 0, true);
		String ACTION_LEFTARROW = "Go Left";
		KeyStroke rightArrowKey = KeyStroke.getKeyStroke(KeyEvent.VK_RIGHT, 0, true);
		String ACTION_RIGHTARROW = "Go Right";
		KeyStroke upArrowKey = KeyStroke.getKeyStroke(KeyEvent.VK_UP, 0, true);
		String ACTION_UPARROW = "Go Up";
		KeyStroke downArrowKey = KeyStroke.getKeyStroke(KeyEvent.VK_DOWN, 0, true);
		String ACTION_DOWNARROW = "Go Down";

		Action leftAction = new ArrowAction("Activated left key", "go west", new Integer(KeyEvent.VK_LEFT));
		Action rightAction = new ArrowAction("Activated right key", "go east", new Integer(KeyEvent.VK_RIGHT));
		Action upAction = new ArrowAction("Activated up key", "go north", new Integer(KeyEvent.VK_UP));
		Action downAction = new ArrowAction("Activated down key", "go south", new Integer(KeyEvent.VK_DOWN));


		JPanel mainPanel = (JPanel) this.getContentPane();
		mainPanel.getInputMap(mainPanel.WHEN_IN_FOCUSED_WINDOW).put(leftArrowKey, ACTION_LEFTARROW);
		mainPanel.getActionMap().put(ACTION_LEFTARROW, leftAction);

		mainPanel.getInputMap(mainPanel.WHEN_IN_FOCUSED_WINDOW).put(rightArrowKey, ACTION_RIGHTARROW);
		mainPanel.getActionMap().put(ACTION_RIGHTARROW, rightAction);

		mainPanel.getInputMap(mainPanel.WHEN_IN_FOCUSED_WINDOW).put(upArrowKey, ACTION_UPARROW);
		mainPanel.getActionMap().put(ACTION_UPARROW, upAction);

		mainPanel.getInputMap(mainPanel.WHEN_IN_FOCUSED_WINDOW).put(downArrowKey, ACTION_DOWNARROW);
		mainPanel.getActionMap().put(ACTION_DOWNARROW, downAction);
	}

	private void setupTextArea()
	{
		//text area
		gameTextArea = new JTextArea();
		gameTextArea.setColumns(10);
		gameTextArea.setEditable(false);
		gameTextArea.setLineWrap(true);
		gameTextArea.setWrapStyleWord(true);
		gameTextArea.setMargin(new Insets(5, 5, 5, 5));
		DefaultCaret caret = (DefaultCaret)gameTextArea.getCaret();
		caret.setUpdatePolicy(DefaultCaret.ALWAYS_UPDATE);

		gameText = new JScrollPane(gameTextArea, 22, 30);

		textAreaPanel = new JPanel(new GridLayout(1, 1));
		textAreaPanel.add(gameText);

		dynamicField.fill = GridBagConstraints.BOTH;
		dynamicField.gridx = 4;
		dynamicField.weightx = 0.1;
		dynamicField.weighty = 0.1;
		dynamicField.gridwidth = 1;
		dynamicField.ipadx = 120;
		dynamicField.ipady = 120;
		dynamicField.insets = new Insets(20, 5, 15, 15);

		centerPanel.add(textAreaPanel, dynamicField);

		add(centerPanel, BorderLayout.CENTER);

		setVisible(true);
		setSize(900, 600);

		gameTextArea.append("Adventure Game.\n\nCommands:\n\n");
		gameTextArea.append("1. Move Character: go (north, east, south, west).\n");
		gameTextArea.append("2. Check Inventory: i.\n");
		gameTextArea.append("3. Item Commands: take (item name) or drop (item name).\n\n");
	}

	public void actionPerformed(ActionEvent e)
	{
		if (e.getSource() == userMessages)
			userMessageSent();

		else if (e.getSource() == load)
			openButton();

		else if (e.getSource() == save)
			saveButton();

		else if (e.getSource() == quit)
			System.exit(0);
	}

	private void openButton()
	{
		//file dialog
		int returnVal = fc.showOpenDialog(GameUI.this);
			
		if (returnVal == JFileChooser.APPROVE_OPTION)
		{
			//file was set, grab that file path, store it for use.
			openFile = new File(fc.getSelectedFile() + "");
			openFileSet = true;
		}
		if (openFileSet)
		{
			try
			{
				FileInputStream fileIn = new FileInputStream(openFile);
				ObjectInputStream in = new ObjectInputStream(fileIn);
				player = (Player) in.readObject();
				in.close();
				fileIn.close();
				userMessages.requestFocusInWindow();
				updateGrid();
				resetTextArea();
			}
			catch(IOException x)
			{
				x.printStackTrace();
			}
			catch(ClassNotFoundException x)
			{
				System.out.println("Player class not found");
				x.printStackTrace();
			}
		}
	}

	private void saveButton()
	{
		if (firstTimeSaved)
		{
			//file dialog
			int returnVal = fc.showSaveDialog(GameUI.this);
				
			if (returnVal == JFileChooser.APPROVE_OPTION)
			{
				//file was set, grab that file path, store it for use.
				saveFile = new File(fc.getSelectedFile() + "");
				firstTimeSaved = false;
				saveFileSet = true;
			}
		}
		if (saveFileSet)
		{
			try
			{
				FileOutputStream fileOut = new FileOutputStream(saveFile);
				ObjectOutputStream out = new ObjectOutputStream(fileOut);
				out.writeObject(player);
				out.close();
				fileOut.close();
			}
			catch (IOException x)
			{
				x.printStackTrace();
			}
		}
		userMessages.requestFocusInWindow();
	}

	protected synchronized void appendTextArea(String text)
	{
		gameTextArea.append(text);
		gameTextArea.setCaretPosition(gameTextArea.getDocument().getLength());
	}

	private void resetTextArea()
	{
		gameTextArea.setText("");
		gameTextArea.append("Adventure Game.\n\nCommands:\n\n");
		gameTextArea.append("1. Move Character: go (north, east, south, west).\n");
		gameTextArea.append("2. Check Inventory: i.\n");
		gameTextArea.append("3. Item Commands: take (item name) or drop (item name).\n\n");
		gameTextArea.setCaretPosition(gameTextArea.getDocument().getLength());
	}

	protected void userMessageSent()
	{
		String message = userMessages.getText();
		String mapPosition = player.direction(message);
		String itemMessage = message.toLowerCase().trim().charAt(0) + "";

		//Map Locations.
		if (!(mapPosition.equals("")))
		{
			//draw a new map.
			updateGrid();
		}
		//inventory
		else if (message.toLowerCase().trim().charAt(0) == 'i')
		{
			gameTextArea.append(player.inventory());
		}
		//take
		else if (itemMessage.equals("t"))
		{
			player.moveItem(message, player.items, player.map.mapItems);
		}
		//drop
		else if (itemMessage.equals("d"))
		{
			player.moveItem(message, player.map.mapItems, player.items);
		}
		else
		{
			gameTextArea.append("Invalid command: " + message);
		}

		gameTextArea.append(mapPosition + "\nYou are at location " + player + "\n\n");

		//check for potential items.
		checkMapItems();

		userMessages.setText("");
		gameTextArea.setCaretPosition(gameTextArea.getDocument().getLength());
		userMessages.requestFocusInWindow();
	}

	protected void drawGrid()
	{
		try
		{
			for (int i = 0; i < Adventure.GRID_SIZE; i++)
			{
				BufferedImage myImage = ImageIO.read(new File("out.png"));
				images.add(myImage);
				final int pos = i;

				gridCells[i] = new JLabel()
				{
					public void paintComponent(Graphics g)
					{
						super.paintComponent(g);
						g.drawImage((BufferedImage)images.get(pos), 0, 0, getWidth(), getHeight(), this);
					}
				};
				gridCells[i].setOpaque(false);
				gridPanel.add(gridCells[i]);
				//gridCells[i].setBorder(BorderFactory.createLineBorder(Color.BLACK));
	        	gridCells[i].addMouseListener(this);
			}
		}
		catch (IOException x)
		{
			x.printStackTrace();
		}
	}

	protected void updateGrid()
	{
		int counter = 0;
		for (int i = 0 - player.map.visibility; i <= player.map.visibility; i++)
		{
			for (int j = 0 - player.map.visibility; j <= player.map.visibility; j++)
			{
				//i curr row, j curr col.
				int curRow = player.map.playerLocation.row + i;
				int curCol = player.map.playerLocation.column + j;

				Graphics g = ((BufferedImage) images.get(counter)).getGraphics();
				BufferedImage currentImage = (BufferedImage) images.get(counter);

				if (curRow < 0 || curCol < 0 || curRow >= player.map.levelMap.length || curCol >= player.map.levelMap[curRow].length())
				{
					try
					{
						currentImage = ImageIO.read(new File("out.png"));
						g.drawImage(currentImage, 0, 0, player.map.tileWidth, player.map.tileHeight, this);
					}
					catch (IOException x)
					{
						x.printStackTrace();
					}
				}
				else if (curRow == player.map.playerLocation.row && curCol == player.map.playerLocation.column)
				{
					try
					{
						currentImage = ImageIO.read(new File(player.map.tileMap.get(player.map.levelMap[curRow].charAt(curCol) + "")));
						g.drawImage(currentImage, 0, 0, player.map.tileWidth, player.map.tileHeight, this);
						currentImage = ImageIO.read(new File("person.png"));
						g.drawImage(currentImage, 0, 0, player.map.tileWidth, player.map.tileHeight, this);
					}
					catch (IOException x)
					{
						x.printStackTrace();
					}
				}
				else
				{
					try
					{
						currentImage = ImageIO.read(new File(player.map.tileMap.get(player.map.levelMap[curRow].charAt(curCol) + "")));
						g.drawImage(currentImage, 0, 0, player.map.tileWidth, player.map.tileHeight, this);
					}
					catch (IOException x)
					{
						x.printStackTrace();
					}
				}
				gridCells[counter].setBackground(Color.white);
				gridCells[counter].repaint();
				counter++;
			}
		}
		this.repaint();
	}

	protected void checkMapItems()
	{
		String itemsHere = player.checkItemsAtLocation();
		gameTextArea.append(itemsHere);
		gameTextArea.setCaretPosition(gameTextArea.getDocument().getLength());
	}

	//arrow movement keybinds
	private class ArrowAction extends AbstractAction
	{
		final String direction;
		public ArrowAction(String text, String desc, Integer mnemonic)
		{
			super(text);
			putValue(SHORT_DESCRIPTION, desc);
			putValue(MNEMONIC_KEY, mnemonic);
			direction = desc;
		}

		public void actionPerformed(ActionEvent e)
		{
			String mapPosition = player.direction(direction);
			updateGrid();
			gameTextArea.append(mapPosition + "\nYou are at location " + player + "\n\n");
			checkMapItems();
		}
	}

	public void mouseClicked(MouseEvent e)
	{
    	JLabel clickedPanel = (JLabel) e.getSource();
    }

	public void mousePressed(MouseEvent e){}
    public void mouseReleased(MouseEvent e){}
    public void mouseEntered(MouseEvent e){}
    public void mouseExited(MouseEvent e){}
}