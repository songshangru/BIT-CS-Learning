package bit.minisys.minicc.parser.ast;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
import com.fasterxml.jackson.annotation.JsonTypeName;
import com.fasterxml.jackson.annotation.JsonTypeInfo.As;

import bit.minisys.minicc.internal.symbol.Type;

@JsonTypeName("Expression")
@JsonTypeInfo(use = JsonTypeInfo.Id.NAME,include = As.PROPERTY,property = "type")
@JsonSubTypes({
	@JsonSubTypes.Type(value = ASTIdentifier.class,name = "Identifier"),
	@JsonSubTypes.Type(value = ASTArrayAccess.class,name = "ArrayAccess"),
	@JsonSubTypes.Type(value = ASTBinaryExpression.class,name="BinaryExpression"),
	@JsonSubTypes.Type(value = ASTCastExpression.class,name = "CastExpression"),
	@JsonSubTypes.Type(value = ASTCharConstant.class,name = "CharConstant"),
	@JsonSubTypes.Type(value = ASTConditionExpression.class,name = "ConditionExpression"),
	@JsonSubTypes.Type(value = ASTFloatConstant.class,name = "FloatConstant"),
	@JsonSubTypes.Type(value = ASTFunctionCall.class,name = "FunctionCall"),
	@JsonSubTypes.Type(value = ASTIntegerConstant.class,name = "IntegerConstant"),
	@JsonSubTypes.Type(value = ASTMemberAccess.class,name = "MemberAccess"),
	@JsonSubTypes.Type(value = ASTPostfixExpression.class,name = "PostfixExpression"),
	@JsonSubTypes.Type(value = ASTStringConstant.class,name = "StringConstant"),
	@JsonSubTypes.Type(value = ASTUnaryExpression.class,name = "UnaryExpression"),
	@JsonSubTypes.Type(value = ASTUnaryTypename.class,name = "UnaryTypename")
})
public abstract class ASTExpression extends ASTNode{

	@JsonIgnore
	public Type type;
	@JsonIgnore
	public Boolean canAssigned;

	public ASTExpression(String type){
		super(type);
	}

}
