package bit.minisys.minicc.parser.ast;

import com.fasterxml.jackson.annotation.JsonTypeName;

@JsonTypeName("UnaryTypename")
public class ASTUnaryTypename extends ASTExpression{
	
	public ASTToken op;
	public ASTTypename typename;
	
	public ASTUnaryTypename() {
		super("UnaryTypename");
	}
	
	public ASTUnaryTypename(ASTToken op,ASTTypename typename) {
		super("UnaryTypename");
		this.op = op;
		this.typename = typename;
	}
	
	
	
	@Override
	public void accept(ASTVisitor visitor) throws Exception {
		visitor.visit(this);
	}

	
}
