package bit.minisys.minicc.parser;

import bit.minisys.minicc.MiniCCCfg;
import bit.minisys.minicc.internal.util.MiniCCUtil;
import bit.minisys.minicc.parser.ast.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.antlr.v4.gui.TreeViewer;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

class ScannerToken{
	public String lexme;
	public String type;
	public int	  line;
	public int    column;
}

public class MyParser implements IMiniCCParser {

	private ArrayList<ScannerToken> tknList;
	private int tokenIndex;
	private ScannerToken nextToken;
	
	@Override
	public String run(String iFile) throws Exception {

		String oFile = MiniCCUtil.removeAllExt(iFile) + MiniCCCfg.MINICC_PARSER_OUTPUT_EXT;
		String tFile = MiniCCUtil.removeAllExt(iFile) + MiniCCCfg.MINICC_SCANNER_OUTPUT_EXT;
		
		tknList = loadTokens(tFile);
		tokenIndex = 0;

		ASTNode root = program();
		
		
		String[] dummyStrs = new String[16];
		TreeViewer viewr = new TreeViewer(Arrays.asList(dummyStrs), root);
	    viewr.open();

		ObjectMapper mapper = new ObjectMapper();
		mapper.writeValue(new File(oFile), root);
		System.out.println("3. Parser finished!");
		return oFile;
	}
	
	private boolean IsSpecifier(String s) {
		return s.equals("'int'")||
			   s.equals("'void'")||
			   s.equals("'char'")||
			   s.equals("'short'")||
			   s.equals("'long'")||
			   s.equals("'float'")||
			   s.equals("'double'")||
			   s.equals("'signed'")||
			   s.equals("'unsigned'");
	}
	
	private boolean IsOperatorAssign(String s) {
		//= | *= | /= | %= | += | -= | <<= | >>= | &= | ^= | |=
		return s.equals("'='")||
			   s.equals("'*='")||
			   s.equals("'/='")||
			   s.equals("'%='")||
			   s.equals("'+='")||
			   s.equals("'-='")||
			   s.equals("'<<='")||
			   s.equals("'>>='")||
			   s.equals("'&='")||
			   s.equals("'^='")||
			   s.equals("'|='");
	}
	
	private boolean IsOperatorUnary(String s) {
		// & | * | + | - | ~ | ! | ++ | -- | sizeof
		return s.equals("'++'")||
			   s.equals("'--'")||
			   s.equals("'*'")||
			   s.equals("'&'")||
			   s.equals("'+'")||
			   s.equals("'-'")||
			   s.equals("'~'")||
			   s.equals("'!'")||
			   s.equals("'sizeof'");
	}
	
	private ArrayList<ScannerToken> loadTokens(String tFile) {
		tknList = new ArrayList<ScannerToken>();
		
		ArrayList<String> tknStr = MiniCCUtil.readFile(tFile);
		
		for(String str: tknStr) {
			if(str.trim().length() <= 0) {
				continue;
			}
			
			ScannerToken st = new ScannerToken();
			//[@0,0:2='int',<'int'>,1:0]
			String[] segs;
			if(str.indexOf("<','>") > 0) {
				str = str.replace("','", "'DOT'");
				
				segs = str.split(",");
				segs[1] = "=','";
				segs[2] = "<','>";
				
			}else {
				segs = str.split(",");
			}
			st.lexme = segs[1].substring(segs[1].indexOf("=") + 2,segs[1].length() - 1);
			st.type  = segs[2].substring(segs[2].indexOf("<") + 1, segs[2].length() - 1);
			String[] lc = segs[3].split(":");
			st.line = Integer.parseInt(lc[0]);
			st.column = Integer.parseInt(lc[1].replace("]", ""));
			
			tknList.add(st);
			//System.out.println(st.type);
		}
		return tknList;
	}
	
    private ASTToken getToken() {
    	ScannerToken scannertoken = tknList.get(tokenIndex);
        ASTToken token = new ASTToken(scannertoken.lexme, tokenIndex);
        tokenIndex ++;
        return token;
    }

	public void matchToken(String type) {
		if(tokenIndex < tknList.size()) {
			ScannerToken next = tknList.get(tokenIndex);
			if(!next.type.equals(type)) {
				System.out.println("[ERROR]Parser: unmatched token, expected = " + type + ", " 
						+ "input = " + next.type);
			}
			else {
				tokenIndex++;
			}
		}
	}

	//program 
	//	func_list
	public ASTNode program() {
		ASTCompilationUnit p = new ASTCompilationUnit();
		ArrayList<ASTNode> fl = funcList();
		if(fl != null) {
			//p.getSubNodes().add(fl);
			p.items.addAll(fl);
		}
		p.children.addAll(p.items);
		return p;
	}

	//func_list
	//	def_func func_list
	//	e
	public ArrayList<ASTNode> funcList() {
		ArrayList<ASTNode> fl = new ArrayList<ASTNode>();
		
		nextToken = tknList.get(tokenIndex);
		if(nextToken.type.equals("EOF")) {
			return null;
		}else {
			ASTNode f = func();
			fl.add(f);
			ArrayList<ASTNode> fl2 = funcList();
			if(fl2 != null) {
				fl.addAll(fl2);
			}
			return fl;
		}
	}

	//def_func
	//	type_spec declarator '(' arguments ')' comp_state
	public ASTNode func() {
		ASTFunctionDefine fdef = new ASTFunctionDefine();
		
		List<ASTToken> s = specs();
		
		
		
		ASTDeclarator dec = declarator();
		ASTFunctionDeclarator fdec = new ASTFunctionDeclarator();
		fdec.declarator = dec;
		fdec.children.add(dec);
		
		
		matchToken("'('");
		ArrayList<ASTParamsDeclarator> pl = arguments();
		matchToken("')'");
		if(pl != null) {
			fdec.params.addAll(pl);
			fdec.children.addAll(pl);
		}
		
		ASTCompoundStatement cs = compstate();
		
		fdef.specifiers = s;
		fdef.children.addAll(s);
		fdef.declarator = fdec;
		fdef.children.add(fdec);
		fdef.body = cs;
		fdef.children.add(cs);
		return fdef;
	}
	
	//specs
	//	type_spec specs
	//	e
	public List<ASTToken> specs(){
		ArrayList<ASTToken> ss = new ArrayList<ASTToken>();
		
		ASTToken ts = type_spec();
		ss.add(ts);
		
		nextToken = tknList.get(tokenIndex);
		if(IsSpecifier(nextToken.type)) {
			List<ASTToken> ss2 = specs();
			ss.addAll(ss2);
		}
		
		return ss;
	}
	
	//type_spec
	//	void | char | short | int | long | float 
	//| double | signed | unsigned
	public ASTToken type_spec() {
		//System.out.println("type_spec...");
		ScannerToken st = tknList.get(tokenIndex);
		
		ASTToken t = new ASTToken();
		if(IsSpecifier(st.type)) {
			t.tokenId = tokenIndex;
			t.value = st.lexme;
			tokenIndex++;
		}
		return t;
	}

	//arguments
	//	arg_list
	//	e
	public ArrayList<ASTParamsDeclarator> arguments() {
		nextToken = tknList.get(tokenIndex);
		if(nextToken.type.equals("')'")) { //ending
			return null;
		}
		else {
			ArrayList<ASTParamsDeclarator> al = argList();
			return al;
		}
	}

	//arg_list
	//	arg ',' arg_list
	//	arg
	public ArrayList<ASTParamsDeclarator> argList() {
		ArrayList<ASTParamsDeclarator> pdl = new ArrayList<ASTParamsDeclarator>();
		ASTParamsDeclarator pd = argument();
		pdl.add(pd);
		
		nextToken = tknList.get(tokenIndex);
		if(nextToken.type.equals("','")) {
			matchToken("','");
			ArrayList<ASTParamsDeclarator> pdl2 = argList();
			pdl.addAll(pdl2);
		}
		
		return pdl;
	}
		
	//arg
	//	type_spec declarator
	public ASTParamsDeclarator argument() {
		ASTParamsDeclarator pd = new ASTParamsDeclarator();
		List<ASTToken> ss = specs();
		pd.specfiers = ss;
		pd.children.addAll(ss);
		
		ASTIdentifier id = new ASTIdentifier();
		id.tokenId = tokenIndex;
		id.value = tknList.get(tokenIndex).lexme;
		matchToken("Identifier");
		
		ASTVariableDeclarator vd =  new ASTVariableDeclarator();
		vd.identifier = id;
		vd.children.add(id);
		pd.declarator = vd;
		pd.children.add(vd);
		
		return pd;
	}

	

	//comp_state
	//	'{' states '}'
	public ASTCompoundStatement compstate() {
		matchToken("'{'");
		ASTCompoundStatement cs = new ASTCompoundStatement();
		ArrayList<ASTNode> ss = states();
		cs.blockItems = ss;
		if(ss != null)
			cs.children.addAll(ss);
		matchToken("'}'");

		return cs;
	}
	
	
	//states
	//	state states
	//	decl states
	//	e
	public ArrayList<ASTNode> states() {
		ArrayList<ASTNode> sl = new ArrayList<ASTNode>();
		nextToken = tknList.get(tokenIndex);
		//System.out.println(nextToken.type);
		if(nextToken.type.equals("'}'")) {
			
			return null;
		}else {
			if(IsSpecifier(nextToken.type)) {
				ASTDeclaration s = decl();
				sl.add(s);
			}else {
				ASTStatement s = state();
				sl.add(s);
			}
			
			ArrayList<ASTNode> sl2 = states();
			if(sl2 != null) {
				sl.addAll(sl2);
			}
			return sl;
		}
	}
	
	

	
	//decl
	//	type_spec init_declarator_list ';'
	public ASTDeclaration decl() {
		ASTDeclaration d = new ASTDeclaration();
		ArrayList<ASTToken> ss = new ArrayList<>();
		ss.addAll(specs());
		ArrayList<ASTInitList> initlist = initdeclaratorList();
		matchToken("';'");
		
		d.specifiers = ss;
		d.initLists = initlist;
		d.children.addAll(ss);
		d.children.addAll(initlist);
		
		return d;
	}
	
	//init_declarator_list
	//	init_declarator
	//	init_declarator ',' init_declarator_list
	public ArrayList<ASTInitList> initdeclaratorList(){
		
		ArrayList<ASTInitList> il = new ArrayList<ASTInitList>();
		ASTInitList idec = initdeclarator();
		il.add(idec);
		
		nextToken = tknList.get(tokenIndex);
		if(nextToken.type.equals("','")) {
			matchToken("','");
			ArrayList<ASTInitList> il2 = initdeclaratorList();
			il.addAll(il2);
		}
		
		return il;
	}
	
	//init_declarator
	//	declarator
	//	declarator '=' initializer
	public ASTInitList initdeclarator() {
		ASTInitList idec = new ASTInitList();
		idec.declarator = declarator();
		idec.children.add(idec.declarator);
		idec.exprs = new ArrayList<ASTExpression>();
		if(tknList.get(tokenIndex).type.equals("'='")) {
			matchToken("'='");
			ArrayList<ASTExpression> initial = initializer();
			if(initial != null)
				idec.exprs = initial;
			idec.children.addAll(initial);
		}
		return idec;
	}
	
	//declarator
	//	identifier post_declarator
	public ASTDeclarator declarator() {
		
		ASTIdentifier id = new ASTIdentifier();
		id.tokenId = tokenIndex;
		id.value = tknList.get(tokenIndex).lexme;
		matchToken("Identifier");
		ASTVariableDeclarator vd = new ASTVariableDeclarator();
		vd.identifier = id;
		vd.children.add(id);
		
		return post_declarator(vd);
	}
	
	//post_declarator
	//	e
	//	'[' ']'	post_declarator
	//	'[' exp_assign ']' post_declarator
	public ASTDeclarator post_declarator(ASTDeclarator vd) {
		if(tknList.get(tokenIndex).type.equals("'['")) {
			matchToken("'['");
			ASTArrayDeclarator ad = new ASTArrayDeclarator();
			ad.declarator = vd;
			ad.children.add(vd);
			if(!tknList.get(tokenIndex).type.equals("']'")){
				ASTExpression ea = exp_assign();
				ad.expr = ea;
				ad.children.add(ea);
			}
			matchToken("']'");
			return post_declarator(ad);
		}else {
			return vd;
		}
	}
	
	
	//initializer
	//	exp_assign
	//	'{' exp '}'
	public ArrayList<ASTExpression> initializer(){
		ArrayList<ASTExpression> initial = new ArrayList<ASTExpression>();
		if(tknList.get(tokenIndex).type.equals("'{'")) {
			matchToken("'{'");
			
			ArrayList<ASTExpression> iList = new ArrayList<ASTExpression>();
			iList = exp();
			initial.addAll(iList);
			matchToken("'}'");
		}else {
			ASTExpression ea=exp_assign();
			initial.add(ea);
		}
		return initial;
	}

	//state
	//	comp_state
	//	select_state
	//	iteration_state
	//	return_state
	//	break_state
	//	continue_state
	//	goto_state
	//	exp_state
	public ASTStatement state() {
		nextToken = tknList.get(tokenIndex);
		
		if(nextToken.type.equals("'{'")) {
			return compstate();
		}else if(nextToken.type.equals("'if'")) {
			return selectstate();
		}else if(nextToken.type.equals("'for'")) {
			return iterationstate();
		}else if(nextToken.type.equals("'return'")) {
			return returnstate();
		}else if(nextToken.type.equals("'goto'")) {
			return gotostate();
		}else if(nextToken.type.equals("'continue'")) {
			return continuestate();
		}else if(nextToken.type.equals("'break'")) {
			return breakstate();
		}else{
			return expstate();
		}
	}
	
	//exp_state
	//	exp ';'
	//	';'
	public ASTExpressionStatement expstate() {
		ASTExpressionStatement es = new ASTExpressionStatement();
		if(!tknList.get(tokenIndex).type.equals("';'")) {
			ArrayList<ASTExpression> e = exp();
			es.exprs = e;
			es.children.addAll(e);
		}
		matchToken("';'");
		return es;
	}
	
	//select_state
	//	'if' '(' exp ')' state
	//	'if' '(' exp ')' state else state
	public ASTSelectionStatement selectstate() {
		ASTSelectionStatement ss = new ASTSelectionStatement();
		
		matchToken("'if'");
		matchToken("'('");
		LinkedList<ASTExpression> cond = new LinkedList<>(exp());
		matchToken("')'");
		ASTStatement then1 = state();
		ss.cond = cond;
		ss.then = then1;
		ss.children.addAll(cond);
		ss.children.add(then1);
				
		
		
		if(tknList.get(tokenIndex).type.equals("'else'")) {
			matchToken("'else'");
			ASTStatement then2 = state();
			ss.otherwise = then2;
			ss.children.add(then2);
		}
		return ss;
	}
	
	//iteration_state
	//	'for' '('   exp_state exp_state exp  ')' state
	//	'for' '('   exp_state exp_state  ')' state
	//	'for' '('   decl exp_state exp  ')' state
	//	'for' '('   decl exp_state  ')' state
	public ASTStatement iterationstate() {
		matchToken("'for'");
		matchToken("'('");
		
		if(IsSpecifier(tknList.get(tokenIndex).type)) {
			
			ASTIterationDeclaredStatement is = new ASTIterationDeclaredStatement();
			ASTDeclaration id = decl();
			LinkedList<ASTExpression> cond;
			LinkedList<ASTExpression> step;
			
			if(tknList.get(tokenIndex).type.equals("';'")) {
				cond = null;
			}else {
				cond = new LinkedList<>(exp());
			}
			matchToken("';'");
			
			if(tknList.get(tokenIndex).type.equals("')'")) {
				step = null;
			}else {
				step = new LinkedList<>(exp());
			}
			matchToken("')'");
			
			ASTStatement s = state();
			
			is.init = id;
			is.cond = cond;
			is.step = step;
			is.stat = s;
			is.children.add(id);
			is.children.addAll(cond);
			is.children.addAll(step);
			is.children.add(s);
			
			return is;
		}else {
			ASTIterationStatement is = new ASTIterationStatement();
			LinkedList<ASTExpression> ie;
			LinkedList<ASTExpression> cond;
			LinkedList<ASTExpression> step;		
			
			if(tknList.get(tokenIndex).type.equals("';'")) {
				ie = null;
			}else {
				ie = new LinkedList<>(exp());
			}
			matchToken("';'");
			
			if(tknList.get(tokenIndex).type.equals("';'")) {
				cond = null;
			}else {
				cond = new LinkedList<>(exp());
			}
			matchToken("';'");
			
			if(tknList.get(tokenIndex).type.equals("')'")) {
				step = null;
			}else {
				step = new LinkedList<>(exp());
			}
			matchToken("')'");
			
			ASTStatement s = state();
			
			is.init = ie;
			is.cond = cond;
			is.step = step;
			is.stat = s;
			is.children.addAll(ie);
			is.children.addAll(cond);
			is.children.addAll(step);
			is.children.add(s);
			
			return is;
		}
	}
	
	//goto_state
	// 'goto' identifier ';'
	public ASTGotoStatement gotostate() {
		matchToken("'goto'");
		ASTGotoStatement gs = new ASTGotoStatement();
		
		nextToken = tknList.get(tokenIndex);
		ASTIdentifier id = new ASTIdentifier();
		id.tokenId = tokenIndex;
		id.value = nextToken.lexme;
		matchToken("Identifier");
		
		gs.label = id;
		gs.children.add(id);
		
		matchToken("';'");
		return gs;
	}
	

	//return_state
	//	'return' assign_exp ';'
	//	'return' ';'
	public ASTReturnStatement returnstate() {
		matchToken("'return'");
		ASTReturnStatement rs = new ASTReturnStatement();
		if(!tknList.get(tokenIndex).type.equals("';'")) {
			ASTExpression e = exp_assign();
			rs.expr.add(e);
			rs.children.add(e);
		}else {
			rs.expr = null;
		}
		matchToken("';'");
		return rs;
	}
	
	//continue_state
	//	'continue' ';'
	public ASTContinueStatement continuestate() {
		matchToken("'continue'");
		ASTContinueStatement cs = new ASTContinueStatement();
		matchToken("';'");
		return cs;
	}
	
	//break_state
	//	'break' ';'
	public ASTBreakStatement breakstate() {
		matchToken("'break'");
		ASTBreakStatement bs = new ASTBreakStatement();
		matchToken("';'");
		return bs;
	}
	
	//exp
	//	exp_assign , exp
	//	exp_assign
	public ArrayList<ASTExpression> exp(){
		ArrayList<ASTExpression> ealist = new ArrayList<ASTExpression>();
		ASTExpression ea = exp_assign();
		ealist.add(ea);
		
		nextToken = tknList.get(tokenIndex);
		if(nextToken.type.equals("','")) {
			matchToken("','");
			ArrayList<ASTExpression> ealist2 = exp();
			ealist.addAll(ealist2);
		}
		
		return ealist;
	}
	
	//exp_assign
	//	exp_con
	//	exp_unary operator_assign exp_assign
	public ASTExpression exp_assign() {
		int pos = 0;
		int cnt_small = 0;
		int cnt_middle = 0;
		int cnt_big = 0;//System.out.println(tknList.get(tokenIndex).type);
		while(tknList.size() > pos + tokenIndex &&
			  !tknList.get(tokenIndex + pos).type.equals("','") &&
              !tknList.get(tokenIndex + pos).type.equals("';'")) {
			//System.out.println(tknList.get(tokenIndex+pos).type);
			if(IsOperatorAssign(tknList.get(tokenIndex + pos).type)) {
				ASTBinaryExpression be = new ASTBinaryExpression();
				ASTExpression exp1 = exp_unary();
				ASTToken op = operator_assign();
				ASTExpression exp2 = exp_assign();
				be.expr1 = exp1;
				be.op = op;
				be.expr2 = exp2;
				be.children.add(exp1);
				be.children.add(exp2);
				be.children.add(op);
				return be;
			}else if(tknList.get(tokenIndex + pos).type.equals("'('")) {
				cnt_small++;
			}else if(tknList.get(tokenIndex + pos).type.equals("'['")) {
				cnt_middle++;
			}else if(tknList.get(tokenIndex + pos).type.equals("'{'")) {
				cnt_big++;
			}else if(tknList.get(tokenIndex + pos).type.equals("')'")) {
				cnt_small--;
			}else if(tknList.get(tokenIndex + pos).type.equals("']'")) {
				cnt_middle--;
			}else if(tknList.get(tokenIndex + pos).type.equals("'}'")) {
				cnt_big--;
			}
			if(cnt_small < 0 || cnt_middle < 0 || cnt_big < 0) {
				break;
			}
			pos++;
		}
		return exp_con();
	}
	
	//operator_assign
	//	= | *= | /= | %= | += | -= | <<= | >>= | &= | ^= | |=
	public ASTToken operator_assign() {
		ScannerToken st = tknList.get(tokenIndex);
		
		ASTToken t = new ASTToken();
		if(IsOperatorAssign(st.type)) {
			t.tokenId = tokenIndex;
			t.value = st.lexme;
			tokenIndex++;
		}
		return t;
	}
	
	//exp_con
    //	exp_logical_or
    //	exp_logical_or '?' exp ':' exp_con
	public ASTExpression exp_con() {
		ASTExpression elo = exp_logical_or();
		if(tknList.get(tokenIndex).type.equals("'?'")) {
			matchToken("'?'");
			LinkedList<ASTExpression> expt = new LinkedList<>(exp());
			matchToken("':'");
			ASTExpression expf = exp_con();
			ASTConditionExpression ec = new ASTConditionExpression();
			ec.condExpr = elo;
			ec.trueExpr = expt;
			ec.falseExpr = expf;
			ec.children.add(elo);
			ec.children.addAll(expt);
			ec.children.add(expf);
			return ec;
		}else {
			return elo;
		}
	}
	
	//exp_logical_or
	//	exp_logical_and
	//	exp_logical_and '||' exp_logical_or
	public ASTExpression exp_logical_or() {
		ASTExpression ela = exp_logical_and();
		if(tknList.get(tokenIndex).type.equals("'||'")) {
			ASTToken op = getToken();
			ASTBinaryExpression elo = new ASTBinaryExpression();
			ASTExpression elo2 = exp_logical_or();
			elo.expr1 = ela;
			elo.expr2 = elo2;
			elo.op = op;
			elo.children.add(ela);
			elo.children.add(elo2);
			elo.children.add(op);
			return elo;
		}else {
			return ela;
		}
	}
	
	//exp_logical_and
	//	exp_inclusive_or
	//	exp_inclusive_or '&&' exp_logical_and
	public ASTExpression exp_logical_and() {
		ASTExpression eio = exp_inclusive_or();
		if(tknList.get(tokenIndex).type.equals("'&&'")) {
			ASTToken op = getToken();
			ASTBinaryExpression ela = new ASTBinaryExpression();
			ASTExpression ela2 = exp_logical_and();
			ela.expr1 = eio;
			ela.expr2 = ela2;
			ela.op = op;
			ela.children.add(eio);
			ela.children.add(ela2);
			ela.children.add(op);
			return ela;
		}else {
			return eio;
		}
	}			
	
	//exp_inclusive_or
	//	exp_exclusive_or
	//	exp_exclusive_or '|' exp_inclusive_or
	public ASTExpression exp_inclusive_or() {
		ASTExpression eeo = exp_exclusive_or();
		if(tknList.get(tokenIndex).type.equals("'|'")) {
			ASTToken op = getToken();
			ASTBinaryExpression eio = new ASTBinaryExpression();
			ASTExpression eio2 = exp_inclusive_or();
			eio.expr1 = eeo;
			eio.expr2 = eio2;
			eio.op = op;
			eio.children.add(eeo);
			eio.children.add(eio2);
			eio.children.add(op);
			return eio;
		}else {
			return eeo;
		}
	}	
	
	//exp_exclusive_or
	//	exp_and
	//	exp_and '^' exp_exclusive_or
	public ASTExpression exp_exclusive_or() {
		ASTExpression ea = exp_and();
		if(tknList.get(tokenIndex).type.equals("'^'")) {
			ASTToken op = getToken();
			ASTBinaryExpression eeo = new ASTBinaryExpression();
			ASTExpression eeo2 = exp_exclusive_or();
			eeo.expr1 = ea;
			eeo.expr2 = eeo2;
			eeo.op = op;
			eeo.children.add(ea);
			eeo.children.add(eeo2);
			eeo.children.add(op);
			return eeo;
		}else {
			return ea;
		}
	}
	
	//exp_and
	//	exp_equality
	//	exp_equality '&' exp_and
	public ASTExpression exp_and() {
		ASTExpression ee = exp_equality();
		if(tknList.get(tokenIndex).type.equals("'&'")) {
			ASTToken op = getToken();
			ASTBinaryExpression ea = new ASTBinaryExpression();
			ASTExpression ea2 = exp_and();
			ea.expr1 = ee;
			ea.expr2 = ea2;
			ea.op = op;
			ea.children.add(ee);
			ea.children.add(ea2);
			ea.children.add(op);
			return ea;
		}else {
			return ee;
		}
	}	
	
	//exp_equality
	//	exp_relational
	//	exp_relational '==' exp_equality
	//	exp_relational '!=' exp_equality
	public ASTExpression exp_equality() {
		ASTExpression er = exp_relational();
		if(tknList.get(tokenIndex).type.equals("'=='") ||
		   tknList.get(tokenIndex).type.equals("'!='")) {
			ASTToken op = getToken();
			ASTBinaryExpression ee = new ASTBinaryExpression();
			ASTExpression ee2 = exp_equality();
			ee.expr1 = er;
			ee.expr2 = ee2;
			ee.op = op;
			ee.children.add(er);
			ee.children.add(ee2);
			ee.children.add(op);
			return ee;
		}else {
			return er;
		}
	}		
	
	//exp_relational
	//	exp_shift
	//	exp_shift '<' exp_relational
	//	exp_shift '>' exp_relational
	//	exp_shift '<=' exp_relational
	//	exp_shift '>=' exp_relational	
	public ASTExpression exp_relational() {
		ASTExpression es = exp_shift();
		if(tknList.get(tokenIndex).type.equals("'<'") ||
		   tknList.get(tokenIndex).type.equals("'>'") ||
		   tknList.get(tokenIndex).type.equals("'<='") ||
		   tknList.get(tokenIndex).type.equals("'>='")) {
			ASTToken op = getToken();
			ASTBinaryExpression er = new ASTBinaryExpression();
			ASTExpression er2 = exp_relational();
			er.expr1 = es;
			er.expr2 = er2;
			er.op = op;
			er.children.add(es);
			er.children.add(er2);
			er.children.add(op);
			return er;
		}else {
			return es;
		}
	}		

	//exp_shift
	//	exp_additive
	//	exp_additive '<<' exp_shift
	//	exp_additive '>>' exp_shift
	public ASTExpression exp_shift() {
		ASTExpression ea = exp_additive();
		if(tknList.get(tokenIndex).type.equals("'<<'") ||
		   tknList.get(tokenIndex).type.equals("'>>'")) {
			ASTToken op = getToken();
			ASTBinaryExpression es = new ASTBinaryExpression();
			ASTExpression es2 = exp_shift();
			es.expr1 = ea;
			es.expr2 = es2;
			es.op = op;
			es.children.add(ea);
			es.children.add(es2);
			es.children.add(op);
			return es;
		}else {
			return ea;
		}
	}	
	
	//exp_additive
	//	exp_multiplicative
	//	exp_multiplicative '+' exp_additive
	//	exp_multiplicative '-' exp_additive
	public ASTExpression exp_additive() {
		ASTExpression em = exp_multiplicative();
		if(tknList.get(tokenIndex).type.equals("'+'") ||
		   tknList.get(tokenIndex).type.equals("'-'")) {
			ASTToken op = getToken();
			//System.out.println(op.value);
			ASTBinaryExpression ea = new ASTBinaryExpression();
			ASTExpression ea2 = exp_additive();
			ea.expr1 = em;
			ea.expr2 = ea2;
			ea.op = op;
			ea.children.add(em);
			ea.children.add(ea2);
			ea.children.add(op);
			return ea;
		}else {
			return em;
		}
	}	
	
	//exp_multiplicative
	//	exp_cast
	//	exp_cast '*' exp_multiplicative
	//	exp_cast '/' exp_multiplicative
	//	exp_cast '%' exp_multiplicative
	public ASTExpression exp_multiplicative() {
		ASTExpression ec = exp_cast();
		if(tknList.get(tokenIndex).type.equals("'*'") ||
		   tknList.get(tokenIndex).type.equals("'/'") ||
		   tknList.get(tokenIndex).type.equals("'%'")) {
			ASTToken op = getToken();
			ASTBinaryExpression em = new ASTBinaryExpression();
			ASTExpression em2 = exp_multiplicative();
			em.expr1 = ec;
			em.expr2 = em2;
			em.op = op;
			em.children.add(ec);
			em.children.add(em2);
			em.children.add(op);
			return em;
		}else {
			return ec;
		}
	}	
	
	
	//exp_cast
	//	exp_unary
	//	'(' type_spec ')' exp_cast
	public ASTExpression exp_cast() {
		if(tknList.get(tokenIndex).type.equals("'('") && 
		   IsSpecifier(tknList.get(tokenIndex + 1).type)) {
			matchToken("'('");
			List<ASTToken> ss = specs();
			matchToken("')'");
			ASTExpression ec2 = exp_cast();
			ASTTypename tn = new ASTTypename();
			tn.specfiers = new ArrayList<>();
			tn.specfiers = ss;
			tn.children.addAll(ss);
			
			ASTCastExpression ec = new ASTCastExpression();
			
			ec.typename = tn;
			ec.expr = ec2;
			ec.children.add(tn);
			ec.children.add(ec2);
			
			return ec;
		}else {
			ASTExpression eu = exp_unary();
			return eu;
		}
	}		
	
	//exp_unary
	//	exp_postfix
	//	operator_unary exp_cast
	public ASTExpression exp_unary() {
		if(IsOperatorUnary(tknList.get(tokenIndex).type)) {
			ASTToken op = operator_unary();
			ASTExpression eu2 = exp_unary();
			ASTUnaryExpression eu = new ASTUnaryExpression();
			eu.op = op;
			eu.expr = eu2;
			eu.children.add(op);
			eu.children.add(eu2);
			return eu;
		}else {
			ASTExpression ep = exp_postfix();
			return ep;
		}
	}
	
	public ASTToken operator_unary() {
		ScannerToken st = tknList.get(tokenIndex);
		
		ASTToken t = new ASTToken();
		if(IsOperatorUnary(st.type)) {
			t.tokenId = tokenIndex;
			t.value = st.lexme;
			tokenIndex++;
		}
		return t;
	}
	
	//exp_postfix
	//	exp_pri post_exp_postfix
	public ASTExpression exp_postfix() {
		ASTExpression epri = exp_pri();
		ASTExpression node = epri;
		ASTExpression ep = post_exp_postfix(node);
		return ep;
	}
	
	//post_exp_postfix
	//	e
	//	'[' exp ']' post_exp_postfix
	//	'(' exp ')' post_exp_postfix
	//	'(' ')' post_exp_postfix
	//	'.' identifier post_exp_postfix
	//	'->' identifier post_exp_postfix
	//	'++' post_exp_postfix
	//	'--' post_exp_postfix
	public ASTExpression post_exp_postfix(ASTExpression node) {
		if(tknList.get(tokenIndex).type.equals("'['")) {
			ASTArrayAccess aa = new ASTArrayAccess();
			ASTExpression arrayName = node;
			List<ASTExpression> elements = new ArrayList<ASTExpression>();
			
			matchToken("'['");
			elements = exp(); 
			matchToken("']'");
			
			aa.arrayName = arrayName;
			aa.elements = elements;
			aa.children.add(arrayName);
			aa.children.addAll(elements);
			
			return post_exp_postfix(aa);
		}else if(tknList.get(tokenIndex).type.equals("'('")) {
			ASTFunctionCall fc = new ASTFunctionCall();
			ASTExpression funcname = node;
			List<ASTExpression> argList = new ArrayList<ASTExpression>();
			
			matchToken("'('");
			if(!tknList.get(tokenIndex).type.equals("')'")) {
				argList = exp(); 
			}
				
			matchToken("')'");
			
			fc.funcname = funcname;
			fc.argList = argList;
			fc.children.add(funcname);
			if(argList != null)
				fc.children.addAll(argList);
			
			return post_exp_postfix(fc);
		}else if(tknList.get(tokenIndex).type.equals("'.'") ||
				 tknList.get(tokenIndex).type.equals("'->'")) {
			ASTMemberAccess ma = new ASTMemberAccess();
			ASTToken op = getToken();
			ASTExpression master = node;
			ASTIdentifier member = new ASTIdentifier();
			
			nextToken = tknList.get(tokenIndex);
			member.tokenId = tokenIndex;
			member.value = nextToken.lexme;
			matchToken("Identifier");
			
			ma.master = master;
			ma.member = member;
			ma.op = op;
			ma.children.add(master);
			ma.children.add(master);
			ma.children.add(master);
			
			return post_exp_postfix(ma);
		}else if(tknList.get(tokenIndex).type.equals("'++'") ||
				 tknList.get(tokenIndex).type.equals("'--'")) {
			ASTPostfixExpression pe = new ASTPostfixExpression();
			ASTExpression expr = node;
			ASTToken op = getToken();
			
			pe.expr = expr;
			pe.op = op;
			pe.children.add(expr);
			pe.children.add(op);
			
			return post_exp_postfix(pe);
		}else {
			return node;
		}
	}
	
	
	//exp_pri
	//	identifier
	//	IntegerConstant
	//	FloatingConstant
	//	CharacterConstant
	//	StringLiteral
	//	'(' exp_assign ')'
	public ASTExpression exp_pri() {
		nextToken = tknList.get(tokenIndex);
		if(nextToken.type.equals("Identifier")) {
			ASTIdentifier id = new ASTIdentifier();
			id.tokenId = tokenIndex;
			id.value = nextToken.lexme;
			matchToken("Identifier");
			return id;
		}else if(nextToken.type.equals("IntegerConstant")) {
			//System.out.println(nextToken.lexme);
			ASTIntegerConstant ic = new ASTIntegerConstant();
			ic.tokenId = tokenIndex;
			ic.value = Integer.parseInt(nextToken.lexme);
			matchToken("IntegerConstant");
			return ic;
		}else if(nextToken.type.equals("FloatingConstant")) {
			ASTFloatConstant ifc = new ASTFloatConstant();
			ifc.tokenId = tokenIndex;
			ifc.value = Double.parseDouble(nextToken.lexme);
			matchToken("FloatingConstant");
			return ifc;
		}else if(nextToken.type.equals("CharacterConstant")) {
			ASTCharConstant cc = new ASTCharConstant();
			cc.tokenId = tokenIndex;
			cc.value = nextToken.lexme;
			matchToken("CharacterConstant");
			return cc;
		}else if(nextToken.type.equals("StringLiteral")) {
			ASTStringConstant sl = new ASTStringConstant();
			sl.tokenId = tokenIndex;
			sl.value = nextToken.lexme;
			matchToken("StringLiteral");
			return sl;
		}else if(nextToken.type.equals("'('")) {
			matchToken("'('");
			ASTExpression ea = exp_assign();
			matchToken("')'");
			return ea;
		}else {
			return null;
		}
	}
	
}
