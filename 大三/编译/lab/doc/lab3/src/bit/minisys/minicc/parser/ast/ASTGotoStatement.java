package bit.minisys.minicc.parser.ast;

import com.fasterxml.jackson.annotation.JsonTypeName;

@JsonTypeName("GotoStatement")
public class ASTGotoStatement extends ASTStatement{
	public ASTIdentifier label;
	
	public ASTGotoStatement() {
		super("GotoStatement");
	}
	
	public ASTGotoStatement(ASTIdentifier label) {
		super("GotoStatement");
		this.label = label;
	}
	@Override
	public void accept(ASTVisitor visitor) throws Exception {
		visitor.visit(this);
	}

}
