package bit.minisys.minicc.pp;

public interface IMiniCCPreProcessor {
	/*
	 * @return String the path of the output file
	 * @param iFile input file path
	 */	
	public String run(String iFile) throws Exception;
}
