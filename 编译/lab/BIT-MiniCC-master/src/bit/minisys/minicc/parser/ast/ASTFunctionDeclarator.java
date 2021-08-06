package bit.minisys.minicc.parser.ast;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonTypeName;

@JsonTypeName("FunctionDeclarator")
public class ASTFunctionDeclarator extends ASTDeclarator{
	public ASTDeclarator declarator;
	public List<ASTParamsDeclarator> params;
	
	public ASTFunctionDeclarator() {
		super("FunctionDeclarator");
		this.params = new ArrayList<ASTParamsDeclarator>();
	}
	
	public ASTFunctionDeclarator(ASTDeclarator declarator,List<ASTParamsDeclarator> paramsDeclarators) {
		super("FunctionDeclarator");
		this.declarator = declarator;
		this.params = paramsDeclarators;
	}

	public static class Builder{
		private ASTDeclarator decl;
		private List<ASTParamsDeclarator> params=new LinkedList<ASTParamsDeclarator>();

		public void setDecl(ASTDeclarator decl) {
			this.decl = decl;
		}
		public void addParams(Object node) {
			if(params == null) {
				params = new LinkedList<ASTParamsDeclarator>();
			}
			if(node instanceof ASTParamsDeclarator) {
				params.add((ASTParamsDeclarator)node);
			}else if(node instanceof List) {
				for (Object element : (List<?>)node) {
					addParams(element);
				}
			//	((List) node).stream().forEachOrdered(this::addParams);
			}else {
				throw new RuntimeException("FunctionDeclator's params accept ParamsDeclarator only.");
			}
		}
		public ASTFunctionDeclarator build() {
			return new ASTFunctionDeclarator(decl, params);
		}
	}
	@Override
	public void accept(ASTVisitor visitor) throws Exception {
		visitor.visit(this);
	}
	
	@JsonIgnore
	@Override
	public String getName() {
		if(declarator !=null)
			return declarator.getName();
		return null;
	}


}
