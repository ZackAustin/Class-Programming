import java.io.*;
import java.net.*;
import java.util.*;

public class ChatClient
{
	private Thread serverReply;
	private Socket clientSocket;
	private OutputStream outStream;
	private PrintWriter out;

	private InputStream inStream;
	private Scanner in;

	private static ClientUI frame;

	private String userName;

	public ChatClient(String userName, int portNumber) throws IOException
	{
		this.userName = userName;
		serverReply = new SocketReader("Server Message Receiver");

		clientSocket = new Socket("localhost", portNumber);

      	outStream = clientSocket.getOutputStream();
      	out = new PrintWriter(outStream, true);

      	inStream = clientSocket.getInputStream();
      	in = new Scanner(inStream);

      	sendMessage("connect " + userName);
	}

	public void sendMessage(String message)
	{
		out.println(message);
	}

	class SocketReader extends Thread
	{
		public SocketReader(String name)
		{
			super(name);
		}

		public void run()
		{
			String reply = "";
			//Thread is used only for reading socket replys from server so blocks
			//don't affect the GUI. Passed to a synchronized method to access it.

			while (!(reply.equals("disconnected")))
			{
				reply = in.nextLine();
				//System.out.println(reply);
				frame.addToTextArea(reply);
			}
		}
	}


	public static void main(String[] args) throws IOException
	{
		String userName = "Anonymous";
		int portNumber = 4688;

		if (args.length >= 1)
		{
			userName = args[0];
			if (args.length >= 2)
				portNumber = Integer.parseInt(args[1]);
		}

		ChatClient setupChat = new ChatClient(userName, portNumber);
		frame = new ClientUI(userName, setupChat);
		setupChat.serverReply.start();
	}
}