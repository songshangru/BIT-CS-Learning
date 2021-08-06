package bit.minisys.minicc.parser;

import java.io.IOException;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

public interface IMiniCCParser {
	/*
	 * @return String the path of the output file
	 * @param iFile input file path
	 */
	public String run(String iFile) throws Exception;
}
