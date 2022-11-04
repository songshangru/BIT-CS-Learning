package bit.minisys.minicc.parser.ast;

import java.util.LinkedList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonTypeName;

@JsonTypeName("ArrayAccess")
public class ASTArrayAccess extends ASTExpression{
	public  ASTExpression arrayName;
	public  List<ASTExpression> elements;
	
	public ASTArrayAccess() {
		super("ArrayAccess");
	}
	public ASTArrayAccess(ASTExpression arrayname, List<ASTExpression> element) {
		super("ArrayAccess");
		this.arrayName = arrayname;
		this.elements = element;
	}
	
	public static class Builder{
		private ASTExpression arrayName;
		private List<ASTExpression> elements = new LinkedList<ASTExpression>();
			
		public void setArrayName(ASTExpression arrayName) {
			this.arrayName = arrayName;
		}
		
		public void addElement(Object object) {
			if(elements == null) {
				elements = new LinkedList<ASTExpression>();
			}
			if(object instanceof ASTExpression) {
				elements.add((ASTExpression)object);
			}else if(object instanceof List) {
				for (Object element : (List<?>)object) {
					addElement(element);
				}
			}else {
				throw new RuntimeException("ArrayAccess's elements accept expression only.");
			}
		}
		public ASTArrayAccess build() {
			return new ASTArrayAccess(arrayName,elements);
		}
	}
	@Override
	public void accept(ASTVisitor visitor) throws Exception {
		visitor.visit(this);
	}

}
