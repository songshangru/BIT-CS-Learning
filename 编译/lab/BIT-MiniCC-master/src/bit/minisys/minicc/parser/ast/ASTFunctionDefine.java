package bit.minisys.minicc.parser.ast;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonTypeName;

@JsonTypeName("FunctionDefine")
public class ASTFunctionDefine extends ASTNode{

	public List<ASTToken> specifiers;
	public ASTDeclarator declarator;
	public ASTCompoundStatement body;
	public ASTFunctionDefine() {
		super("FunctionDefine");
		this.specifiers = new ArrayList<ASTToken>();
	}
	public ASTFunctionDefine(List<ASTToken> specList, ASTDeclarator declarator, ASTCompoundStatement bodyStatement) {
		super("FunctionDefine");
		this.specifiers = specList;
		this.declarator = declarator;
		this.body = bodyStatement;
	}

	
	public static class Builder{
		private LinkedList<ASTToken> specifiers = new LinkedList<ASTToken>();
		private ASTDeclarator declarator;
		private ASTCompoundStatement body;
		
		public void addSpecifiers(Object node) {
			if (specifiers == null) {
				 specifiers = new LinkedList<ASTToken>();
			}
			if(node instanceof ASTToken) {
				specifiers.add((ASTToken)node);
			}else if(node instanceof List){
				for (Object element : (List<?>)node) {
					addSpecifiers(element);
				}
				//((List) node).stream().forEachOrdered(this::addSpecifiers);
			}else {
				throw new RuntimeException("FunctionDefine's specifiers are not String");
			}
		}
		
		public void setDeclarator(ASTDeclarator declarator) {
			this.declarator = declarator;
		}
		
		public void setBody(ASTCompoundStatement body) {
			this.body = body;
		}
		public ASTFunctionDefine build() {
			return new ASTFunctionDefine(specifiers,declarator,body);
		}
	}
	@Override
	public void accept(ASTVisitor visitor) throws Exception {
		visitor.visit(this);
	}

}
