package bit.minisys.minicc.parser.ast;

import java.util.LinkedList;
import java.util.List;


import com.fasterxml.jackson.annotation.JsonTypeName;
@JsonTypeName("InitList")
public class ASTInitList extends ASTNode{
	public ASTDeclarator declarator;
	public List<ASTExpression> exprs;
	
	public ASTInitList() {
		super("InitList");
	}
	
	public ASTInitList(ASTDeclarator d, List<ASTExpression> e) {
		super("InitList");
		this.declarator = d;
		this.exprs = e;
	}
	
	public static class Builder {
		private ASTDeclarator declarator;
		private List<ASTExpression> initialize = new LinkedList<ASTExpression>();
	
        public void setDeclarator(ASTDeclarator declarator) {
        	this.declarator = declarator;
        }
        
        public void addInitialize(Object node) {
        	if (initialize == null) {
        		initialize = new LinkedList<ASTExpression>();
			}
        	if(node instanceof ASTExpression) {
        		initialize.add((ASTExpression)node);
        	}else if(node instanceof List) {
        		for (Object element : (List<?>)node) {
					addInitialize(element);
				}
        		//((List) node).stream().forEachOrdered(this::addInitialize);
        	}else {
        		throw new RuntimeException("Initialize recepts Expression only.");
        	}
        }
        
        public ASTInitList build() { return new ASTInitList(declarator,initialize); }
	}
	@Override
	public void accept(ASTVisitor visitor) throws Exception {
		visitor.visit(this);
	}

}
