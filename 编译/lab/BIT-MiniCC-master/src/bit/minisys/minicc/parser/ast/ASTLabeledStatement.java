package bit.minisys.minicc.parser.ast;

import com.fasterxml.jackson.annotation.JsonTypeName;

@JsonTypeName("LabeledStatement")
public class ASTLabeledStatement extends ASTStatement{

	public ASTIdentifier label;
	public ASTStatement stat;
	
	public ASTLabeledStatement() {
		super("LabeledStatement");
	}
	public ASTLabeledStatement(ASTIdentifier label, ASTStatement stat) {
		super("LabeledStatement");
		this.label = label;
		this.stat = stat;
	}
	
	@Override
	public void accept(ASTVisitor visitor) throws Exception {
		visitor.visit(this);
	}

}
