package bit.minisys.minicc.semantic;

import java.io.File;

import com.fasterxml.jackson.databind.ObjectMapper;

import bit.minisys.minicc.parser.ast.ASTCompilationUnit;

public class MySemanticAnalyzer implements IMiniCCSemantic {
	@Override
	public String run(String iFile) throws Exception {
		ObjectMapper mapper =new ObjectMapper();
		ASTCompilationUnit program=(ASTCompilationUnit) mapper.readValue(new File(iFile), ASTCompilationUnit.class);
		
		
		ErrorHandler ehandler = new ErrorHandler();
		SymbolTable globaltable = new SymbolTable();
		SymbolTableVisitor visitor = new SymbolTableVisitor(globaltable,ehandler); 
		
		
		program.accept(visitor);
		
		/*String[] dummyStrs = new String[16];
		TreeViewer viewr = new TreeViewer(Arrays.asList(dummyStrs), program);*/

		ehandler.output();
		System.out.println("4. Semantic finished!");
		
		return null;
	}

}
