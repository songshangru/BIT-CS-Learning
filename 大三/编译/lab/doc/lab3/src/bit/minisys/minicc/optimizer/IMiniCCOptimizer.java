package bit.minisys.minicc.optimizer;

import java.io.IOException;

public interface IMiniCCOptimizer {
	/*
	 * @return String the path of the output file
	 * @param iFile input file path
	 */
	public String run(String iFile) throws Exception;
}
