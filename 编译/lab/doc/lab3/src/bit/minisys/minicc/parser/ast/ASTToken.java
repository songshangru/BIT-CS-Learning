package bit.minisys.minicc.parser.ast;


import com.fasterxml.jackson.annotation.JsonTypeName;

@JsonTypeName("Token")
public class ASTToken extends ASTNode{
	
	public  String value;
	public  Integer tokenId;
	public ASTToken() {
		super("Token");
	}
	
	public ASTToken(String value,Integer tokenId) {
		super("Token");
		this.value = value;
		this.tokenId = tokenId;
	}
	
	@Override
	public void accept(ASTVisitor visitor) throws Exception {
		visitor.visit(this);
	}

}
