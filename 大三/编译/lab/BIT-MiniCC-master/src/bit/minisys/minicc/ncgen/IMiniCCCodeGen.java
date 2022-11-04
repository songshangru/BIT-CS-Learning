package bit.minisys.minicc.ncgen;

import bit.minisys.minicc.MiniCCCfg;

public interface IMiniCCCodeGen {
	/*
	 * @return String the path of the output file
	 * @param iFile input file path
	 * @param type architecture
	 */

	public String run(String iFile, MiniCCCfg cfg) throws Exception;
}
