package bit.minisys.minicc.icgen;

import bit.minisys.minicc.parser.ast.ASTNode;

// 四元式形式的中间代码, 操作数和返回值的结构直接使用AST节点，也可以自定义IR节点
public class Quat {
	private String op;	
	private ASTNode res;
	private ASTNode opnd1;
	private ASTNode opnd2;
	public Quat(String op, ASTNode res, ASTNode opnd1, ASTNode opnd2) {
		this.op = op;
		this.res = res;
		this.opnd1 = opnd1;
		this.opnd2 = opnd2;
		
	}
	
	public String getOp() {
		return op;
	}
	public ASTNode getOpnd1() {
		return opnd1;
	}
	public ASTNode getOpnd2() {
		return opnd2;
	}
	public ASTNode getRes() {
		return res;
	}
}
