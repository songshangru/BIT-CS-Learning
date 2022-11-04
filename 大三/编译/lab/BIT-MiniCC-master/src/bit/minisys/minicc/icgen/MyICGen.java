package bit.minisys.minicc.icgen;

import java.io.File;

import com.fasterxml.jackson.databind.ObjectMapper;

import bit.minisys.minicc.MiniCCCfg;
import bit.minisys.minicc.internal.util.MiniCCUtil;
import bit.minisys.minicc.parser.ast.ASTCompilationUnit;

public class MyICGen implements IMiniCCICGen{

	@Override
	public String run(String iFile) throws Exception {
		// iFile is xx.ast.json
		// fetch AST Tree
		ObjectMapper mapper = new ObjectMapper();
		ASTCompilationUnit program = (ASTCompilationUnit)mapper.readValue(new File(iFile), ASTCompilationUnit.class);
	   
		/*
	     *  You should build SymbolTable here or get it from semantic analysis ..
	     *  This ic generator skips this step because it only implements addition and subtraction
	     */
		
		// use visitor pattern to build IR
		MyICBuilder icBuilder = new MyICBuilder();
		program.accept(icBuilder);

		// oFile is xx.ir.txt
		String oFile = MiniCCUtil.remove2Ext(iFile) + MiniCCCfg.MINICC_ICGEN_OUTPUT_EXT;
		MyICPrinter icPrinter = new MyICPrinter(icBuilder.getQuats(),icBuilder.getfunctable(),icBuilder.getsubscopetable());
		icPrinter.print(oFile);
		System.out.println("5. ICGen finished!");
		return oFile;
	}

}
