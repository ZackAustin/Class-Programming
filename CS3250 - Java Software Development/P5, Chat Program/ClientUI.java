import java.awt.event.*;
import java.awt.*;
import javax.swing.*;
import java.io.*;
import javax.swing.text.DefaultCaret;

public class ClientUI extends JFrame implements ActionListener
{
	private JButton disconnectButton;
	private JButton sendButton;
	private JTextArea chatTextArea;
	private JScrollPane chatTranscript;
	private JPanel messagePanel;
	private JTextField userMessages;
	private JPanel settingsPanel;
	private ChatClient client;
	private String title;

	public ClientUI(String title, ChatClient client)
	{
		super(title);
		this.client = client;
		this.title = title;

		chatTextArea = new JTextArea();
		chatTextArea.setEditable(false);
		chatTextArea.setLineWrap(true);
		chatTextArea.setWrapStyleWord(true);

		//22 -> Always vertical scrollbar, 30 -> Never horizontal
		chatTranscript = new JScrollPane(chatTextArea, 22,  30);
		add(chatTranscript, BorderLayout.CENTER);

		disconnectButton = new JButton("Disconnect");
		disconnectButton.addActionListener(this);
		settingsPanel = new JPanel();
		settingsPanel.setLayout(new FlowLayout(1, 5, 5));
		settingsPanel.add(disconnectButton);
		add(settingsPanel, BorderLayout.PAGE_START);

		sendButton = new JButton("Send");
		sendButton.addActionListener(this);

		userMessages = new JTextField();
		userMessages.addActionListener(this);

		//GridBag Panel for dynamic Send Button and Text Field.
		messagePanel = new JPanel();
		messagePanel.setLayout(new GridBagLayout());

		GridBagConstraints dynamicField = new GridBagConstraints();
		dynamicField.fill = GridBagConstraints.HORIZONTAL;
		dynamicField.weightx = 0.5;
		dynamicField.gridy = 0;
		dynamicField.insets = new Insets(3,3,3,3);

		messagePanel.add(userMessages, dynamicField);

		dynamicField.weightx = 0.0;
		dynamicField.insets = new Insets(3, 5, 3, 10);
		messagePanel.add(sendButton, dynamicField);

		add(messagePanel, BorderLayout.PAGE_END);

		setVisible(true);
		userMessages.requestFocusInWindow();

		setSize(600, 500);
		setMinimumSize(new Dimension(300, 150));
		setDefaultCloseOperation(3);

		//Clear up socket resources on exit.
		this.addWindowListener(new WindowAdapter()
		{
			public void windowClosing(WindowEvent e)
                {
                	writeClientMessages("disconnect " + title);
                }
        });
	}

	public void actionPerformed(ActionEvent e)
	{
		if (e.getSource() == sendButton)
		{
			writeClientMessages(userMessages.getText());
		}
		else if (e.getSource() == userMessages)
		{
			writeClientMessages(userMessages.getText());
		}
		else if (e.getSource() == disconnectButton)
		{
			writeClientMessages("disconnect " + title);
			//System.exit(0);
		}
	}

	private synchronized void writeClientMessages(String message)
	{
		client.sendMessage(message);
		addToTextArea(message);
	}

	public synchronized void addToTextArea(String appender)
	{
		chatTextArea.append("\n" + appender);
		chatTextArea.setCaretPosition(chatTextArea.getDocument().getLength());
		userMessages.setText("");
		userMessages.requestFocusInWindow();
	}
}