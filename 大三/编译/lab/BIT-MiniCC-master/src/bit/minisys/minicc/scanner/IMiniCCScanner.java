package bit.minisys.minicc.scanner;

import java.io.IOException;

public interface IMiniCCScanner {
	/*
	 * @return String the path of the output file
	 * @param iFile input file path
	 */
	public String run(String iFile) throws Exception;
}
