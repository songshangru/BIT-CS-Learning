package bit.minisys.minicc.parser.ast;

import com.fasterxml.jackson.annotation.JsonTypeName;

@JsonTypeName("CastExpression")
public class ASTCastExpression extends ASTExpression{
	
	public ASTTypename typename;
	public ASTExpression expr;
	
	public ASTCastExpression() {
		super("CastExpression");
	}
	public ASTCastExpression(ASTTypename typename, ASTExpression expr) {
		super("CastExpression");
		this.typename = typename;
		this.expr = expr;
	}
	@Override
	public void accept(ASTVisitor visitor) throws Exception {
		visitor.visit(this);
	}

}
