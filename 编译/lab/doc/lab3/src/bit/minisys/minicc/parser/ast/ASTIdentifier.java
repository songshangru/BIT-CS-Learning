package bit.minisys.minicc.parser.ast;

//import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonTypeName;

//import bit.minisys.minicc.symbol.Symbol;

// ��ʶ��
@JsonTypeName("Identifier")
public class ASTIdentifier extends ASTExpression{
	public  String value;
	public  Integer tokenId;
	//@JsonIgnore
	//public Symbol info;
	public ASTIdentifier() {
		super("Identifier");
	}
	
	public ASTIdentifier(String value,Integer tokenId) {
		super("Identifier");
		this.value = value;
		this.tokenId = tokenId;
	}
	@Override
	public void accept(ASTVisitor visitor) throws Exception {
		visitor.visit(this);
	}
}
