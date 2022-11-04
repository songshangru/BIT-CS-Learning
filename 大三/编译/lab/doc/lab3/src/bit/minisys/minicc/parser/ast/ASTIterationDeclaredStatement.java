package bit.minisys.minicc.parser.ast;

import java.util.LinkedList;

import com.fasterxml.jackson.annotation.JsonTypeName;
@JsonTypeName("IterationDeclaredStatement")
public class ASTIterationDeclaredStatement extends ASTStatement{

	public ASTDeclaration init;
	public LinkedList<ASTExpression> cond;
	public LinkedList<ASTExpression> step;
	
	public ASTStatement stat;
	
	public ASTIterationDeclaredStatement() {
		super("IterationDeclaredStatement");
	}
	public ASTIterationDeclaredStatement(ASTDeclaration init,LinkedList<ASTExpression> cond,LinkedList<ASTExpression> step,ASTStatement stat) {
		super("IterationDeclaredStatement");
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
