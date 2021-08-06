package bit.minisys.minicc.parser.ast;

public interface ASTVisitor {
	
	void visit(ASTCompilationUnit program)throws Exception;
	void visit(ASTDeclaration declaration)throws Exception;
	void visit(ASTArrayDeclarator arrayDeclarator)throws Exception;
	void visit(ASTVariableDeclarator variableDeclarator)throws Exception;
	void visit(ASTFunctionDeclarator functionDeclarator)throws Exception;
	void visit(ASTParamsDeclarator paramsDeclarator)throws Exception;
	void visit(ASTArrayAccess arrayAccess)throws Exception;
	void visit(ASTBinaryExpression binaryExpression)throws Exception;
	void visit(ASTBreakStatement breakStat)throws Exception;
	void visit(ASTContinueStatement continueStatement)throws Exception;
	void visit(ASTCastExpression castExpression)throws Exception;
	void visit(ASTCharConstant charConst)throws Exception;
	void visit(ASTCompoundStatement compoundStat)throws Exception;
	void visit(ASTConditionExpression conditionExpression)throws Exception;
	void visit(ASTExpression expression)throws Exception;
	void visit(ASTExpressionStatement expressionStat)throws Exception;
	void visit(ASTFloatConstant floatConst)throws Exception;
	void visit(ASTFunctionCall funcCall)throws Exception;
	void visit(ASTGotoStatement gotoStat)throws Exception;
	void visit(ASTIdentifier identifier)throws Exception;
	void visit(ASTInitList initList)throws Exception;
	void visit(ASTIntegerConstant intConst)throws Exception;
	void visit(ASTIterationDeclaredStatement iterationDeclaredStat)throws Exception;
	void visit(ASTIterationStatement iterationStat)throws Exception;
	void visit(ASTLabeledStatement labeledStat)throws Exception;
	void visit(ASTMemberAccess memberAccess)throws Exception;
	void visit(ASTPostfixExpression postfixExpression)throws Exception;
	void visit(ASTReturnStatement returnStat)throws Exception;
	void visit(ASTSelectionStatement selectionStat)throws Exception;
	void visit(ASTStringConstant stringConst)throws Exception;
	void visit(ASTTypename typename)throws Exception;
	void visit(ASTUnaryExpression unaryExpression)throws Exception;
	void visit(ASTUnaryTypename unaryTypename)throws Exception;
	void visit(ASTFunctionDefine functionDefine)throws Exception;
	void visit(ASTDeclarator declarator)throws Exception;
	void visit(ASTStatement statement)throws Exception;
	void visit(ASTToken token)throws Exception;
}
