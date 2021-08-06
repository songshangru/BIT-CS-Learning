package bit.minisys.minicc.parser.ast;

import com.fasterxml.jackson.annotation.JsonTypeName;

@JsonTypeName("CharConstant")
public class ASTCharConstant extends ASTExpression{
	//public  Character value;
	public  String value;
	public  Integer tokenId;
	public ASTCharConstant() {
		super("CharConstant");
	}
	public ASTCharConstant(String value,Integer tokenId) {
		super("CharConstant");
		this.value = value;
		this.tokenId = tokenId;
	}
	@Override
	public void accept(ASTVisitor visitor) throws Exception {
		visitor.visit(this);
	}
}
