package TestSuite;
import java.io.*;

public abstract class Test
{
   int nPass = 0;
   int nFail = 0;
   BufferedWriter sink;

   public Test(BufferedWriter sink)
   {
      this.sink = sink;
   }
   public Test()
   {
      sink = new BufferedWriter(new OutputStreamWriter(System.out));
   }
   public final void setSink(BufferedWriter sink)
   {
      this.sink = sink;
   }
   public final Writer getSink()
   {
      return sink;
   }
   public final void test(String label, boolean condition) throws IOException
   {
      if (!condition)
         fail(label);
      else
         succeed();
   }
   public final void test(boolean condition) throws IOException
   {
      if (!condition)
         fail();
      else
         succeed();
   }

   public final void fail(String label) throws IOException
   {
      if (sink != null)
      {
         sink.write(getClass().getName() + " failure: " + label);
         sink.newLine();
      }
      ++nFail;
   }
   public final void fail() throws IOException
   {
      // The failure is 2 levels back from here in the call chain
      // (which will be 3 by the time we call fail again)
      fail(3);
   }
   public final void fail(int level) throws IOException
   {
      if (sink != null)
         try
         {
            throw new RuntimeException();
         }
         catch (RuntimeException x)
         {
            // Extract file/line number where test was called
            StringBuffer message = new StringBuffer(x.getStackTrace()[level].toString());
            message.delete(0, message.indexOf("(")+1);
            message.deleteCharAt(message.length()-1);
            sink.write("failure in line " + message);
            sink.newLine();
         }
      ++nFail;
   }

   public final void succeed()
   {
      ++nPass;
   }
   public final void flush() throws IOException
   {
      if (sink != null)
      {
         sink.flush();
      }
   }
   public final int report() throws IOException
   {
      assert sink != null;
      if (sink != null)
      {
         sink.write("Test \"" + getClass().getName() + "\":");
         sink.newLine();
         sink.write("\tPassed: " + nPass);
         sink.newLine();
         sink.write("\tFailed: " + nFail);
         sink.newLine();
      }
      return nFail;
   }
   public final int getNumPassed()
   {
      return nPass;
   }
   public final int getNumFailed()
   {
      return nFail;
   }
   public final void close() throws IOException
   {
      sink.close();
   }
   protected void reset()
   {
      nFail = nPass = 0;
   }

   public abstract void run() throws IOException;
}

