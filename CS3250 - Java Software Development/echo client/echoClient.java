import java.io.*;
import java.net.*;
import java.util.*;

/**
 * This program implements a simple client that listens to port 8189 and echoes back all server
 * input.
 * @version 1.21 2012-05-19
 * @author Cay Horstmann
 */
public class echoClient
{
   public static void main(String[] args) throws IOException
   {
      Socket client = new Socket("localhost", 8189);

      OutputStream outStream = client.getOutputStream();
      PrintWriter out = new PrintWriter(outStream, true);

      InputStream inStream = client.getInputStream();
      Scanner in = new Scanner(inStream);

      Scanner userInput = new Scanner(System.in);

      String finished = "Hello";

     // while (!(finished.equals("BYE")))
     // {
     //    System.out.println("here??1");
     //    out.println(finished);
     //    finished = in.nextLine();
     //    System.out.println(finished);
     // }

      System.out.println(in.nextLine());

      String reply = "";

      while (!(reply.equals("BYE")))
      {
         reply = userInput.nextLine();
         out.println(reply);

         System.out.println(in.nextLine());
      }

      reply = userInput.nextLine();

      out.println("here??2");
   }
}