package bit.minisys.minicc.parser.ast;

import com.fasterxml.jackson.annotation.JsonTypeName;

@JsonTypeName("PostfixExpression")
public class ASTPostfixExpression extends ASTExpression{

	public ASTExpression expr;
	public ASTToken op;
	
	public ASTPostfixExpression() {
		super("PostfixExpression");
	}
	public ASTPostfixExpression(ASTExpression expr,ASTToken op){
		super("PostfixExpression");
		this.expr = expr;
		this.op = op;
	}
	@Override
	public void accept(ASTVisitor visitor) throws Exception {
		visitor.visit(this);
	}

}
