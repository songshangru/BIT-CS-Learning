package bit.minisys.minicc.parser.ast;

import com.fasterxml.jackson.annotation.JsonTypeName;

// ���ͳ���
@JsonTypeName("IntegerConstant")
public class ASTIntegerConstant extends ASTExpression{
	public Integer value;
	public Integer tokenId;
	
	public ASTIntegerConstant() {
		super("IntegerConstant");
	}
	public ASTIntegerConstant(Integer value,Integer tokenId) {
		super("IntegerConstant");
		this.value = value;
		this.tokenId = tokenId;
	}
	@Override
	public void accept(ASTVisitor visitor) throws Exception {
		visitor.visit(this);
	}
}
