package bit.minisys.minicc.parser.ast;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonTypeName;

@JsonTypeName("ParamsDeclarator")
public class ASTParamsDeclarator extends ASTNode{

	public List<ASTToken> specfiers;
	public ASTDeclarator declarator;
	
	public ASTParamsDeclarator() {
		super("ParamsDeclarator");
		this.specfiers = new ArrayList<ASTToken>();
	}
	public ASTParamsDeclarator(List<ASTToken> specList, ASTDeclarator declarator) {
		super("ParamsDeclarator");
		this.specfiers = specList;
		this.declarator = declarator;
	}
	
	public static class Builder{
		private List<ASTToken> specfiers=new LinkedList<ASTToken>();
		private ASTDeclarator declarator;
		
        public void addSpecfiers(Object node) {
        	if(specfiers == null) {
        		specfiers = new LinkedList<ASTToken>();
        	}
            if      (node instanceof ASTToken) specfiers.add((ASTToken) node);
            else if (node instanceof List) {
            	for (Object element : (List<?>)node) {
					addSpecfiers(element);
				}
            	//((List) node).stream().forEachOrdered(this::addSpecfiers);
            }
            else throw new RuntimeException("ParamsDeclarator specfiers accepts String only.");
        }
		
		public void setDeclarator(ASTDeclarator declarator) {
			this.declarator = declarator;
		}
		
		public ASTParamsDeclarator build() {
			return new ASTParamsDeclarator(specfiers,declarator);
		}
	}
	
	@Override
	public void accept(ASTVisitor visitor) throws Exception {
		visitor.visit(this);
	}

}
