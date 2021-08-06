package bit.minisys.minicc.parser.ast;

import java.util.LinkedList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonTypeName;

@JsonTypeName("FunctionCall")
public class ASTFunctionCall extends ASTExpression{

	public ASTExpression funcname;
	public List<ASTExpression> argList;
	
	public ASTFunctionCall() {
		super("FunctionCall");
	}
	public ASTFunctionCall(ASTExpression name, List<ASTExpression> args) {
		super("FunctionCall");
		this.funcname = name;
		this.argList = args;
	}
	
	public static class Builder{
		private ASTExpression name;
		private List<ASTExpression> argList=new LinkedList<ASTExpression>();
		
		public void setName(ASTExpression name) {
			this.name = name;
		}
		
		public void addArg(Object node) {
			if (argList == null) {
				argList=new LinkedList<ASTExpression>();
			}
			if(node instanceof ASTExpression) {
				argList.add((ASTExpression)node);
			}else if(node instanceof List) {
				for (Object element : (List<?>)node) {
					addArg(element);
				}
				//((List) node).stream().forEachOrdered(this::addArg);
			}else {
				throw new RuntimeException("FuncCall's argList accept Expression only.");
			}
		}
		public ASTFunctionCall build() {
			return new ASTFunctionCall(name, argList);
		}
	}
	
	@Override
	public void accept(ASTVisitor visitor) throws Exception {
		visitor.visit(this);
	}

}
