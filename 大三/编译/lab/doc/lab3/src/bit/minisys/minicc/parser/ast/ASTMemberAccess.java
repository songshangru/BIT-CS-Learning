package bit.minisys.minicc.parser.ast;

import com.fasterxml.jackson.annotation.JsonTypeName;

@JsonTypeName("MemberAccess")
public class ASTMemberAccess extends ASTExpression{

	public ASTToken op;
	public ASTExpression master;
	public ASTIdentifier member;
	public ASTMemberAccess() {
		super("MemberAccess");
	}
	public ASTMemberAccess(ASTExpression master, ASTToken op, ASTIdentifier member) {
		super("MemberAccess");
		this.master = master;
		this.op = op;
		this.member = member;
	}
	
	@Override
	public void accept(ASTVisitor visitor) throws Exception {
		visitor.visit(this);
	}

}
