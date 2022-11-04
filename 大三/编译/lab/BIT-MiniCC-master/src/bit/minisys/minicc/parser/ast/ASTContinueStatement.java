package bit.minisys.minicc.parser.ast;

import com.fasterxml.jackson.annotation.JsonTypeName;

@JsonTypeName("ContinueStatement")
public class ASTContinueStatement extends ASTStatement{
	public ASTContinueStatement() {
		super("ContinueStatement");
	}

	@Override
	public void accept(ASTVisitor visitor) throws Exception {
		visitor.visit(this);
	}

}
