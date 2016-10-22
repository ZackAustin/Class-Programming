import java.io.*;
import java.util.*;

public class CharacterRecognition
{	
	//Inputs Sizes
	public static int INPUT_NEURONS = 42;
	public static int HIDDEN_NEURONS = 90;
	public static int OUTPUT_NEURONS = 5;
	public static double e = 2.718281828459045;

	public static int TE_PER_NUMBER = 8;
	public static double EXAMPLES_COUNT = OUTPUT_NEURONS * TE_PER_NUMBER;
	public static double TOTAL_ERROR = EXAMPLES_COUNT / 40;
	public static double ETA = 0.4;
	public static double MOMENTUM = 0.1;
	public static double ALLOWED_ERROR = 0.3;

	public static Thread networkTrainer;

	//GUI Frame.
	private static CRUI frame;

	//thread to run the ANN.
	static class ANNTrainer extends Thread
	{
		private CRUI gui;

		public ANNTrainer(CRUI gui)
		{
			this.gui = gui;
		}

		public void run()
		{
			gui.ANN = new NeuralNetwork();

			gui.appendTextArea("\nCharacters Trained.\n");

			//when it finishes allow other button.
			gui.trainANN.setEnabled(true);
			gui.openWeightFile.setEnabled(true);
			gui.tryGridCharacter.setEnabled(true);
		}
	}

	public static void main(String[] args)
	{
		//add a gui frame from other java file.
		frame = new CRUI("Character Recognition");
	}	
}