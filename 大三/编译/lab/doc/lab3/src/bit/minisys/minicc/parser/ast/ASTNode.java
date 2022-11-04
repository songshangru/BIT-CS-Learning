package bit.minisys.minicc.parser.ast;

import java.util.ArrayList;

import org.antlr.v4.runtime.tree.Tree;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
import com.fasterxml.jackson.annotation.JsonTypeInfo.As;

import bit.minisys.minicc.internal.symbol.SymbolTable;



@JsonTypeInfo(use = JsonTypeInfo.Id.NAME,include = As.PROPERTY,property = "type",visible = false)
@JsonSubTypes({
	@JsonSubTypes.Type(value = ASTCompilationUnit.class,name = "Program"),
	@JsonSubTypes.Type(value = ASTExpression.class,name = "Expression"),
	@JsonSubTypes.Type(value = ASTStatement.class,name = "Statement"),
	@JsonSubTypes.Type(value = ASTFunctionDefine.class,name="FunctionDefine"),
	@JsonSubTypes.Type(value = ASTDeclaration.class,name = "Declaration"),
	@JsonSubTypes.Type(value = ASTToken.class,name = "Token"),
	@JsonSubTypes.Type(value = ASTTypename.class,name = "Typename"),
	@JsonSubTypes.Type(value = ASTDeclarator.class,name = "Declarator"),
	@JsonSubTypes.Type(value = ASTParamsDeclarator.class,name = "ParamsDeclarator"),
	@JsonSubTypes.Type(value = ASTInitList.class,name = "InitList"),
	
})
public abstract class ASTNode implements Tree{
	public abstract void accept(ASTVisitor visitor) throws Exception;
	@JsonIgnore
	private String type;
	
	@JsonIgnore
	public ArrayList<ASTNode> children = new ArrayList<ASTNode>();
	
	@JsonIgnore
	public ASTNode parent;
	
	@JsonIgnore
	public String getType() {
		return type;
	}
	public ASTNode(String type) {
		this.type = type;
	}
	@JsonIgnore
	public SymbolTable scope;
	
	@JsonIgnore
	public String getNodeText() {
		return this.type;
	}
	
	@JsonIgnore
	@Override
	public Tree getChild(int index) {
		// TODO Auto-generated method stub
		if(index < this.children.size()) {
			return this.children.get(index);
		}
		return null;
	}

	@JsonIgnore
	@Override
	public int getChildCount() {
		// TODO Auto-generated method stub
		return this.children.size();
	}

	@JsonIgnore
	@Override
	public Tree getParent() {
		// TODO Auto-generated method stub
		return this.parent;
	}

	@JsonIgnore
	@Override
	public Object getPayload() {
		// TODO Auto-generated method stub
		return this.type;
	}

	@JsonIgnore
	@Override
	public String toStringTree() {
		// TODO Auto-generated method stub
		return this.type;
	}
}
