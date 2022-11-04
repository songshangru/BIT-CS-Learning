package bit.minisys.minicc.parser.ast;

import com.fasterxml.jackson.annotation.JsonTypeName;

@JsonTypeName("BreakStatement")
public class ASTBreakStatement extends ASTStatement{
	
	public ASTBreakStatement() {
		super("BreakStatement");
	}

	@Override
	public void accept(ASTVisitor visitor) throws Exception {
		visitor.visit(this);
	}

}
