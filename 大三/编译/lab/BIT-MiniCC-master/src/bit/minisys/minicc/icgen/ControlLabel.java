package bit.minisys.minicc.icgen;

import bit.minisys.minicc.parser.ast.ASTNode;
import bit.minisys.minicc.parser.ast.ASTVisitor;
public class ControlLabel extends ASTNode {
	
	public String name;
	public int dest;
	public ControlLabel() {
		super("ControLabel");
		this.name = "";
		this.dest = -1;
	}
	public ControlLabel(String Name) {
		super("ControLabel");
		this.name = Name;
		this.dest = -1;
	}
	public ControlLabel(String Name, int Dest) {
		super("ControLabel");
		this.name = Name;
		this.dest = Dest;
	}

	@Override
	public void accept(ASTVisitor visitor) throws Exception {
		// TODO Auto-generated method stub
		
	}
}
