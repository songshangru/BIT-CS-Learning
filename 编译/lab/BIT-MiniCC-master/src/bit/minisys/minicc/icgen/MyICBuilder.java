package bit.minisys.minicc.icgen;
import bit.minisys.minicc.semantic.SymbolTable;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import bit.minisys.minicc.parser.ast.*;
// 一个简单样例，只实现了加法
public class MyICBuilder implements ASTVisitor{

	private Map<ASTNode, ASTNode> map;				// 使用map存储子节点的返回值，key对应子节点，value对应返回值，value目前类别包括ASTIdentifier,ASTIntegerConstant,TemportaryValue...
	private List<Quat> quats;						// 生成的四元式列表
	private Integer tmpId;							// 临时变量编号
	
	Quat tmparrquat;
	boolean assarr = false;
	SymbolTable globaltable;
	SymbolTable localtable;
	ControlLabel localscope;
	SymbolTable funcs;
	String cur_func;
	Map<String,ASTNode> labellist;
	Map<String,SymbolTable> functable;
	Map<String,SymbolTable> subscopetable;
	private Integer subscopeId;
	private Integer ControlLabelId;	
	ControlLabel curEndlabel;
	ControlLabel curNextlabel;
	
	public MyICBuilder() {
		map = new HashMap<ASTNode, ASTNode>();
		quats = new LinkedList<Quat>();
		tmpId = 0;
		
		globaltable = new SymbolTable();
		localtable = globaltable;
		funcs = new SymbolTable();
		cur_func = null;
		ControlLabelId = 0;
		curEndlabel = null;
		curNextlabel = null;
		labellist = new HashMap<String, ASTNode>();
		functable = new HashMap<String, SymbolTable>();
		subscopetable = new HashMap<String, SymbolTable>();
		subscopeId = 0;
		localscope = new ControlLabel("global");
	}
	public List<Quat> getQuats() {
		return quats;
	}
	public Map<String,SymbolTable> getfunctable(){
		return functable;
	}
	public Map<String,SymbolTable> getsubscopetable(){
		return subscopetable;
	}

	@Override
	public void visit(ASTCompilationUnit program) throws Exception {
		for (ASTNode node : program.items) {
			if(node instanceof ASTFunctionDefine)
				visit((ASTFunctionDefine)node);
			else if(node instanceof ASTDeclaration)
				visit((ASTDeclaration)node);
		}
	}

	@Override
	public void visit(ASTDeclaration declaration) throws Exception {
		// TODO Auto-generated method stub
		declaration.scope = this.localtable;
		String specifier = declaration.specifiers.get(0).value;
		for(ASTInitList node : declaration.initLists) {
			String name = node.declarator.getName();
			//System.out.println(name);
			if(node.declarator instanceof ASTArrayDeclarator) {
				
				LinkedList limit = new LinkedList();
				ASTDeclarator declarator = ((ASTArrayDeclarator)node.declarator).declarator;
				ASTExpression expr = ((ASTArrayDeclarator)node.declarator).expr;
				while(true) {
					int limit0 =  ((ASTIntegerConstant)expr).value;
					limit.addFirst(limit0);
					if(declarator instanceof ASTArrayDeclarator) {
						expr = ((ASTArrayDeclarator)declarator).expr;
						declarator = ((ASTArrayDeclarator)declarator).declarator;
					}else {
						break;
					}
				}
				if(declaration.scope == globaltable) {
					globaltable.addvar(name, specifier, limit);
					String sl = declaration.specifiers.get(0).value;
					for(int k=0 ; k<limit.size() ; k++) {
						int limit0 = (int)limit.get(k);
						sl += "<" + limit0 + ">";
					}
					Quat quat0 = new Quat("arr",declarator,new ControlLabel(sl),localscope);
					quats.add(quat0);
				}
				else {
					localtable.addvar(name, specifier, limit);
					String sl = declaration.specifiers.get(0).value;
					for(int k=0 ; k<limit.size() ; k++) {
						int limit0 = (int)limit.get(k);
						sl += "<" + limit0 + ">";
					}
					Quat quat0 = new Quat("arr",declarator,new ControlLabel(sl),localscope);
					quats.add(quat0);
				}
					
			}else {
				if(declaration.scope == globaltable) {
					globaltable.addvar(name, specifier);
					Quat quat0 = new Quat("var",node.declarator,declaration.specifiers.get(0),localscope);
					quats.add(quat0);
				}
				else
					localtable.addvar(name, specifier);
				if(node.exprs.isEmpty() == false) {
					String op = "=";
					ASTNode res = node.declarator;
					ASTNode opnd1 = null;
					ASTNode opnd2 = null;
					ASTExpression expr = node.exprs.get(0);
					if (expr instanceof ASTIdentifier) {
						opnd1 = expr;
					}else if(expr instanceof ASTIntegerConstant) {
						opnd1 = expr;
					}else if(expr instanceof ASTFloatConstant) {
						opnd1 = expr;
					}else if(expr instanceof ASTCharConstant) {
						opnd1 = expr;
					}else if(expr instanceof ASTStringConstant) {
						opnd1 = expr;
					}else if(expr instanceof ASTBinaryExpression) {
						ASTBinaryExpression value = (ASTBinaryExpression)expr;
						op = value.op.value;
						visit(value.expr1);
						opnd1 = map.get(value.expr1);
						visit(value.expr2);
						opnd2 = map.get(value.expr2);
					}else if(expr instanceof ASTUnaryExpression) {
						visit(expr);
						opnd1 = map.get(expr);
					}else if(expr instanceof ASTPostfixExpression) {
						visit(expr);
						opnd1 = map.get(expr);
					}else if(expr instanceof ASTFunctionCall) {
						visit(expr);
						opnd1 = map.get(expr);
					}
					Quat quat = new Quat(op, res, opnd1, opnd2);
					quats.add(quat);
					map.put(node, res);
				}
			}
		}
	}

	@Override
	public void visit(ASTArrayDeclarator arrayDeclarator) throws Exception {
		// TODO Auto-generated method stub
		this.visit(arrayDeclarator.declarator);
		this.visit(arrayDeclarator.expr);
	}

	@Override
	public void visit(ASTVariableDeclarator variableDeclarator) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void visit(ASTFunctionDeclarator functionDeclarator) throws Exception {
		// TODO Auto-generated method stub
		this.visit(functionDeclarator.declarator);
	}

	@Override
	public void visit(ASTParamsDeclarator paramsDeclarator) throws Exception {
		// TODO Auto-generated method stub
		
	}
	

	@Override
	public void visit(ASTArrayAccess arrayAccess) throws Exception {
		// TODO Auto-generated method stub
		String arrname;
		LinkedList index = new LinkedList<ASTNode>();
		ASTExpression expr = arrayAccess.arrayName;
		ASTExpression index0 = arrayAccess.elements.get(0);
		while(true) {
			visit(index0);
			ASTNode res = map.get(index0);
			index.addFirst(res);
			if(expr instanceof ASTArrayAccess) {
				index0 = ((ASTArrayAccess)expr).elements.get(0);
				expr = ((ASTArrayAccess)expr).arrayName;
			}else {
				arrname = ((ASTIdentifier)expr).value;
				break;
			}
		}
		LinkedList limit = new LinkedList();
		if(localtable.find(arrname)) {
			limit = localtable.get_arr_limit(arrname);
			
		}else {
			limit = globaltable.get_arr_limit(arrname);
		}
		
		int sumc = 1, tnum = 1;
		LinkedList c = new LinkedList();
		for(int i=limit.size()-1;i>0;i--) {
			tnum = tnum * (int)limit.get(i);
			c.addFirst(tnum);
			sumc += tnum;
		}
		
		ASTNode t1 = new TemporaryValue(++tmpId);
		ASTNode t2 = new TemporaryValue(++tmpId);
		
		String name;
		String type = "int";
		if(this.globaltable == this.localtable) {
			name = ((TemporaryValue)t1).name();
			this.globaltable.addvar(name, type);
			name = ((TemporaryValue)t2).name();
			this.globaltable.addvar(name, type);
		}else {
			name = ((TemporaryValue)t1).name();
			this.localtable.addvar(name, type);
			name = ((TemporaryValue)t2).name();
			this.localtable.addvar(name, type);
		}
		
		ASTIntegerConstant d = new ASTIntegerConstant(sumc,-1);
		Quat quat0 = new Quat("=", t2,new ControlLabel("0"), null);
		quats.add(quat0);
		
		for(int i=0;i<limit.size()-1;i++) {
			ASTIntegerConstant dd= new ASTIntegerConstant((Integer)c.get(i),-1);
			Quat quat1 = new Quat("*",t1, (ASTNode)index.get(i),dd);
			quats.add(quat1);
			Quat quat2 = new Quat("+",t2, t2, t1);
			quats.add(quat2);
		}
		Quat quat2 = new Quat("+",t2, t2, (ASTNode)index.get(index.size()-1));
		quats.add(quat2);
		ASTNode t3 = new TemporaryValue(++tmpId);
		name = ((TemporaryValue)t3).name();
		if(this.globaltable == this.localtable) {
			this.globaltable.addvar(name, type);
		}else {
			this.localtable.addvar(name, type);
		}

		Quat quat3 = new Quat("=[]",t3, t2, expr);
		if(assarr == true)
			tmparrquat = quat3;
		quats.add(quat3);
		map.put(arrayAccess, t3);

	}

	@Override
	public void visit(ASTBinaryExpression binaryExpression) throws Exception {
		String op = binaryExpression.op.value;
		ASTNode res = null;
		ASTNode opnd1 = null;
		ASTNode opnd2 = null;
		
		if (op.equals("=")) {
			// 赋值操作
			// 获取被赋值的对象res
			assarr = true;
			visit(binaryExpression.expr1);
			res = map.get(binaryExpression.expr1);
			assarr = false;
			// 判断源操作数类型, 为了避免出现a = b + c; 生成两个四元式：tmp1 = b + c; a = tmp1;的情况。也可以用别的方法解决
			if (binaryExpression.expr2 instanceof ASTIdentifier) {
				opnd1 = binaryExpression.expr2;
			}else if(binaryExpression.expr2 instanceof ASTIntegerConstant) {
				opnd1 = binaryExpression.expr2;
			}else if(binaryExpression.expr2 instanceof ASTFloatConstant) {
				opnd1 = binaryExpression.expr2;
			}else if(binaryExpression.expr2 instanceof ASTCharConstant) {
				opnd1 = binaryExpression.expr2;
			}else if(binaryExpression.expr2 instanceof ASTStringConstant) {
				opnd1 = binaryExpression.expr2;
			}else if(binaryExpression.expr2 instanceof ASTBinaryExpression) {
				ASTBinaryExpression value = (ASTBinaryExpression)binaryExpression.expr2;
				op = value.op.value;
				visit(value.expr1);
				opnd1 = map.get(value.expr1);
				visit(value.expr2);
				opnd2 = map.get(value.expr2);
			}else if(binaryExpression.expr2 instanceof ASTArrayAccess) {
				visit(binaryExpression.expr2);
				opnd1 = map.get(binaryExpression.expr2);
			}else if(binaryExpression.expr2 instanceof ASTUnaryExpression) {
				visit(binaryExpression.expr2);
				opnd1 = map.get(binaryExpression.expr2);
			}else if(binaryExpression.expr2 instanceof ASTPostfixExpression) {
				visit(binaryExpression.expr2);
				opnd1 = map.get(binaryExpression.expr2);
			}else if(binaryExpression.expr2 instanceof ASTFunctionCall) {
				visit(binaryExpression.expr2);
				opnd1 = map.get(binaryExpression.expr2);
			}
		}else if (op.equals("-=")||
				  op.equals("+=")||
				  op.equals("*=")||
				  op.equals("/=")||
				  op.equals("%=")) {
			op = op.substring(0, 1);
			visit(binaryExpression.expr1);
			res = map.get(binaryExpression.expr1);
			opnd1 = res;
			visit(binaryExpression.expr2);
			opnd2 = map.get(binaryExpression.expr2);
		}else if (op.equals("+") ||
				  op.equals("-") ||
				  op.equals("*") ||
				  op.equals("/") ||
				  op.equals("%") ||
				  op.equals("<<")||
				  op.equals(">>")||
				  op.equals("<") ||
				  op.equals(">") ||
				  op.equals(">=")||
				  op.equals("<=")||
				  op.equals("==")||
				  op.equals("!=")||
				  op.equals("&&")||
				  op.equals("||")) {
			// 加法操作，结果存储到中间变量
			res = new TemporaryValue(++tmpId);
			visit(binaryExpression.expr1);
			opnd1 = map.get(binaryExpression.expr1);
			visit(binaryExpression.expr2);
			opnd2 = map.get(binaryExpression.expr2);
			
			String name = ((TemporaryValue)res).name();
			String type = null;
			if(opnd1 instanceof ASTFloatConstant||
			   opnd2 instanceof ASTFloatConstant) {
				type = "float";
			}else if(opnd1 instanceof ASTIdentifier) {
				type = "int";
			}
			if(this.globaltable == this.localtable) {
				this.globaltable.addvar(name, type);
			}else {
				this.localtable.addvar(name, type);
			}
		}else {
			// else..
		}
		
		// build quat
		Quat quat = new Quat(op, res, opnd1, opnd2);
		quats.add(quat);
		map.put(binaryExpression, res);
		if(binaryExpression.op.value.equals("=")&&binaryExpression.expr1 instanceof ASTArrayAccess) {
			op = "[]=";
			opnd1 = tmparrquat.getRes();
			opnd2 = tmparrquat.getOpnd1();
			res = tmparrquat.getOpnd2();
			quat = new Quat(op, res, opnd1, opnd2);
			quats.add(quat);
		}
	}

	@Override
	public void visit(ASTBreakStatement breakStat) throws Exception {
		// TODO Auto-generated method stub
		Quat quat_jl = new Quat("j", this.curEndlabel, null, null);
		quats.add(quat_jl);
		
	}

	@Override
	public void visit(ASTContinueStatement continueStatement) throws Exception {
		// TODO Auto-generated method stub
		Quat quat_jl = new Quat("j", this.curNextlabel, null, null);
		quats.add(quat_jl);
	}

	@Override
	public void visit(ASTCastExpression castExpression) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void visit(ASTCharConstant charConst) throws Exception {
		// TODO Auto-generated method stub
		map.put(charConst, charConst);
	}

	@Override
	public void visit(ASTCompoundStatement compoundStat) throws Exception {
		for (ASTNode node : compoundStat.blockItems) {
			if(node instanceof ASTDeclaration) {
				visit((ASTDeclaration)node);
			}else if (node instanceof ASTStatement) {
				visit((ASTStatement)node);
			}
		}
		
	}

	@Override
	public void visit(ASTConditionExpression conditionExpression) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void visit(ASTExpression expression) throws Exception {
		if(expression instanceof ASTArrayAccess) {
			visit((ASTArrayAccess)expression);
		}else if(expression instanceof ASTBinaryExpression) {
			visit((ASTBinaryExpression)expression);
		}else if(expression instanceof ASTCastExpression) {
			visit((ASTCastExpression)expression);
		}else if(expression instanceof ASTCharConstant) {
			visit((ASTCharConstant)expression);
		}else if(expression instanceof ASTConditionExpression) {
			visit((ASTConditionExpression)expression);
		}else if(expression instanceof ASTFloatConstant) {
			visit((ASTFloatConstant)expression);
		}else if(expression instanceof ASTFunctionCall) {
			visit((ASTFunctionCall)expression);
		}else if(expression instanceof ASTIdentifier) {
			visit((ASTIdentifier)expression);
		}else if(expression instanceof ASTIntegerConstant) {
			visit((ASTIntegerConstant)expression);
		}else if(expression instanceof ASTMemberAccess) {
			visit((ASTMemberAccess)expression);
		}else if(expression instanceof ASTPostfixExpression) {
			visit((ASTPostfixExpression)expression);
		}else if(expression instanceof ASTStringConstant) {
			visit((ASTStringConstant)expression);
		}else if(expression instanceof ASTUnaryExpression) {
			visit((ASTUnaryExpression)expression);
		}else if(expression instanceof ASTUnaryTypename){
			visit((ASTUnaryTypename)expression);
		}
	}

	@Override
	public void visit(ASTExpressionStatement expressionStat) throws Exception {
		for (ASTExpression node : expressionStat.exprs) {
			visit((ASTExpression)node);
		}
	}

	@Override
	public void visit(ASTFloatConstant floatConst) throws Exception {
		// TODO Auto-generated method stub
		map.put(floatConst, floatConst);
	}

	@Override
	public void visit(ASTFunctionCall funcCall) throws Exception {
		// TODO Auto-generated method stub
		String funcname = ((ASTIdentifier)funcCall.funcname).value;
		if(funcname.equals("Mars_PrintStr")||
		   funcname.equals("Mars_PrintInt")) {
			for(ASTExpression expr : funcCall.argList) {
				visit(expr);
				ASTNode arg = map.get(expr);
				Quat quat = new Quat("arg",arg,null,null);
				quats.add(quat);
			}
			Quat quat = new Quat("call",null,funcCall.funcname,null);
			quats.add(quat);
			return;
		}else if(funcname.equals("Mars_GetInt")){
			ASTNode tmp = new TemporaryValue(++tmpId);
			String name = ((TemporaryValue)tmp).name();
			String type = "int";
			if(this.globaltable == this.localtable) {
				this.globaltable.addvar(name, type);
			}else {
				this.localtable.addvar(name, type);
			}
			Quat quat = new Quat("call",tmp,funcCall.funcname,null);
			quats.add(quat);
			map.put(funcCall,tmp);
			return;
		}
		for(ASTExpression expr : funcCall.argList) {
			visit(expr);
			ASTNode arg = map.get(expr);

			Quat quat = new Quat("arg",arg,null,null);
			quats.add(quat);
		}
		if(funcs.get_func_type(funcname).equals("void")) {
			
			Quat quat = new Quat("call",null,funcCall.funcname,null);
			quats.add(quat);
			return;
		}else{
			ASTNode tmp = new TemporaryValue(++tmpId);
			String name = ((TemporaryValue)tmp).name();
			String type = funcs.get_func_type(((ASTIdentifier)funcCall.funcname).value);
			if(this.globaltable == this.localtable) {
				this.globaltable.addvar(name, type);
			}else {
				this.localtable.addvar(name, type);
			}
			Quat quat = new Quat("call",tmp,funcCall.funcname,null);
			quats.add(quat);
			
			map.put(funcCall,tmp);
		}
	}

	@Override
	public void visit(ASTGotoStatement gotoStat) throws Exception {
		// TODO Auto-generated method stub
		String labelname = gotoStat.label.value;
		ASTNode clabel = labellist.get(labelname);
		Quat quat = new Quat("j",clabel,null,null);
		quats.add(quat);
	}

	@Override
	public void visit(ASTIdentifier identifier) throws Exception {
		map.put(identifier, identifier);
	}

	@Override
	public void visit(ASTInitList initList) throws Exception {
		// TODO Auto-generated method stub
		if(initList.declarator instanceof ASTVariableDeclarator) {
			visit(initList.declarator);
			ASTExpression expr = initList.exprs.get(0);
			visit(expr);
		}else if(initList.declarator instanceof ASTArrayDeclarator) {
			
		}else if(initList.declarator instanceof ASTFunctionDeclarator) {
			
		}
	}

	@Override
	public void visit(ASTIntegerConstant intConst) throws Exception {
		map.put(intConst, intConst);
	}

	@Override
	public void visit(ASTIterationDeclaredStatement iterationDeclaredStat) throws Exception {
		// TODO Auto-generated method stub
		if(iterationDeclaredStat == null) return;
		
		iterationDeclaredStat.scope = localtable;
		this.localtable = new SymbolTable();
		localtable.father = iterationDeclaredStat.scope;
		String scopename = "SubScope@" + this.subscopeId++;
		ControlLabel tmpscope = this.localscope;
		localscope = new ControlLabel(scopename);
		Quat quatiterationbeg = new Quat("Scope_Beg",localscope,tmpscope,null);
		quats.add(quatiterationbeg);
		
		
		if(iterationDeclaredStat.init !=null) {
			visit(iterationDeclaredStat.init);
		}
		String label1 = "@IterationCheckL" + ControlLabelId++;
		ControlLabel clabel1 = new ControlLabel(label1,0);
		String label2 = "@IterationEndL" + ControlLabelId++;
		ControlLabel clabel2 = new ControlLabel(label2,0);
		String label3 = "@IterationNextL" + ControlLabelId++;
		ControlLabel clabel3 = new ControlLabel(label3,0);
		
		
		
		
		ControlLabel tmplabel2 = new ControlLabel();
		ControlLabel tmplabel3 = new ControlLabel();
		
		tmplabel2 = curEndlabel;
		tmplabel3 = curNextlabel;
		curEndlabel = clabel2;
		curNextlabel = clabel3;
		
		clabel1.dest = this.quats.size();
		Quat quat_label1 = new Quat("label", clabel1, null, null);
		quats.add(quat_label1);
		
		if(iterationDeclaredStat.cond !=null) {
			for(ASTExpression expr : iterationDeclaredStat.cond) {
				this.visit(expr);
			}
		}
		ASTNode res = map.get(iterationDeclaredStat.cond.get(0));
		Quat quat_jl2 = new Quat("jf", clabel2, res, null);
		quats.add(quat_jl2);
		
		this.visit(iterationDeclaredStat.stat);
		
		curEndlabel = tmplabel2;
		curNextlabel = tmplabel3;
		
		clabel3.dest = this.quats.size();
		Quat quat_label3 = new Quat("label", clabel3, null, null);
		quats.add(quat_label3);
		
		if(iterationDeclaredStat.step !=null) {
			for(ASTExpression expr : iterationDeclaredStat.step) {
				this.visit(expr);
			}
		}
		
		Quat quat_jl1 = new Quat("j", clabel1, null, null);
		quats.add(quat_jl1);
		
		clabel2.dest = this.quats.size();
		Quat quat_label2 = new Quat("label", clabel2, null, null);
		quats.add(quat_label2);
		
		
		SymbolTable ftable = new SymbolTable();
		ftable = this.localtable;
		subscopetable.put(scopename, ftable);
		
		Quat quatiterationend = new Quat("Scope_End",localscope,tmpscope,null);
		quats.add(quatiterationend);
		
		this.localtable = iterationDeclaredStat.scope;
		this.localscope = tmpscope;
	}

	@Override
	public void visit(ASTIterationStatement iterationStat) throws Exception {
		// TODO Auto-generated method stub
		if(iterationStat == null) return;
		//System.out.println(localtable.items.size());
		iterationStat.scope = localtable;
		this.localtable = new SymbolTable();
		localtable.father = iterationStat.scope;
		String scopename = "SubScope@" + this.subscopeId++;
		ControlLabel tmpscope = this.localscope;
		localscope = new ControlLabel(scopename);
		Quat quatiterationbeg = new Quat("Scope_Beg",localscope,tmpscope,null);
		quats.add(quatiterationbeg);
		
		if(iterationStat.init !=null) {
			for(ASTExpression expr : iterationStat.init) {
				this.visit(expr);
			}
		}
		String label1 = "@IterationCheckL" + ControlLabelId++;
		ControlLabel clabel1 = new ControlLabel(label1,0);
		String label2 = "@IterationEndL" + ControlLabelId++;
		ControlLabel clabel2 = new ControlLabel(label2,0);
		String label3 = "@IterationNextL" + ControlLabelId++;
		ControlLabel clabel3 = new ControlLabel(label3,0);
		
		ControlLabel tmplabel2 = new ControlLabel();
		ControlLabel tmplabel3 = new ControlLabel();
		
		tmplabel2 = curEndlabel;
		tmplabel3 = curNextlabel;
		
		curEndlabel = clabel2;
		curNextlabel = clabel3;
		
		clabel1.dest = this.quats.size();
		Quat quat_label1 = new Quat("label", clabel1, null, null);
		quats.add(quat_label1);
		
		if(iterationStat.cond !=null) {
			for(ASTExpression expr : iterationStat.cond) {
				this.visit(expr);
			}
		}
		ASTNode res = map.get(iterationStat.cond.get(0));
		Quat quat_jl2 = new Quat("jf", clabel2, res, null);
		quats.add(quat_jl2);
		
		this.visit(iterationStat.stat);
		
		curEndlabel = tmplabel2;
		curNextlabel = tmplabel3;
		
		clabel3.dest = this.quats.size();
		Quat quat_label3 = new Quat("label", clabel3, null, null);
		quats.add(quat_label3);
		
		if(iterationStat.step !=null) {
			for(ASTExpression expr : iterationStat.step) {
				this.visit(expr);
			}
		}
		
		Quat quat_jl1 = new Quat("j", clabel1, null, null);
		quats.add(quat_jl1);
		
		clabel2.dest = this.quats.size();
		Quat quat_label2 = new Quat("label", clabel2, null, null);
		quats.add(quat_label2);
		
		SymbolTable ftable = new SymbolTable();
		ftable = this.localtable;
		subscopetable.put(scopename, ftable);
		
		Quat quatiterationend = new Quat("Scope_End",localscope,tmpscope,null);
		quats.add(quatiterationend);
		
		this.localtable = iterationStat.scope;
		this.localscope = tmpscope;
	}

	@Override
	public void visit(ASTLabeledStatement labeledStat) throws Exception {
		// TODO Auto-generated method stub
		String labelname=labeledStat.label.value;
		
		String label = "@" + labelname;
		ControlLabel clabel = new ControlLabel(label,0);
		clabel.dest = this.quats.size();
		Quat quat_label = new Quat("label", clabel, null, null);
		quats.add(quat_label);
		labellist.put(labelname, clabel);
		
		visit(labeledStat.stat);
	}

	@Override
	public void visit(ASTMemberAccess memberAccess) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void visit(ASTPostfixExpression postfixExpression) throws Exception {
		// TODO Auto-generated method stub
		String op = postfixExpression.op.value;
		ASTNode res = null;
		
		ASTNode tmp = new TemporaryValue(++tmpId);
		
		String name = ((TemporaryValue)tmp).name();
		String type = "int";
		if(this.globaltable == this.localtable) {
			this.globaltable.addvar(name, type);
		}else {
			this.localtable.addvar(name, type);
		}
		
		Quat quat1 = new Quat("=", tmp, postfixExpression.expr, null);
		quats.add(quat1);
		Quat quat2 = new Quat(op, postfixExpression.expr, null, null);
		quats.add(quat2);
		res = tmp;
		map.put(postfixExpression, res);
		
		
	}

	@Override
	public void visit(ASTReturnStatement returnStat) throws Exception {
		// TODO Auto-generated method stub
		if (returnStat.expr == null || returnStat.expr.isEmpty()) {
            Quat quat = new Quat("ret", null, null, null);
            quats.add(quat);
            return;
        }
		for(ASTExpression expr : returnStat.expr) {
			visit(expr);
		}
		ASTNode res = map.get(returnStat.expr.get(0));
		Quat quat = new Quat("ret", res, null, null);
        quats.add(quat);
	}

	@Override
	public void visit(ASTSelectionStatement selectionStat) throws Exception {
		// TODO Auto-generated method stub
		for(ASTExpression expr : selectionStat.cond) {
			visit(expr);
		}
		
		String label1 = "@IfFalseL" + ControlLabelId++;
		ControlLabel clabel1 = new ControlLabel(label1,0);
		String label2 = "@IfEndL" + ControlLabelId++;
		ControlLabel clabel2 = new ControlLabel(label2,0);
		
		ASTNode res = map.get(selectionStat.cond.get(0));
		Quat quat1 = new Quat("jf", clabel1, res, null);
		quats.add(quat1);
		
		//生成局部符号表
		selectionStat.scope = localtable;
		this.localtable = new SymbolTable();
		localtable.father = selectionStat.scope;
		String scopename = "SubScope@" + this.subscopeId++;
		ControlLabel tmpscope = this.localscope;
		localscope = new ControlLabel(scopename);
		Quat quatifbeg = new Quat("Scope_Beg",localscope,tmpscope,null);
		quats.add(quatifbeg);
		
		visit(selectionStat.then);
		
		Quat quat2 = new Quat("j", clabel2, null, null);
		quats.add(quat2);
		
		//结束局部符号表
		SymbolTable ftable = new SymbolTable();
		ftable = this.localtable;
		subscopetable.put(scopename, ftable);
		Quat quatifend = new Quat("Scope_End",localscope,tmpscope,null);
		quats.add(quatifend);
		this.localtable = selectionStat.scope;
		this.localscope = tmpscope;
		
		clabel1.dest = this.quats.size();
		Quat quat3 = new Quat("label", clabel1, null, null);
		quats.add(quat3);
		
		if(selectionStat.otherwise != null) {
			if(selectionStat.otherwise instanceof ASTSelectionStatement) {
				visit(selectionStat.otherwise);
			}else {
				//生成局部符号表
				selectionStat.scope = localtable;
				this.localtable = new SymbolTable();
				String elsescopename = "SubScope@" + this.subscopeId++;
				ControlLabel elsetmpscope = this.localscope;
				localscope = new ControlLabel(elsescopename);
				Quat quatelsebeg = new Quat("Scope_Beg",localscope,elsetmpscope,null);
				quats.add(quatelsebeg);
				
				visit(selectionStat.otherwise);
				
				//结束局部符号表
				SymbolTable elseftable = new SymbolTable();
				elseftable = this.localtable;
				subscopetable.put(elsescopename, elseftable);
				Quat quatelseend = new Quat("Scope_End",localscope,elsetmpscope,null);
				quats.add(quatelseend);
				this.localtable = selectionStat.scope;
				this.localscope = elsetmpscope;
			}
		}
		clabel2.dest = this.quats.size();
		Quat quat4 = new Quat("label", clabel2,null ,null);
		quats.add(quat4);
		
	}

	@Override
	public void visit(ASTStringConstant stringConst) throws Exception {
		// TODO Auto-generated method stub
		map.put(stringConst, stringConst);
	}

	@Override
	public void visit(ASTTypename typename) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void visit(ASTUnaryExpression unaryExpression) throws Exception {
		// TODO Auto-generated method stub
		String op = unaryExpression.op.value;
		ASTNode res = null;
		if(op.equals("++") ||
		   op.equals("--")) {
			visit(unaryExpression.expr);
			res = map.get(unaryExpression.expr);
			if(unaryExpression.expr instanceof ASTIdentifier) {
				Quat quat = new Quat(op, res, null, null);
				quats.add(quat);
				map.put(unaryExpression, res);
			}
		}else {
			res = new TemporaryValue(++tmpId);
			String name = ((TemporaryValue)res).name();
			String type = "int";
			if(this.globaltable == this.localtable) {
				this.globaltable.addvar(name, type);
			}else {
				this.localtable.addvar(name, type);
			}
			visit(unaryExpression.expr);
			ASTNode expr = map.get(unaryExpression.expr);
			Quat quat = new Quat(op, res, expr,null);
			quats.add(quat);
			map.put(unaryExpression, res);
		}
		
		
	}

	@Override
	public void visit(ASTUnaryTypename unaryTypename) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void visit(ASTFunctionDefine functionDefine) throws Exception {
		String funcname = functionDefine.declarator.getName();
		String specifier = "";
		for (ASTToken specifierToken : functionDefine.specifiers) {
            specifier = specifier + specifierToken.value;
        }

		functionDefine.scope = localtable;
		this.localtable = new SymbolTable();
		cur_func = funcname;
		ControlLabel tmpscope = this.localscope;
		localscope = new ControlLabel(funcname);
		
		Quat quatfuncbeg = new Quat("Func_Beg",functionDefine.declarator,functionDefine.specifiers.get(0),null);
		quats.add(quatfuncbeg);
		
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
		funcs.addfunc(funcname, specifier, params);

		visit(functionDefine.declarator);
		visit(functionDefine.body);
		
		SymbolTable ftable = new SymbolTable();
		ftable = this.localtable;
		functable.put(funcname, ftable);
		
		this.localtable = this.globaltable;
		this.localscope = tmpscope;
		
		Quat quatfuncend = new Quat("Func_End",functionDefine.declarator,null,null);
		quats.add(quatfuncend);
		
	}

	@Override
	public void visit(ASTDeclarator declarator) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void visit(ASTStatement statement) throws Exception {
		if(statement instanceof ASTIterationDeclaredStatement) {
			visit((ASTIterationDeclaredStatement)statement);
		}else if(statement instanceof ASTIterationStatement) {
			visit((ASTIterationStatement)statement);
		}else if(statement instanceof ASTCompoundStatement) {
			visit((ASTCompoundStatement)statement);
		}else if(statement instanceof ASTSelectionStatement) {
			visit((ASTSelectionStatement)statement);
		}else if(statement instanceof ASTExpressionStatement) {
			visit((ASTExpressionStatement)statement);
		}else if(statement instanceof ASTBreakStatement) {
			visit((ASTBreakStatement)statement);
		}else if(statement instanceof ASTContinueStatement) {
			visit((ASTContinueStatement)statement);
		}else if(statement instanceof ASTReturnStatement) {
			visit((ASTReturnStatement)statement);
		}else if(statement instanceof ASTGotoStatement) {
			visit((ASTGotoStatement)statement);
		}else if(statement instanceof ASTLabeledStatement) {
			visit((ASTLabeledStatement)statement);
		}
	}

	@Override
	public void visit(ASTToken token) throws Exception {
		// TODO Auto-generated method stub
		
	}

}
