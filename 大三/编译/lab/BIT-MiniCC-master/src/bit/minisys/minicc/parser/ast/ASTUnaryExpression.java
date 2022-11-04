package bit.minisys.minicc.parser.ast;

import com.fasterxml.jackson.annotation.JsonTypeName;

// һԪ���ʽ�ڵ�
@JsonTypeName("UnaryExpression")
public class ASTUnaryExpression extends ASTExpression{
	public ASTToken op;
	public ASTExpression expr;
	
	public ASTUnaryExpression() {
		super("UnaryExpression");
	}
	public ASTUnaryExpression(ASTToken op,ASTExpression expr) {
		super("UnaryExpression");
		this.op = op;
		this.expr = expr;
	}
	@Override
	public void accept(ASTVisitor visitor) throws Exception {
		visitor.visit(this);
	}
	
}
