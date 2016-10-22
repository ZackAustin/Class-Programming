//tadha
#include <iostream>
#include <cmath>

static int main()
{

	//Example 1.7 variance:
	double ex_1_7_mean = 3.786666;
	double powerOfTwo = 2.0;
	int ex_1_7_sampleSize = 15;
	double ex_1_7_variance = ((std::pow((2.5 - ex_1_7_mean), powerOfTwo) / (ex_1_7_sampleSize - 1))
		+ (std::pow((2.8 - ex_1_7_mean), powerOfTwo) / (ex_1_7_sampleSize - 1))
		+ (std::pow((2.8 - ex_1_7_mean), powerOfTwo) / (ex_1_7_sampleSize - 1))
		+ (std::pow((2.9 - ex_1_7_mean), powerOfTwo) / (ex_1_7_sampleSize - 1))
		+ (std::pow((3.0 - ex_1_7_mean), powerOfTwo) / (ex_1_7_sampleSize - 1))
		+ (std::pow((3.3 - ex_1_7_mean), powerOfTwo) / (ex_1_7_sampleSize - 1))
		+ (std::pow((3.4 - ex_1_7_mean), powerOfTwo) / (ex_1_7_sampleSize - 1))
		+ (std::pow((3.6 - ex_1_7_mean), powerOfTwo) / (ex_1_7_sampleSize - 1))
		+ (std::pow((3.7 - ex_1_7_mean), powerOfTwo) / (ex_1_7_sampleSize - 1))
		+ (std::pow((4.0 - ex_1_7_mean), powerOfTwo) / (ex_1_7_sampleSize - 1))
		+ (std::pow((4.4 - ex_1_7_mean), powerOfTwo) / (ex_1_7_sampleSize - 1))
		+ (std::pow((4.8 - ex_1_7_mean), powerOfTwo) / (ex_1_7_sampleSize - 1))
		+ (std::pow((4.8 - ex_1_7_mean), powerOfTwo) / (ex_1_7_sampleSize - 1))
		+ (std::pow((5.0 - ex_1_7_mean), powerOfTwo) / (ex_1_7_sampleSize - 1))
		+ (std::pow((5.6 - ex_1_7_mean), powerOfTwo) / (ex_1_7_sampleSize - 1)));

	std::cout << "Example 1.7 Variance: " << ex_1_7_variance << std::endl << std::endl;

	//Example 1.7 standard deviation:
	double ex_1_7_stanDev = sqrt(ex_1_7_variance);
	std::cout << "Example 1.7 Standard Deviation: " << ex_1_7_stanDev << std::endl << std::endl; 



	return 1;
}