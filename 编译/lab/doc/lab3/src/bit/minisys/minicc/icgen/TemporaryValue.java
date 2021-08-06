package bit.minisys.minicc.icgen;

import bit.minisys.minicc.parser.ast.ASTNode;
import bit.minisys.minicc.parser.ast.ASTVisitor;

// ¡Ÿ ±±‰¡ø
public class TemporaryValue extends ASTNode{

	private Integer id;

	public String name() {
		return "%"+id;
	}
	@Override
	public void accept(ASTVisitor visitor) throws Exception {

	}
	public TemporaryValue(Integer id) {
		super("TemporaryValue");
		this.id = id;
	}
	public TemporaryValue(String type) {
		super(type);
	}
}
