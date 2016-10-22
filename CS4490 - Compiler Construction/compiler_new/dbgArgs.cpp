 #include "dbgArgs.h"

compilerArgs::compilerArgs(std::string name, std::string type, int step, std::string out) : kxiFileName(name), debugType(type), debugStep(step), outFile(out)
{
	if (outFile != "")
		ofs = new std::ofstream(outFile, std::ofstream::out | std::ofstream::trunc);
	else ofs = nullptr;

	if ((debugStep <= -999 && ((debugType == "dlex") || debugType == "dpar" || debugType == "dsem" || debugType == "dall")) || debugStep > 0)
		showLineNumbers = true;
	else showLineNumbers = false;

	if ((debugStep <= -999 && ((debugType == "dlex") || debugType == "dall")) || debugStep-- > 0)
		debuggingLexer = true;
	else debuggingLexer = false;

	if ((debugStep <= -999 && ((debugType == "dpar") || debugType == "dall")) || debugStep > 0)
		debuggingParser = true;
	else debuggingParser = false;

	if ((debugStep <= -999 && ((debugType == "dsyn") || debugType == "dall")) || debugStep-- > 0)
		debuggingSyntax = true;
	else debuggingSyntax = false;

	if ((debugStep <= -999 && ((debugType == "dsem") || debugType == "dall")) || debugStep-- > 0)
		debuggingSemantics = true;
	else debuggingSemantics = false;

	if ((debugStep <= -999 && ((debugType == "dint") || debugType == "dall")) || debugStep-- > 0)
		debuggingICode = true;
	else debuggingICode = false;

	if (debuggingLexer || debuggingParser || debuggingSyntax || debuggingSemantics || debuggingICode)
		debugging = true;
	else debugging = false;
}