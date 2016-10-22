import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.text.DefaultCaret;
import java.util.*;
import java.io.*;
import javax.swing.text.DefaultCaret;

public class CRUI extends JFrame implements MouseListener, ActionListener
{
	private JTextArea ANNOutputArea;
	private JScrollPane ANNOutput;
	protected JButton trainANN;
	protected JButton openWeightFile;
	protected JButton tryGridCharacter;
	protected JButton createInputFile;
	private JButton resetGrid;
	private JLabel gridCells[];
	private JPanel buttonPanel;
	protected JPanel gridPanel;
	private JPanel textAreaPanel;
	private JPanel centerPanel;
	protected NeuralNetwork ANN;
	private File openFile;
	private final JFileChooser fc = new JFileChooser();

	public CRUI(String title)
	{
		super(title);

		trainANN = new JButton("Train ANN");
		trainANN.addActionListener(this);

		openWeightFile = new JButton("Open Weight File");
		openWeightFile.addActionListener(this);

		tryGridCharacter = new JButton("Run Grid Character");
		tryGridCharacter.setEnabled(false);
		tryGridCharacter.addActionListener(this);

		resetGrid = new JButton("Reset Grid");
		resetGrid.addActionListener(this);

		createInputFile = new JButton("New Input File");
		createInputFile.addActionListener(this);

		buttonPanel = new JPanel();
		buttonPanel.setLayout(new FlowLayout(1, 5 , 5));
		buttonPanel.add(trainANN);
		buttonPanel.add(openWeightFile);
		buttonPanel.add(tryGridCharacter);
		buttonPanel.add(resetGrid);
		buttonPanel.add(createInputFile);
		add(buttonPanel, BorderLayout.PAGE_START);

		ANNOutputArea = new JTextArea();
		ANNOutputArea.setEditable(false);
		ANNOutputArea.setLineWrap(true);
		ANNOutputArea.setWrapStyleWord(true);
		ANNOutputArea.setMargin(new Insets(5, 5, 5, 5));
		DefaultCaret caret = (DefaultCaret)ANNOutputArea.getCaret();
		caret.setUpdatePolicy(DefaultCaret.ALWAYS_UPDATE);

		ANNOutput = new JScrollPane(ANNOutputArea, 22, 30);

		textAreaPanel = new JPanel();
		textAreaPanel.setLayout(new GridBagLayout());

		GridBagConstraints dynamicField = new GridBagConstraints();
		dynamicField.fill = GridBagConstraints.BOTH;
		dynamicField.weightx = 0.5;
		dynamicField.gridy = 0;
		dynamicField.weighty = 0.5;
		dynamicField.insets = new Insets(22, 45, 60, 15);

		textAreaPanel.add(ANNOutput, dynamicField);

		gridPanel = new JPanel();
		gridPanel.setLayout(new GridLayout(7, 6));
		
		gridCells = new JLabel[CharacterRecognition.INPUT_NEURONS];
		for (int i = 0; i < gridCells.length; i++)
		{
			gridCells[i] = new JLabel("");
        	gridCells[i].setOpaque(true);
        	gridCells[i].setBackground(Color.WHITE);
        	gridCells[i].setBorder(BorderFactory.createLineBorder(Color.BLACK));
        	gridCells[i].addMouseListener(this);
        	gridPanel.add(gridCells[i]);
		}

		gridPanel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 0));

		//Holds both the Grid and TextArea so they'll get equal dynamic resizing.
		centerPanel = new JPanel();
		centerPanel.setLayout(new GridLayout(1, 2));

		centerPanel.add(gridPanel);
		centerPanel.add(textAreaPanel);

		add(centerPanel, BorderLayout.CENTER);

		setVisible(true);
		setSize(800, 600);

		ANNOutputArea.append("Artificial Neural Network for Digit Character Recognition.\n");
		ANNOutputArea.append("\nTrain the network or input a weight file first before running a test character. ");
		ANNOutputArea.append("Digits used are: 0, 1, 2, 3, and 4.\n");
		ANNOutputArea.append("\nThe error of a character must be under 0.3 to be known.\n");

		gridPanel.requestFocusInWindow();
		setMinimumSize(new Dimension(300, 200));
		setDefaultCloseOperation(3);
	}

	public void actionPerformed(ActionEvent e)
	{
		//perhaps call statics in CharacterRecognition to perform this logic so we don't need references.
		if (e.getSource() == trainANN)
		{
			trainANNButton();
		}

		else if (e.getSource() == openWeightFile)
		{
			openWeightFileButton();
		}

		else if (e.getSource() == tryGridCharacter)
		{
			tryGridCharacterButton();
		}

		else if (e.getSource() == resetGrid)
		{
			for (int i = 0; i < gridCells.length; i++)
			{
				gridCells[i].setBackground(Color.WHITE);
			}
			gridPanel.requestFocusInWindow();
		}

		else if (e.getSource() == createInputFile)
		{
			try
			{
				createInputFileButton();
			}
			catch (IOException x)
			{
				x.printStackTrace();
			}
		}
	}

	private synchronized void trainANNButton()
	{
		ANNOutputArea.append("\nBeginning Training Examples...");
		//appendTextArea("\nBeginning Training Examples...");
		trainANN.setEnabled(false);
		openWeightFile.setEnabled(false);

		//start a thread to run ANN.
		CharacterRecognition.networkTrainer = new CharacterRecognition.ANNTrainer(this);
		CharacterRecognition.networkTrainer.start();
		gridPanel.requestFocusInWindow();
	}

	private synchronized void openWeightFileButton()
	{
		//file dialog
		int returnVal = fc.showOpenDialog(CRUI.this);
		
		if (returnVal == JFileChooser.APPROVE_OPTION)
		{
			//file was set, grab that file path, store it for use.
			String fileName = fc.getSelectedFile() + "";
			
			//call ANN's open weight file.
			ANN = new NeuralNetwork(fileName);

			ANNOutputArea.append("\nOpened Weight File: " + fileName + "\n");
		}

		//allow other button if the opened file succeeds as weight file.
		tryGridCharacter.setEnabled(true);
		
		gridPanel.requestFocusInWindow();
	}

	private synchronized void tryGridCharacterButton()
	{
		//perform a feed forward with inputs on the possible expected outputs
		// to see if it's a recognizable character.
		trainANN.setEnabled(false);
		openWeightFile.setEnabled(false);
		tryGridCharacter.setEnabled(false);

		//setup array for the GUI inputs.
		double[] guiInputs = new double[CharacterRecognition.INPUT_NEURONS];
		for (int i = 0; i < gridCells.length; i++)
		{
			if (gridCells[i].getBackground() == Color.WHITE)
				guiInputs[i] = .01;
			else if (gridCells[i].getBackground() == Color.BLACK)
				guiInputs[i] = .99;
		}

		String outputText = "";

		//single feedforward on ANN and check errors.
		outputText = ANN.runTestSet(guiInputs);

		appendTextArea(outputText);

		trainANN.setEnabled(true);
		openWeightFile.setEnabled(true);
		tryGridCharacter.setEnabled(true);

		gridPanel.requestFocusInWindow();
	}

	private synchronized void createInputFileButton() throws IOException
	{
		PrintWriter writer = new PrintWriter("Training Examples\\newInput.txt", "UTF-8");
		int lineCounter = 0;

		for (int i = 0; i < gridCells.length; i++)
		{
			if (gridCells[i].getBackground() == Color.WHITE)
				writer.print(.01 + " ");
			else if (gridCells[i].getBackground() == Color.BLACK)
				writer.print(.99 + " ");

			lineCounter++;
			if (lineCounter >= 6)
			{
				writer.println();
				lineCounter = 0;
			}
		}
		writer.close();
		gridPanel.requestFocusInWindow();
	}

	protected synchronized void appendTextArea(String text)
	{
		ANNOutputArea.append(text);
		ANNOutputArea.setCaretPosition(ANNOutputArea.getDocument().getLength());
	}

	public void mouseClicked(MouseEvent e){
    	JLabel clickedPanel = (JLabel) e.getSource();
   
    	if (clickedPanel.getBackground() == Color.WHITE)
    	    clickedPanel.setBackground(Color.BLACK);
    	else 
    	    clickedPanel.setBackground(Color.WHITE);}

	public void mousePressed(MouseEvent e){}
    public void mouseReleased(MouseEvent e){}
    public void mouseEntered(MouseEvent e){}
    public void mouseExited(MouseEvent e){}
}