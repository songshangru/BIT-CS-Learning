package bit.minisys.minicc.parser.ast;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonTypeName;
@JsonTypeName("VariableDeclarator")
public class ASTVariableDeclarator extends ASTDeclarator{
	public ASTIdentifier identifier;
	
	public  ASTVariableDeclarator() {
		super("VariableDeclarator");
	}
	
	public  ASTVariableDeclarator(ASTIdentifier declarator) {
		super("VariableDeclarator");
		this.identifier = declarator;
	}
	@Override
	public void accept(ASTVisitor visitor) throws Exception {
		visitor.visit(this);
	}

	@JsonIgnore
	@Override
	public String getName() {
		return identifier.value;
	}

}
