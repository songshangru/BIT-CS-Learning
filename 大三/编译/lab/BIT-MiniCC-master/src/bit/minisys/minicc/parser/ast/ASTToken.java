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
	public Object getPayload() {
		// TODO Auto-generated method stub
		return this.value;
	}
	
	@Override
	public void accept(ASTVisitor visitor) throws Exception {
		System.out.println();
		visitor.visit(this);
	}

}
