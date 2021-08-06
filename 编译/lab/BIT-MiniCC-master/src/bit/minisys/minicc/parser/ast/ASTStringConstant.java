package bit.minisys.minicc.parser.ast;

import com.fasterxml.jackson.annotation.JsonTypeName;

@JsonTypeName("StringConstant")
public class ASTStringConstant extends ASTExpression{
	public String value;
	public Integer tokenId;
	public ASTStringConstant() {
		super("StringConstant");
	}
	public ASTStringConstant(String value,Integer tokenId) {
		super("StringConstant");
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
		visitor.visit(this);
	}
}
