package bit.minisys.minicc.parser;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;

import org.antlr.v4.gui.TreeViewer;

import com.fasterxml.jackson.databind.ObjectMapper;

import bit.minisys.minicc.MiniCCCfg;
import bit.minisys.minicc.internal.util.MiniCCUtil;
import bit.minisys.minicc.parser.ast.*;

/*
 * PROGRAM     --> FUNC_LIST
 * FUNC_LIST   --> FUNC FUNC_LIST | e
 * FUNC        --> TYPE ID '(' ARGUMENTS ')' CODE_BLOCK
 * TYPE        --> INT
 * ARGS   	   --> e | ARG_LIST
 * ARG_LIST    --> ARG ',' ARGLIST | ARG
 * ARG    	   --> TYPE ID
 * CODE_BLOCK  --> '{' STMTS '}'
 * STMTS       --> STMT STMTS | e
 * STMT        --> RETURN_STMT
 *
 * RETURN STMT --> RETURN EXPR ';'
 *
 * EXPR        --> TERM EXPR'
 * EXPR'       --> '+' TERM EXPR' | '-' TERM EXPR' | e
 *
 * TERM        --> FACTOR TERM'
 * TERM'       --> '*' FACTOR TERM' | e
 *
 * FACTOR      --> ID  
 * 
 */

class ScannerToken{
	public String lexme;
	public String type;
	public int	  line;
	public int    column;
}

public class ExampleParser implements IMiniCCParser {

	private ArrayList<ScannerToken> tknList;
	private int tokenIndex;
	private ScannerToken nextToken;
	
	@Override
	public String run(String iFile) throws Exception {
		System.out.println("Parsing...");

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

		//TODO: write to file
		
		
		return oFile;
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
			st.lexme = segs[1].substring(segs[1].indexOf("=") + 1);
			st.type  = segs[2].substring(segs[2].indexOf("<") + 1, segs[2].length() - 1);
			String[] lc = segs[3].split(":");
			st.line = Integer.parseInt(lc[0]);
			st.column = Integer.parseInt(lc[1].replace("]", ""));
			
			tknList.add(st);
		}
		
		return tknList;
	}

	private ScannerToken getToken(int index){
		if (index < tknList.size()){
			return tknList.get(index);
		}
		return null;
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

	//PROGRAM --> FUNC_LIST
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

	//FUNC_LIST --> FUNC FUNC_LIST | e
	public ArrayList<ASTNode> funcList() {
		ArrayList<ASTNode> fl = new ArrayList<ASTNode>();
		
		nextToken = tknList.get(tokenIndex);
		if(nextToken.type.equals("EOF")) {
			return null;
		}
		else {
			ASTNode f = func();
			fl.add(f);
			ArrayList<ASTNode> fl2 = funcList();
			if(fl2 != null) {
				fl.addAll(fl2);
			}
			return fl;
		}
	}

	//FUNC --> TYPE ID '(' ARGUMENTS ')' CODE_BLOCK
	public ASTNode func() {
		ASTFunctionDefine fdef = new ASTFunctionDefine();
		
		ASTToken s = type();
		
		fdef.specifiers.add(s);
		fdef.children.add(s);
		
		ASTFunctionDeclarator fdec = new ASTFunctionDeclarator();

		ASTIdentifier id = new ASTIdentifier();
		id.tokenId = tokenIndex;
		matchToken("Identifier");

		fdef.children.add(id);
		
		matchToken("'('");
		ArrayList<ASTParamsDeclarator> pl = arguments();
		matchToken("')'");
		
		//fdec.identifiers.add(id);
		if(pl != null) {
			fdec.params.addAll(pl);
			fdec.children.addAll(pl);
		}
		
		ASTCompoundStatement cs = codeBlock();

		fdef.declarator = fdec;
		fdef.children.add(fdec);
		fdef.body = cs;
		fdef.children.add(cs);

		
		return fdef;
	}

	//TYPE --> INT |FLOAT | CHART
	public ASTToken type() {
		ScannerToken st = tknList.get(tokenIndex);
		
		ASTToken t = new ASTToken();
		if(st.type.equals("'int'")) {
			t.tokenId = tokenIndex;
			t.value = st.lexme;
			tokenIndex++;
		}
		return t;
	}

	//ARGUMENTS --> e | ARG_LIST
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

	//ARG_LIST --> ARGUMENT ',' ARGLIST | ARGUMENT
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
		
	//ARGUMENT --> TYPE ID
	public ASTParamsDeclarator argument() {
		ASTParamsDeclarator pd = new ASTParamsDeclarator();
		ASTToken t = type();
		pd.specfiers.add(t);
		
		ASTIdentifier id = new ASTIdentifier();
		id.tokenId = tokenIndex;
		matchToken("Identifier");
		
		ASTVariableDeclarator vd =  new ASTVariableDeclarator();
		vd.identifier = id;
		pd.declarator = vd;
		
		return pd;
	}

	

	//CODE_BLOCK --> '{' STMTS '}'
	public ASTCompoundStatement codeBlock() {
		matchToken("'{'");
		ASTCompoundStatement cs = stmts();
		matchToken("'}'");

		return cs;
	}

	//STMTS --> STMT STMTS | e
	public ASTCompoundStatement stmts() {
		nextToken = tknList.get(tokenIndex);
		if (nextToken.type.equals("'}'"))
			return null;
		else {
			ASTCompoundStatement cs = new ASTCompoundStatement();
			ASTStatement s = stmt();
			cs.blockItems.add(s);
			
			ASTCompoundStatement cs2 = stmts();
			if(cs2 != null)
				cs.blockItems.add(cs2);
			return cs;
		}
	}

	//STMT --> ASSIGN_STMT | RETURN_STMT | DECL_STMT | FUNC_CALL
	public ASTStatement stmt() {
		nextToken = tknList.get(tokenIndex);

		if(nextToken.type.equals("'return'")) {
			return returnStmt();
		}else{
			System.out.println("[ERROR]Parser: unreachable stmt!");
			return null;
		}
	}

	//RETURN_STMT --> RETURN EXPR ';'
	public ASTReturnStatement returnStmt() {
		matchToken("'return'");
		ASTReturnStatement rs = new ASTReturnStatement();
		ASTExpression e = expr();
		matchToken("';'");
		rs.expr.add(e);
		return rs;
	}

	//EXPR --> TERM EXPR'
	public ASTExpression expr() {
		ASTExpression term = term();
		ASTBinaryExpression be = expr2();
		
		if(be != null) {
			be.expr1 = term;
			return be;
		}else {
			return term;
		}
	}

	//EXPR' --> '+' TERM EXPR' | '-' TERM EXPR' | e
	public ASTBinaryExpression expr2() {
		nextToken = tknList.get(tokenIndex);
		if (nextToken.type.equals("';'"))
			return null;
		
		if(nextToken.type.equals("'+'")){
			ASTBinaryExpression be = new ASTBinaryExpression();
			
			ASTToken tkn = new ASTToken();
			tkn.tokenId = tokenIndex;
			matchToken("'+'");
			
			be.op = tkn;
			be.expr2 = term();
			
			ASTBinaryExpression expr = expr2();
			if(expr != null) {
				expr.expr1 = be;
				return expr;
			}
			
			return be;
		}else {
			return null;
		}
	}

	//TERM --> FACTOR TERM2
	public ASTExpression term() {
		ASTExpression f = factor();
		ASTBinaryExpression be = term2();
		
		if(be != null) {
			be.expr1 = f;
			return be;
		}else {
			return f;
		}
	}

	//TERM'--> '*' FACTOR TERM' | '/' FACTOR TERM' | e
	public ASTBinaryExpression term2() {
		nextToken = tknList.get(tokenIndex);
		if(nextToken.type.equals("'*'")){
			ASTBinaryExpression be = new ASTBinaryExpression();
			
			ASTToken tkn = new ASTToken();
			tkn.tokenId = tokenIndex;
			matchToken("'*'");
			
			be.op = tkn;
			be.expr2 = factor();
			
			ASTBinaryExpression term = term2();
			if(term != null) {
				term.expr1 = be;
				return term;
			}
			return be;
		}else {
			return null;
		}
	}

	//FACTOR --> '(' EXPR ')' | ID | CONST | FUNC_CALL
	public ASTExpression factor() {
		nextToken = tknList.get(tokenIndex);
		if(nextToken.type.equals("Identifier")) {
			ASTIdentifier id = new ASTIdentifier();
			id.tokenId = tokenIndex;
			matchToken("Identifier");
			return id;
		}else {
			return null;
		}
	}
}
