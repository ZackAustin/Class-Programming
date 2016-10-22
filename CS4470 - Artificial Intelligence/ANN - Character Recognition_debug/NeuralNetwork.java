import java.util.*;
import java.io.*;
import java.text.DecimalFormat;

public class NeuralNetwork
{
	//array of TEs
	private TrainingExample[] trainingExamples;
	private double[][] inputToHiddenWeights;
	private double[][] hiddenToOutputWeights;
	private double[] hiddenOutputs;
	private double[] outputOutputs;

	private double[] outputErrors;
	private double[] hiddenErrors;

	double[] teIn;
	double[] teOut;

	public static boolean trainedNet = false;
	private double totalError = 0;
	private String teDirectory;
	private long totalLoops = 0;

	DecimalFormat f = new DecimalFormat("#.000");
	DecimalFormat f2 = new DecimalFormat("#.0000");

	private Scanner fin = null;
	private int teContext = 0;

	public NeuralNetwork() //call this on Train Button.
	{
		setupNetwork();

		boolean checkContextInArray = false;
		//check for accurate arrays.
		if (checkContextInArray)
		{
			int counter = 0;
			for (int i = 0; i < teIn.length; i++)
			{
				System.out.print(teIn[i] + " ");
				counter++;
				if (counter >= 8)
				{
					System.out.println();
					counter = 0;
				}
			}

			System.out.println();

			for (int i = 0; i < teOut.length; i++)
				System.out.print(teOut[i] + " ");

			System.out.println();
		}

		randomizeWeights(inputToHiddenWeights);
		randomizeWeights(hiddenToOutputWeights);

		boolean checkWeights = false;
		//check for accurate weights.
		if (checkWeights)
		{
			int counter = 0;
			int lenCnter = 0;
			for (int i = 0; i < inputToHiddenWeights.length; i++)
			{
				for (int j = 0; j < inputToHiddenWeights[i].length; j++)
				{
					System.out.print(inputToHiddenWeights[i][j] + " ");
					counter++;
					if (counter >= 8)
					{
						System.out.println();
						counter = 0;
					}
					lenCnter++;
				}
			}

			System.out.println("\n" + lenCnter);

			System.out.println("number of hidden nodes: " + inputToHiddenWeights.length); //100
			System.out.println("number of weights in hidden node: " + inputToHiddenWeights[0].length); //72
		}

		boolean notFinished = true;
		int loopCount = 0;

		while (notFinished)
		{
			//feedforward to next layer ltr.
			feedForward(trainingExamples[teContext].teInputs, inputToHiddenWeights, hiddenOutputs);
			feedForward(hiddenOutputs, hiddenToOutputWeights, outputOutputs);

			//check for accurate hidOuts calcs.
			boolean checkHidOuts = false;
			if (checkHidOuts)
			{
				int counter = 0;
				System.out.println("Hidden Outputs: ");
				for (int i = 0; i < hiddenOutputs.length; i++)
				{
					System.out.print(f.format(hiddenOutputs[i]) + " ");
					counter++;
					if (counter >= 8)
					{
						System.out.println();
						counter = 0;
					}
				}
			}

			//backpropagate output errors.
			backPropagateOutputErrors(trainingExamples[teContext]);

			boolean checkOutErrors = false;
			//check for output errors correctness.
			if (checkOutErrors)
			{
				System.out.println("\nErrors:");
				for (int i = 0; i < outputOutputs.length; i++)
					System.out.print(outputErrors[i] + " ");
				System.out.println();
			}

			boolean checkWeights2 = false;
			//check for accurate weights.
			if (checkWeights2)
			{
				System.out.println();
				int counter = 0;
				int lenCnter = 0;
				for (int i = 0; i < 1; i++)
				{
					for (int j = 0; j < hiddenToOutputWeights[i].length; j++)
					{
						System.out.print(f.format(hiddenToOutputWeights[i][j]) + " ");
						counter++;
						if (counter >= 8)
						{
							System.out.println();
							counter = 0;
						}
						lenCnter++;
					}
				}
			}

			//weight update: outputs.
			updateWeights(hiddenOutputs, hiddenToOutputWeights, outputErrors, trainingExamples[teContext].tePrevOutErr, trainingExamples[teContext].tePrevHidOuts);

			//check for updated weights.
			if (checkWeights2)
			{
				System.out.println("\n");
				int counter = 0;
				int lenCnter = 0;
				for (int i = 0; i < 1; i++)
				{
					for (int j = 0; j < hiddenToOutputWeights[i].length; j++)
					{
						System.out.print(f.format(hiddenToOutputWeights[i][j]) + " ");
						counter++;
						if (counter >= 8)
						{
							System.out.println();
							counter = 0;
						}
						lenCnter++;
					}
				}
			}

			//backpropagate hidden layer errors.
			backPropagateHiddenErrors();

			boolean checkHidErrors = false;
			//check for output errors correctness.
			if (checkHidErrors)
			{
				System.out.println("\nErrors:");
				for (int i = 0; i < hiddenOutputs.length; i++)
					System.out.print(f.format(hiddenErrors[i]) + " ");
				System.out.println();
			}

			boolean checkWeights3 = false;
			//check for accurate weights.
			if (checkWeights3)
			{
				System.out.println();
				int counter = 0;
				int lenCnter = 0;
				for (int i = 0; i < 1; i++)
				{
					for (int j = 0; j < inputToHiddenWeights[i].length; j++)
					{
						System.out.print(f.format(inputToHiddenWeights[i][j]) + " ");
						counter++;
						if (counter >= 8)
						{
							System.out.println();
							counter = 0;
						}
						lenCnter++;
					}
				}
			}

			//weight update: hiddens.
			updateWeights(trainingExamples[teContext].teInputs, inputToHiddenWeights, hiddenErrors, trainingExamples[teContext].tePrevHidErr, trainingExamples[teContext].teInputs);

			if (checkWeights3)
			{
				System.out.println();
				int counter = 0;
				int lenCnter = 0;
				for (int i = 0; i < 1; i++)
				{
					for (int j = 0; j < inputToHiddenWeights[i].length; j++)
					{
						System.out.print(f.format(inputToHiddenWeights[i][j]) + " ");
						counter++;
						if (counter >= 8)
						{
							System.out.println();
							counter = 0;
						}
						lenCnter++;
					}
				}
			}

			//check output calculations
			boolean checkOuts = false;
			if (checkOuts)
			{
				System.out.println("\nOutputs for Context " + teContext + ":");
				for (int i = 0; i < outputOutputs.length; i++)
					System.out.print(outputOutputs[i] + " ");
				System.out.println();
			}

			for (int i = 0; i < outputOutputs.length; i++)
				totalError += Math.abs(outputOutputs[i] - trainingExamples[teContext].teOutputs[i]);

			//track previous Errors for context, to be used in momentum.
			trainingExamples[teContext].tePrevHidErr = hiddenErrors.clone();
			trainingExamples[teContext].tePrevOutErr = outputErrors.clone();
			trainingExamples[teContext].tePrevHidOuts = hiddenOutputs.clone();

			teContext++;
			totalLoops++;
			if (teContext >= CharacterRecognition.EXAMPLES_COUNT)
			{
				if (totalError < CharacterRecognition.TOTAL_ERROR)
					notFinished = false;

				//check for accurate output calculations
				boolean checkTotErrors = true;
				if (checkTotErrors)
				{
					System.out.println("Total Error: " + totalError);
				}
				teContext = 0;
				totalError = 0;
			}
		}
		NeuralNetwork.trainedNet = true;
		System.out.println("Total Loops: " + totalLoops);

		//output to a weight file.
		try
		{
			createWeightFile();
		}
		catch (IOException x)
		{
			x.printStackTrace();
		}
	}

	public NeuralNetwork(String fileName) // Call this on weights open.
	{
		setupNetwork();

		openWeightFile(fileName);

		for (int i = 0; i < inputToHiddenWeights.length; i++)
		{
			for (int j = 0; j < inputToHiddenWeights[i].length; j++)
			{
				inputToHiddenWeights[i][j] = fin.nextDouble();
			}
		}

		for (int i = 0; i < hiddenToOutputWeights.length; i++)
		{
			for (int j = 0; j < hiddenToOutputWeights[i].length; j++)
			{
				hiddenToOutputWeights[i][j] = fin.nextDouble();
			}
		}

		fin.close();
	}

	private void setupNetwork()
	{
		teDirectory = "Training Examples\\";

		trainingExamples = new TrainingExample[(int) CharacterRecognition.EXAMPLES_COUNT];

		teIn = new double[CharacterRecognition.INPUT_NEURONS];
		teOut = new double[CharacterRecognition.OUTPUT_NEURONS];
		inputToHiddenWeights = new double[CharacterRecognition.HIDDEN_NEURONS][CharacterRecognition.INPUT_NEURONS];
		hiddenToOutputWeights = new double[CharacterRecognition.OUTPUT_NEURONS][CharacterRecognition.HIDDEN_NEURONS];
		hiddenOutputs = new double[CharacterRecognition.HIDDEN_NEURONS];
		outputOutputs = new double[CharacterRecognition.OUTPUT_NEURONS];
		outputErrors = new double[CharacterRecognition.OUTPUT_NEURONS];
		hiddenErrors = new double[CharacterRecognition.HIDDEN_NEURONS];

		//read all input files.
		int teArrCnter = 0;
		for (int i = 0; i < CharacterRecognition.TE_PER_NUMBER; i++)
		{
			for (int j = 0; j < CharacterRecognition.OUTPUT_NEURONS; j++)
			{
				openFile(teDirectory + "C" + j + "TE" + i + ".txt");
				readInputFile(teIn, teOut);
				trainingExamples[teArrCnter] = new TrainingExample(teIn, teOut);
				teArrCnter++;
			}
		}

		fin.close();
	}

	private void openFile(String fn)
	{
		try
		{
			fin = new Scanner(new File(fn));
		}
		catch (FileNotFoundException x)
		{
    		System.out.println("File open failed.");
    		x.printStackTrace();
    		System.exit(0);   // TERMINATE THE PROGRAM
    	}
	}

	private void readInputFile(double[] teIn, double[] teOut)
	{
		for (int i = 0; i < teIn.length; i++)
			teIn[i] = fin.nextDouble();
		for (int i = 0; i < teOut.length; i++)
			teOut[i] = fin.nextDouble();
	}

	private void randomizeWeights(double[][] weights)
	{
		//Randomize weights.
		Random ran = new Random();

		new Object()
		{
			void compute(double[][] w)
			{
				for (int z = 0; z < w.length; z++)
				{
					for (int i = 0; i < w[z].length; i++)
					{
						double y = 0;

						while (y == 0)
							y += (double) (ran.nextInt(50) - 25) / 100;

						w[z][i] = y;
					}
				}
			}
    	}.compute(weights);
	}

	private double computeSigmoid(double output)
	{
		double net = -(output);
		return 1 / (Math.pow(CharacterRecognition.e, net) + 1);
	}

	private void feedForward(double[] pLO, double[][] ltrw, double [] o)
	{
		new Object()
		{
			void compute(double[] prevLOuts, double[][] ltrw, double[] outs)
			{
				for (int i = 0; i < ltrw.length; i++)
				{
					double tmpOutput = 0;
					for (int j = 0; j < ltrw[i].length; j++)
						tmpOutput += prevLOuts[j] * ltrw[i][j];
					//Run Sigmoid on it.
					tmpOutput = computeSigmoid(tmpOutput);
					outs[i] = tmpOutput;
				}
			}
    	}.compute(pLO, ltrw, o);
	}

	private void backPropagateOutputErrors(TrainingExample te)
	{
		double totError = 0;
		double tmpError = 0;
		for (int i = 0; i < outputOutputs.length; i++)
		{
			//(t-o)(1-o)(o)
			tmpError = (te.teOutputs[i] - outputOutputs[i]) * (1 - outputOutputs[i]) * outputOutputs[i];
			outputErrors[i] = tmpError;
		}
	}

	private void backPropagateHiddenErrors()
	{
		double tmpError = 0;
		int counterNextHiddenNeuron = 0;
		// outE x w.
		for (int i = 0; i < hiddenOutputs.length; i++)
		{
			int counterSameHiddenNeuron = 0;
			//o(1-o)(summation:(w-from-outk-to-hidh * error-of-outk))
			//so 5 of them, one for each error to the hidden weight associated with it.
			//first of each hidToOutWeights refers to same hidden.
			for (int j = 0; j < outputOutputs.length; j++)
			{
				//(summation:(w-from-outk-to-hidh * error-of-outk))
				tmpError += hiddenToOutputWeights[counterSameHiddenNeuron][counterNextHiddenNeuron] * outputErrors[j];
				counterSameHiddenNeuron++;
			}
			counterNextHiddenNeuron++;
			tmpError = tmpError * (1 - hiddenOutputs[i]) * hiddenOutputs[i];
			hiddenErrors[i] = tmpError;
		}
	}

	protected String runTestSet(double[] inputs)
	{
		//feedforward to next layer ltr.
		feedForward(inputs, inputToHiddenWeights, hiddenOutputs);
		feedForward(hiddenOutputs, hiddenToOutputWeights, outputOutputs);

		String appendText = "";

		System.out.println("\nTest Set Output:");
		appendText += "\nTest Set Output:\n";

		for (int i = 0; i < outputOutputs.length; i++)
		{
			System.out.println(outputOutputs[i]);
			appendText += outputOutputs[i] + "\n";
		}

		double lowestError = 99;
		int theChar = -1;
		double[] checking;

		//check if it's char 0.
		double tmpError = 0;
		for (int i = 0; i < CharacterRecognition.OUTPUT_NEURONS; i++)
		{
			checking = new double[CharacterRecognition.OUTPUT_NEURONS];
			checking[i] = 1;

			for (int j = 0; j < CharacterRecognition.OUTPUT_NEURONS; j++)
			{
				tmpError += Math.abs(checking[j] - outputOutputs[j]);
			}

			if (tmpError < lowestError)
			{
				lowestError = tmpError;
				theChar = i;
			}
			tmpError = 0;
		}

		System.out.println("\nLowest Found Character Error: " + lowestError);
		appendText += "\nLowest Found Character Error: " + f2.format(lowestError) + "\n";

		if (lowestError < CharacterRecognition.ALLOWED_ERROR)
		{
			System.out.println("\nCharacter is a " + theChar + ".");
			appendText += "\nCharacter is a " + theChar + ".\n";
		}
		else
		{
			System.out.println("\nUnknown Character.");
			appendText += "\nUnknown Character.\n";
		}

		return appendText;
	}

	private void updateWeights(double[] inputs, double[][] weights, double[] errors, double[] prevErrors, double[] prevInputs)
	{
		//w1(+) = w1+(δ x input) inputs are really outputs from prev layer.
		for (int i = 0; i < weights.length; i++)
		{
			for (int j = 0; j < weights[i].length; j++)
			{
				weights[i][j] = weights[i][j] + CharacterRecognition.ETA * (errors[i] * inputs[j]) + (prevErrors[i] * prevInputs[j] * CharacterRecognition.MOMENTUM);
			}
		}
	}

	private void createWeightFile() throws IOException
	{
		PrintWriter writer = new PrintWriter("weights.txt", "UTF-8");
		int lineCounter = 0;

		for (int i = 0; i < inputToHiddenWeights.length; i++)
		{
			for (int j = 0; j < inputToHiddenWeights[i].length; j++)
			{
				writer.print(inputToHiddenWeights[i][j] + " ");
				lineCounter++;

				if (lineCounter >= 4)
				{
					writer.println();
					lineCounter = 0;
				}
			}
		}

		for (int i = 0; i < hiddenToOutputWeights.length; i++)
		{
			for (int j = 0; j < hiddenToOutputWeights[i].length; j++)
			{
				writer.print(hiddenToOutputWeights[i][j] + " ");
				lineCounter++;

				if (lineCounter >= 4)
				{
					writer.println();
					lineCounter = 0;
				}
			}
		}
		writer.close();
	}

	private void openWeightFile(String fn)
	{
		try
		{
			fin = new Scanner(new File(fn));
		}
		catch (FileNotFoundException x)
		{
    		System.out.println("File open failed.");
    		x.printStackTrace();
    		System.exit(0);   // TERMINATE THE PROGRAM
    	}
	}

	class TrainingExample
	{
		double[] teInputs = new double[CharacterRecognition.INPUT_NEURONS];
		double[] teOutputs = new double[CharacterRecognition.OUTPUT_NEURONS];
		double[] tePrevHidErr = new double[CharacterRecognition.HIDDEN_NEURONS];
		double[] tePrevOutErr = new double[CharacterRecognition.OUTPUT_NEURONS];
		double[] tePrevHidOuts = new double[CharacterRecognition.HIDDEN_NEURONS];

		public TrainingExample(){}

		public TrainingExample(double[] teI, double[] teO)
		{
			teInputs = teI.clone();
			teOutputs = teO.clone();
		}
	}
}