package bit.minisys.minicc.icgen;

import java.io.File;

import com.fasterxml.jackson.databind.ObjectMapper;

import bit.minisys.minicc.MiniCCCfg;
import bit.minisys.minicc.internal.util.MiniCCUtil;
import bit.minisys.minicc.parser.ast.ASTCompilationUnit;

public class ExampleICGen implements IMiniCCICGen{

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
		ExampleICBuilder icBuilder = new ExampleICBuilder();
		program.accept(icBuilder);

		// oFile is xx.ir.txt
		String oFile = MiniCCUtil.remove2Ext(iFile) + MiniCCCfg.MINICC_ICGEN_OUTPUT_EXT;
		ExampleICPrinter icPrinter = new ExampleICPrinter(icBuilder.getQuats());
		icPrinter.print(oFile);
		System.out.println("5. ICGen finished!");
		return oFile;
	}

}
