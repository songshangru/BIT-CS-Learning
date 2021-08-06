package bit.minisys.minicc.parser.ast;

import java.util.LinkedList;

import com.fasterxml.jackson.annotation.JsonTypeName;
@JsonTypeName("IterationStatement")
public class ASTIterationStatement extends ASTStatement{
	public LinkedList<ASTExpression> init;
	public LinkedList<ASTExpression> cond;
	public LinkedList<ASTExpression> step;
	
	public ASTStatement stat;
	public ASTIterationStatement() {
		super("IterationStatement");
	}
	public ASTIterationStatement(LinkedList<ASTExpression> init,LinkedList<ASTExpression> cond,LinkedList<ASTExpression> step,ASTStatement stat) {
		super("IterationStatement");
		this.init = init;
		this.cond = cond;
		this.step = step;
		this.stat = stat;
	}
	
	@Override
	public void accept(ASTVisitor visitor) throws Exception {
		visitor.visit(this);
	}

}
