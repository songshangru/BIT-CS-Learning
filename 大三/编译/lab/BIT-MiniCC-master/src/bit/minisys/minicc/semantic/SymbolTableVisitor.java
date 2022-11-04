package bit.minisys.minicc.semantic;
import bit.minisys.minicc.parser.ast.*;

import java.util.Map;

import org.python.modules.jffi.Function;

import java.util.IdentityHashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;

public class SymbolTableVisitor implements ASTVisitor {
	ErrorHandler ehandler;
	SymbolTable globaltable;
	SymbolTable localtable;
	SymbolTable funcs;
	int iteration_layer;
	String cur_func;
	boolean cur_func_return;
	LinkedList labellist;
	LinkedList gotolabellist;
	
	public SymbolTableVisitor(SymbolTable table,ErrorHandler error) {
		ehandler = error;
		globaltable = table;
		localtable = table;
		funcs = new SymbolTable();
		iteration_layer = 0;
		cur_func = null;
		cur_func_return = false;
		labellist = new LinkedList();
		gotolabellist = new LinkedList();
	}
	
	
	@Override
	public void visit(ASTCompilationUnit program)throws Exception{
        program.scope = this.globaltable;
        for(ASTNode node : program.items) {
        	if(node instanceof ASTDeclaration) {
        		visit((ASTDeclaration)node);
        	}else if(node instanceof ASTFunctionDefine) {
        		visit((ASTFunctionDefine)node);
        	}else {
        		this.ehandler.addES09();
        	}
        }
        for(int i=0;i<gotolabellist.size();i++) {
        	String label = (String)gotolabellist.get(i);
        	if(!labellist.contains(label)) {
        		ehandler.addES07(label);
        	}
        }
	}
	@Override
	public void visit(ASTDeclaration declaration)throws Exception{
		//System.out.println("declaration");
		if(declaration == null) return;
		declaration.scope = this.localtable;
		
		String specifier = "";
        for (ASTToken specifierToken : declaration.specifiers) {
            specifier = specifier + " " + specifierToken.value;
        }
		for(ASTInitList node : declaration.initLists) {
			this.visit(node);
			String name = node.declarator.getName();
			if(localtable.find_cur(name) == true) {
				//重复定义
				ehandler.addES02(name);
				return;
			}
			if(node.declarator instanceof ASTArrayDeclarator) {
				LinkedList limit = new LinkedList();
				ASTDeclarator declarator = ((ASTArrayDeclarator)node.declarator).declarator;
				ASTExpression expr = ((ASTArrayDeclarator)node.declarator).expr;
				while(true) {
					if(!(expr instanceof ASTIntegerConstant)) {
						//数组定义必须为整型常数
						ehandler.addES14(name);
						return;
					}
					int limit0 =  ((ASTIntegerConstant)expr).value;
					limit.addFirst(limit0);
					if(declarator instanceof ASTArrayDeclarator) {
						expr = ((ASTArrayDeclarator)declarator).expr;
						declarator = ((ASTArrayDeclarator)declarator).declarator;
					}else {
						break;
					}
				}
				if(declaration.scope == globaltable)
					globaltable.addvar(name, specifier, limit);
				else
					localtable.addvar(name, specifier, limit);
			}else {
				if(declaration.scope == globaltable)
					globaltable.addvar(name, specifier);
				else
					localtable.addvar(name, specifier);
			}
			
		}
	}
	@Override
	public void visit(ASTArrayDeclarator arrayDeclarator)throws Exception{
		if(arrayDeclarator == null) return;
		arrayDeclarator.scope = this.localtable;
		this.visit(arrayDeclarator.declarator);
		this.visit(arrayDeclarator.expr);
		
	}
	@Override
	public void visit(ASTVariableDeclarator variableDeclarator)throws Exception{
		if(variableDeclarator == null) return;
		variableDeclarator.scope = this.localtable;
	}
	@Override
	public void visit(ASTFunctionDeclarator functionDeclarator)throws Exception{
		if(functionDeclarator == null) return;
		this.visit(functionDeclarator.declarator);
		
	}
	@Override
	public void visit(ASTParamsDeclarator paramsDeclarator)throws Exception{
		
	}
	@Override
	public void visit(ASTArrayAccess arrayAccess)throws Exception{
		if(arrayAccess == null) return;
		String arrname;
		LinkedList index = new LinkedList();
		ASTExpression expr = arrayAccess.arrayName;
		ASTExpression index0 = arrayAccess.elements.get(0);
		
		while(true) {
			if(index0 instanceof ASTIntegerConstant) {
				index.addFirst(((ASTIntegerConstant)index0).value);
			}else {
				index.addFirst(-1);
			}
			
			if(expr instanceof ASTArrayAccess) {
				index0 = ((ASTArrayAccess)expr).elements.get(0);
				expr = ((ASTArrayAccess)expr).arrayName;
			}else {
				arrname = ((ASTIdentifier)expr).value;
				break;
			}
		}
		LinkedList limit = new LinkedList();
		if(!localtable.find(arrname)&&!globaltable.find(arrname)) {
			ehandler.addES01(arrname);
			return;
		}else if(localtable.find(arrname)) {
			limit = localtable.get_arr_limit(arrname);
		}else {
			limit = globaltable.get_arr_limit(arrname);
		}
		
		if(limit==null || limit.size()!=index.size()) {
			ehandler.addES06(arrname);
			return;
		}
		for(int i=0;i<limit.size();i++) {
			if((int)index.get(i) >= (int)limit.get(i)) {
				ehandler.addES06(arrname);
				return;
			}
		}
	}
	@Override
	public void visit(ASTBinaryExpression binaryExpression)throws Exception{
		//System.out.println(binaryExpression.op.value);
		if(binaryExpression == null) return;
		visit(binaryExpression.expr1);
		visit(binaryExpression.expr2);
	}
	@Override
	public void visit(ASTBreakStatement breakStat)throws Exception{
		if(breakStat == null) return;
		if(this.iteration_layer == 0) {
			ehandler.addES03();
			return;
		}
		return;
	}
	@Override
	public void visit(ASTContinueStatement continueStatement)throws Exception{
		if(continueStatement == null) return;
		if(this.iteration_layer == 0) {
			ehandler.addES03();
			return;
		}
		return;
	}
	@Override
	public void visit(ASTCastExpression castExpression)throws Exception{
		
	}
	@Override
	public void visit(ASTCharConstant charConst)throws Exception{
		
	}
	@Override
	public void visit(ASTCompoundStatement compoundStat)throws Exception{
		if(compoundStat == null) return;
		//System.out.println("compound");
		
		compoundStat.scope = localtable;
		localtable = new SymbolTable();
		localtable.father = compoundStat.scope;
		
		for(ASTNode node :compoundStat.blockItems) {
			//System.out.println(node.getClass());
			if(node instanceof ASTStatement)
				visit((ASTStatement)node);
			else if(node instanceof ASTDeclaration)
				visit((ASTDeclaration)node);
		}
		
		this.localtable = compoundStat.scope;
	}
	@Override
	public void visit(ASTConditionExpression conditionExpression)throws Exception{
		
	}
	@Override
	public void visit(ASTExpression expression)throws Exception{
		if(expression == null) return;
		if(expression instanceof ASTArrayAccess) {
			visit((ASTArrayAccess)expression);
		}else if(expression instanceof ASTMemberAccess) {
			visit((ASTMemberAccess)expression);
		}else if(expression instanceof ASTBinaryExpression) {
			visit((ASTBinaryExpression)expression);
		}else if(expression instanceof ASTFunctionCall) {
			visit((ASTFunctionCall)expression);
		}else if(expression instanceof ASTCastExpression) {
			visit((ASTCastExpression)expression);
		}else if(expression instanceof ASTConditionExpression) {
			visit((ASTConditionExpression)expression);
		}else if(expression instanceof ASTPostfixExpression) {
			visit((ASTPostfixExpression)expression);
		}else if(expression instanceof ASTUnaryExpression) {
			visit((ASTUnaryExpression)expression);
		}else if(expression instanceof ASTUnaryTypename) {
			visit((ASTUnaryTypename)expression);
		}else if(expression instanceof ASTCharConstant) {
			visit((ASTCharConstant)expression);
		}else if(expression instanceof ASTFloatConstant) {
			visit((ASTFloatConstant)expression);
		}else if(expression instanceof ASTIdentifier) {
			visit((ASTIdentifier)expression);
		}else if(expression instanceof ASTIntegerConstant) {
			visit((ASTIntegerConstant)expression);
		}else if(expression instanceof ASTStringConstant) {
			visit((ASTStringConstant)expression);
		}
	}
	@Override
	public void visit(ASTExpressionStatement expressionStat)throws Exception{
		if(expressionStat == null) return;
		for(ASTExpression expr : expressionStat.exprs) {
			visit(expr);
		}
	}
	@Override
	public void visit(ASTFloatConstant floatConst)throws Exception{
		
	}
	@Override
	public void visit(ASTFunctionCall funcCall)throws Exception{
		if(funcCall == null) return;
		if((funcCall.funcname instanceof ASTIdentifier) == false) {
			//非法函数调用
			ehandler.addES15();
			return;
		}
		String name = ((ASTIdentifier) funcCall.funcname).value;
		if(funcs.find(name)== false) {
			//函数未定义
			ehandler.addES01_1(name);
			return;
		}
		String funcname = ((ASTIdentifier)funcCall.funcname).value;
		LinkedList params = funcs.get_func_arg(name);
		//System.out.println(funcCall.argList.size());
		if(params.size()!=funcCall.argList.size()) {
			//函数参数个数不匹配
			ehandler.addES04(funcname);
			return;
		}
		for(int i=0;i<params.size();i++) {
			ASTExpression expr = funcCall.argList.get(i);
			visit(expr);
			if(expr instanceof ASTIntegerConstant) {
				if(!params.get(i).equals("int") && !params.get(i).equals("long")) {
					ehandler.addES04_1(funcname);
					return;
				}
			}else if(expr instanceof ASTFloatConstant) {
				if(!params.get(i).equals("float") && !params.get(i).equals("double")) {
					ehandler.addES04_1(funcname);
					return;
				}
			}else if(expr instanceof ASTCharConstant) {
				if(!params.get(i).equals("char")) {
					ehandler.addES04_1(funcname);
					return;
				}
			}
		}
	}
	@Override
	public void visit(ASTGotoStatement gotoStat)throws Exception{
		if(gotoStat==null) return;
		String label = gotoStat.label.value;
		gotolabellist.add(label);
	}
	@Override
	public void visit(ASTIdentifier identifier)throws Exception{
		if(identifier == null) return;
		String name = identifier.value;
		if(!this.localtable.find(name) &&
		   !this.globaltable.find(name)) {
			ehandler.addES01(name);
		}
	}
	@Override
	public void visit(ASTInitList initList)throws Exception{
		if(initList == null) return;
		visit(initList.declarator);
		for(ASTExpression expr : initList.exprs) {
			visit(expr);
		}
	
	}
	@Override
	public void visit(ASTIntegerConstant intConst)throws Exception{
		
	}
	@Override
	public void visit(ASTIterationDeclaredStatement iterationDeclaredStat)throws Exception{
		if(iterationDeclaredStat == null) return;
		iterationDeclaredStat.scope = localtable;
		localtable = new SymbolTable();
		localtable.father = iterationDeclaredStat.scope;
		
		if(iterationDeclaredStat.init !=null) {
			ASTDeclaration expr = iterationDeclaredStat.init;
			//System.out.println("init");
			this.visit(expr);
		}
		if(iterationDeclaredStat.cond !=null) {
			for(ASTExpression expr : iterationDeclaredStat.cond) {
				this.visit(expr);
			}
		}
		if(iterationDeclaredStat.step !=null) {
			for(ASTExpression expr : iterationDeclaredStat.step) {
				this.visit(expr);
			}
		}
		
		this.iteration_layer++;
		this.visit(iterationDeclaredStat.stat);
		this.iteration_layer--;
		
		
		this.localtable = iterationDeclaredStat.scope;
	}
	@Override
	public void visit(ASTIterationStatement iterationStat)throws Exception{
		if(iterationStat == null) return;
		iterationStat.scope = localtable;
		if(iterationStat.init !=null) {
			for(ASTExpression expr : iterationStat.init) {
				this.visit(expr);
			}
		}
		if(iterationStat.cond !=null) {
			for(ASTExpression expr : iterationStat.cond) {
				this.visit(expr);
			}
		}
		if(iterationStat.step !=null) {
			for(ASTExpression expr : iterationStat.step) {
				this.visit(expr);
			}
		}
		
		this.iteration_layer++;
		this.visit(iterationStat.stat);
		this.iteration_layer--;
		
		this.localtable = iterationStat.scope;
		
	}
	@Override
	public void visit(ASTLabeledStatement labeledStat)throws Exception{
		if(labeledStat == null) return;
		String label=labeledStat.label.value;
		if(labellist.contains(label)==true) {
			//重复标签
			ehandler.addES16(label);
			return;
		}else {
			labellist.add(label);
		}
		visit(labeledStat.stat);
	}
	@Override
	public void visit(ASTMemberAccess memberAccess)throws Exception{
		
	}
	@Override
	public void visit(ASTPostfixExpression postfixExpression)throws Exception{
		if(postfixExpression == null)  return;
		visit(postfixExpression.expr);
	}
	@Override
	public void visit(ASTReturnStatement returnStat)throws Exception{
		if(returnStat == null) return;
		returnStat.scope = this.localtable;
		if(returnStat.expr != null) {
			for(ASTExpression expr : returnStat.expr) {
				visit(expr);
				if(expr!=null)
					cur_func_return = true;
			}
		}
		
	}
	@Override
	public void visit(ASTSelectionStatement selectionStat)throws Exception{
		if(selectionStat == null) return;
		for(ASTExpression expr : selectionStat.cond) {
			visit(expr);
		}
		visit(selectionStat.then);
		visit(selectionStat.otherwise);
	}
	@Override
	public void visit(ASTStringConstant stringConst)throws Exception{
		
	}
	@Override
	public void visit(ASTTypename typename)throws Exception{
		
	}
	@Override
	public void visit(ASTUnaryExpression unaryExpression)throws Exception{
		if(unaryExpression == null) return;
		visit(unaryExpression.expr);
	}
	@Override
	public void visit(ASTUnaryTypename unaryTypename)throws Exception{
		
	}
	@Override
	public void visit(ASTFunctionDefine functionDefine)throws Exception{
		if(functionDefine == null) {
			return;
		}
		String funcname = functionDefine.declarator.getName();
		if(this.localtable != this.globaltable) {
			//非全局定义
			ehandler.addES17(funcname);
			return;
		}
		
		//System.out.println(funcname);
		String specifier = "";
		for (ASTToken specifierToken : functionDefine.specifiers) {
            specifier = specifier + specifierToken.value;
        }
		//System.out.println(funcname);
		
		if(funcs.find(funcname) == true) {
			//重复定义
			ehandler.addES02_1(funcname);
			return;
		}
		
		functionDefine.scope = localtable;
		this.localtable = new SymbolTable();
		cur_func = funcname;
		cur_func_return = false;
		
		LinkedList params = new LinkedList();
		for(ASTParamsDeclarator param :((ASTFunctionDeclarator)functionDefine.declarator).params) {
			String subspec = "";
			String subname = param.declarator.getName();
			for (ASTToken specifierToken : param.specfiers) {
	            subspec = subspec + specifierToken.value;
	        }
			params.add(subspec);
			this.localtable.addvar(subname, subspec);
		}
		funcs.addfunc(funcname, specifier,params);

		visit(functionDefine.declarator);
		visit(functionDefine.body);
		this.localtable = this.globaltable;
		//System.out.println(specifier);
		if( !specifier.equals("void") && cur_func_return == false) {
			ehandler.addES08(funcname);
			return;
		}
		if(specifier.equals("void") && cur_func_return == true) {
			ehandler.addES13(funcname);
			return;
		}
	}
	@Override
	public void visit(ASTDeclarator declarator)throws Exception{
		if(declarator == null) return;
		if(declarator instanceof ASTArrayDeclarator) {
			visit((ASTArrayDeclarator)declarator);
		}else if(declarator instanceof ASTVariableDeclarator) {
			visit((ASTVariableDeclarator)declarator);
		}else if(declarator instanceof ASTFunctionDeclarator) {
			visit((ASTFunctionDeclarator)declarator);
		}else {
			//
		}
	}
	@Override
	public void visit(ASTStatement statement)throws Exception{
		//System.out.println("state");
        if (statement == null) return;
        if (statement instanceof ASTIterationStatement) {
            this.visit((ASTIterationStatement) statement);
        }else if (statement instanceof ASTIterationDeclaredStatement) {
            this.visit((ASTIterationDeclaredStatement) statement);
        }else if (statement instanceof ASTBreakStatement) {
            this.visit((ASTBreakStatement) statement);
        }else if (statement instanceof ASTCompoundStatement) {
            this.visit((ASTCompoundStatement) statement);
        }else if (statement instanceof ASTExpressionStatement) {
            this.visit((ASTExpressionStatement) statement);
        }else if (statement instanceof ASTReturnStatement) {
            this.visit((ASTReturnStatement) statement);
        }else if (statement instanceof ASTGotoStatement) {
            this.visit((ASTGotoStatement)statement);
        }else if (statement instanceof ASTLabeledStatement) {
            this.visit((ASTLabeledStatement)statement);
        }
	}
	@Override
	public void visit(ASTToken token)throws Exception{
		
	}
}
