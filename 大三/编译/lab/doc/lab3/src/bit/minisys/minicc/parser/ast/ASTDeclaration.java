package bit.minisys.minicc.parser.ast;

import java.util.LinkedList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonTypeName;

@JsonTypeName("Declaration")
public class ASTDeclaration extends ASTNode{
	
	public  List<ASTToken> specifiers;
	public  List<ASTInitList> initLists;

	public ASTDeclaration() {
		super("Declaration");
	}
	
	public ASTDeclaration(List<ASTToken> specList, List<ASTInitList> initList) {
		super("Declaration");
		this.specifiers = specList;
		this.initLists = initList;
	}
	

	public static class Builder {
			private  LinkedList<ASTToken> specfiers=new LinkedList<ASTToken>();
			private  LinkedList<ASTInitList> initLists = new LinkedList<ASTInitList>();
		
	        public void addSpecfiers(Object node) {
	        	if(specfiers == null) {
	        		specfiers=new LinkedList<ASTToken>();
	        	}
	            if      (node instanceof ASTToken) specfiers.add((ASTToken) node);
	            else if (node instanceof List) {
	            	for (Object element : (List<?>)node) {
						addSpecfiers(element);
					}
	            	//((List) node).stream().forEachOrdered(this::addSpecfiers);
	            }
	            else throw new RuntimeException("Declaration's specfiers accepts String only.");
	        }
	        
	        public void addInitList(Object node) {
	        	if (initLists == null) {
					initLists = new LinkedList<ASTInitList>();
				}
	            if      (node instanceof ASTInitList) initLists.add((ASTInitList) node);
	            else if (node instanceof List) {
	            	for (Object element : (List<?>)node) {
						addInitList(element);
					}
	            	//((List) node).stream().forEachOrdered(this::addInitList);
	            }
	            else throw new RuntimeException("Declaration's Initlist accepts InitList only.");
	        }
	        
	        public ASTDeclaration build() { return new ASTDeclaration(specfiers,initLists); }
	}
	@Override
	public void accept(ASTVisitor visitor) throws Exception {
		visitor.visit(this);
	}

}
