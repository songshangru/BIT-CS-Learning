package bit.minisys.minicc.semantic;

import java.io.File;

import com.fasterxml.jackson.databind.ObjectMapper;

import bit.minisys.minicc.parser.ast.ASTCompilationUnit;

public class ExampleSemanticAnalyzer implements IMiniCCSemantic {

	@Override
	public String run(String iFile) throws Exception {
		ObjectMapper mapper =new ObjectMapper();
		ASTCompilationUnit program=(ASTCompilationUnit) mapper.readValue(new File(iFile), ASTCompilationUnit.class);
		System.out.println("in Semantic");
		
		/*String[] dummyStrs = new String[16];
		TreeViewer viewr = new TreeViewer(Arrays.asList(dummyStrs), program);*/

		System.out.println(program.children);
	
		
		return null;
	}

}
