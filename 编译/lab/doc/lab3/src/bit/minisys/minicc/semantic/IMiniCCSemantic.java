package bit.minisys.minicc.semantic;

import java.io.IOException;

public interface IMiniCCSemantic {
	/*
	 * @return String the path of the output file
	 * @param iFile input file path
	 */
	public String run(String iFile) throws Exception;
}
