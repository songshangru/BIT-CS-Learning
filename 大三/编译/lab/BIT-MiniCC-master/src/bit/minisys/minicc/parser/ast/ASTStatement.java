package bit.minisys.minicc.parser.ast;

import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
import com.fasterxml.jackson.annotation.JsonTypeName;
import com.fasterxml.jackson.annotation.JsonTypeInfo.As;

@JsonTypeName("Statement")
@JsonTypeInfo(use = JsonTypeInfo.Id.NAME,include = As.PROPERTY,property = "type")
@JsonSubTypes({
	@JsonSubTypes.Type(value = ASTBreakStatement.class,name = "BreakStatement"),
	@JsonSubTypes.Type(value = ASTCompoundStatement.class,name = "CompoundStatement"),
	@JsonSubTypes.Type(value = ASTContinueStatement.class,name="ContinueStatement"),
	@JsonSubTypes.Type(value = ASTExpressionStatement.class,name = "ExpressionStatement"),
	@JsonSubTypes.Type(value = ASTGotoStatement.class,name = "GotoStatement"),
	@JsonSubTypes.Type(value = ASTIterationDeclaredStatement.class,name = "IterationDeclaredStatement"),
	@JsonSubTypes.Type(value = ASTIterationStatement.class,name = "IterationStatement"),
	@JsonSubTypes.Type(value = ASTLabeledStatement.class,name = "LabeledStatement"),
	@JsonSubTypes.Type(value = ASTReturnStatement.class,name = "ReturnStatement"),
	@JsonSubTypes.Type(value = ASTSelectionStatement.class,name = "SelectionStatement")
})
public abstract class ASTStatement extends ASTNode{

	public ASTStatement(String type) {
		super(type);
	}

	@Override
	public void accept(ASTVisitor visitor) throws Exception {
		// TODO Auto-generated method stub
		
	}
}
