package bit.minisys.minicc.parser.ast;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonTypeName;

@JsonTypeName("ArrayDeclarator")
public class ASTArrayDeclarator extends ASTDeclarator{
	public ASTDeclarator declarator;
	public ASTExpression expr;
	
	
	public ASTArrayDeclarator() {
		super("ArrayDeclarator");
	}
	public ASTArrayDeclarator(ASTDeclarator declarator, ASTExpression expressions )
	{
		super("ArrayDeclarator");
		this.declarator = declarator;
		this.expr = expressions;
	}
	
	public static class Builder {
		private ASTDeclarator decl;
		private ASTExpression exprs;
		
		public void setDecl(ASTDeclarator decl) {
			this.decl = decl;
		}
		
		
		public void setExprs(Object exprs) {
			if(exprs instanceof List) {
				this.exprs = (ASTExpression) ((List<?>) exprs).get(0);
			}else if(exprs instanceof ASTExpression) {
				this.exprs = (ASTExpression) exprs;
			}
		}
		
		public ASTArrayDeclarator build() {
			return new ASTArrayDeclarator(decl, exprs);
		}
	}
	
	@Override
	public void accept(ASTVisitor visitor) throws Exception {
		visitor.visit(this);
	}
	@JsonIgnore
	@Override
	public String getName() {
		if(declarator != null)
			return declarator.getName();
		return null;
	}


}
