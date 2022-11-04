package bit.minisys.minicc.scanner;

import java.util.ArrayList;
import java.util.HashSet;

import bit.minisys.minicc.MiniCCCfg;
import bit.minisys.minicc.internal.util.MiniCCUtil;


enum DFA_STATE{
	DFA_STATE_INITIAL,     //³õÊ¼×´Ì¬
	
	DFA_STATE_NOTE_1,
	DFA_STATE_NOTE_2,
	DFA_STATE_NOTE_3,
	
	DFA_STATE_ID,
	
	DFA_STATE_CHR_0,
	DFA_STATE_CHR_1,
	DFA_STATE_CHR_2,
	DFA_STATE_CHR_ILL,
	
	DFA_STATE_STR_0,
	DFA_STATE_STR_1,
	DFA_STATE_STR_2,
	DFA_STATE_STR_ILL,
	
	DFA_STATE_CON_0,
	DFA_STATE_CON_1,
	DFA_STATE_CON_2,
	DFA_STATE_CON_3,
	DFA_STATE_CON_4,
	DFA_STATE_CON_5,
	DFA_STATE_CON_6,
	DFA_STATE_CON_7,
	DFA_STATE_CON_8,
	DFA_STATE_CON_9,
	DFA_STATE_CON_10,
	DFA_STATE_CON_11,
	DFA_STATE_CON_12,
	DFA_STATE_CON_13,
	DFA_STATE_CON_14,
	DFA_STATE_CON_15,
	DFA_STATE_CON_16,
	DFA_STATE_CON_17,
	DFA_STATE_CON_18,
	DFA_STATE_CON_19,
	DFA_STATE_CON_20,
	DFA_STATE_CON_21,
	DFA_STATE_CON_22,
	DFA_STATE_CON_23,
	DFA_STATE_CON_ILL,
	
	DFA_STATE_SOP,
    DFA_STATE_ADD_0,
    DFA_STATE_ADD_1,
    DFA_STATE_ADD_2,
    DFA_STATE_SUB_0,
    DFA_STATE_SUB_1,
    DFA_STATE_SUB_2,
    DFA_STATE_SUB_3,
    DFA_STATE_MUL_0,
    DFA_STATE_MUL_1,
    DFA_STATE_DIV_0,
    DFA_STATE_DIV_1,
    DFA_STATE_MOD_0,
    DFA_STATE_MOD_1,
    DFA_STATE_MOD_2,
    DFA_STATE_MOD_3,
    DFA_STATE_LEF_0,
    DFA_STATE_LEF_1,
    DFA_STATE_LEF_2,
    DFA_STATE_LEF_3,
    DFA_STATE_LEF_4,
    DFA_STATE_LEF_5,
    DFA_STATE_RIG_0,
    DFA_STATE_RIG_1,
    DFA_STATE_RIG_2,
    DFA_STATE_RIG_3,
    DFA_STATE_ASS_0,
    DFA_STATE_ASS_1,
    DFA_STATE_OPP_0,
    DFA_STATE_OPP_1,
    DFA_STATE_AND_0,
    DFA_STATE_AND_1,
    DFA_STATE_AND_2,
    DFA_STATE_OR_0,
    DFA_STATE_OR_1,
    DFA_STATE_OR_2,
    DFA_STATE_XOR_0,
    DFA_STATE_XOR_1,
    DFA_STATE_COL_0,
    DFA_STATE_COL_1,
    DFA_STATE_POU_0,
    DFA_STATE_POU_1,
    DFA_STATE_DOT_0,
    DFA_STATE_DOT_1,
	
	
	DFA_STATE_SM,
	
	DFA_STATE_UNKNW
}

public class MyScanner implements IMiniCCScanner {
	
	private int lIndex = 0;
	private int cIndex = 0;
	private int charnum = 0;
	private boolean flagnote = true;
	
    private ArrayList<String> srcLines;
    
    private HashSet<String> keywordSet;
    
    private HashSet<String> charprefix;
    
    private HashSet<String> Stringprefix;
    
    private String cEscSequence;
    
    private String cMultiOp;
    
    private String cSinglOp;
    
    public MyScanner(){
    	cEscSequence="\'\"?\\abfnrtv";
    	cMultiOp="+-*/%<>=!&|^:#.";
    	cSinglOp="[](){};,~?";
    	
    	this.keywordSet = new HashSet<String>();
    	this.keywordSet.add("auto");
    	this.keywordSet.add("break");
    	this.keywordSet.add("case");
    	this.keywordSet.add("char");
    	this.keywordSet.add("const");
    	this.keywordSet.add("continue");
    	this.keywordSet.add("default");
    	this.keywordSet.add("do");
    	this.keywordSet.add("double");
    	this.keywordSet.add("else");
    	this.keywordSet.add("enum");
    	this.keywordSet.add("extern");
    	this.keywordSet.add("float");
    	this.keywordSet.add("for");
    	this.keywordSet.add("goto");
    	this.keywordSet.add("if");
    	this.keywordSet.add("inline");
    	this.keywordSet.add("int");
    	this.keywordSet.add("long");
    	this.keywordSet.add("register");
    	this.keywordSet.add("restrict");
    	this.keywordSet.add("return");
    	this.keywordSet.add("short");
    	this.keywordSet.add("signed");
    	this.keywordSet.add("sizeof");
    	this.keywordSet.add("static");
    	this.keywordSet.add("struct");
    	this.keywordSet.add("switch");
    	this.keywordSet.add("typedef");
    	this.keywordSet.add("union");
    	this.keywordSet.add("unsigned");
    	this.keywordSet.add("void");
    	this.keywordSet.add("volatile");
    	this.keywordSet.add("while"); 
    	
    	this.charprefix = new HashSet<String>();
    	this.charprefix.add("u");
    	this.charprefix.add("U");
    	this.charprefix.add("L");
    	
    	this.Stringprefix = new HashSet<String>();
    	this.Stringprefix.add("u");
    	this.Stringprefix.add("U");
    	this.Stringprefix.add("L");
    	this.Stringprefix.add("u8");
    	
    }

	private char getNextChar() {
		char c = Character.MAX_VALUE;
		while(true) {
			if(lIndex < this.srcLines.size()) {
				String line = this.srcLines.get(lIndex);
				if(cIndex < line.length()) {
					c = line.charAt(cIndex);
					cIndex++;
					break;
				}else {
					lIndex++;
					cIndex = 0;
					charnum++;
				}
			}else {
				break;
			}
		}
		if(c == '\u001a') {
			c = Character.MAX_VALUE;
		}
		return c;
	}

	private boolean isAlpha(char c) {
		return Character.isAlphabetic(c) || c == '_';
	}

	private boolean isDigit(char c) {
		return Character.isDigit(c);
	}
	
	private boolean isOctal(char c) {
		return c >= '0' && c <= '7';
	}
	
	private boolean isHex(char c) {
		return isDigit(c) || (c >= 'A' && c <= 'F') || (c >= 'a' && c <= 'f');
	}

	private boolean isAlphaOrDigit(char c) {
		return Character.isLetterOrDigit(c) || c == '_';
	}
	
	private String genToken(int num, String lexme, String type) {
		return genToken(1, num, lexme, type, this.cIndex - 1, this.lIndex);
	}
	private String genToken2(int num, String lexme, String type) {
		if(this.cIndex == 1) {			
			int tcIndex = this.srcLines.get(lIndex-1).length();
			return genToken(3, num, lexme, type, tcIndex - 1, this.lIndex - 1);
			
		}else
			return genToken(2, num, lexme, type, this.cIndex - 2, this.lIndex);
		
	}
	private String genToken(int cn, int num, String lexme, String type, int cIndex, int lIndex) {
		String strToken = "";
		
		strToken += "[@" + num + "," + (charnum - cn - lexme.length() + 1) + ":" + (charnum - cn);
		strToken += "='" + lexme + "',<" + type + ">," + (lIndex + 1) + ":" + (cIndex - lexme.length() + 1) + "]\n";
		
		return strToken;
	}
	
	@Override
	public String run(String iFile) throws Exception {
		
		System.out.println("Scanning...");
		String strTokens = "";
		int iTknNum = 0;

		this.srcLines = MiniCCUtil.readFile(iFile);
        
        DFA_STATE state = DFA_STATE.DFA_STATE_INITIAL;		//FA state
		String lexme 	= "";		//token lexme
		char c 			= ' ';		//next char
		boolean keep 	= false;	//keep current char
		boolean end 	= false;
		
		while(!end) {				//scanning loop
			if(!keep) {
				c = getNextChar();
				charnum = charnum + 1;
			}
		
			keep = false;

			switch(state) {
			case DFA_STATE_INITIAL:	
				lexme = "";
				if(isAlpha(c)) {
					state = DFA_STATE.DFA_STATE_ID;
					lexme = lexme + c;
				}else if(c == '\'') {
					state = DFA_STATE.DFA_STATE_CHR_0;
					lexme = lexme + c;
				}else if(c == '"') {
					state = DFA_STATE.DFA_STATE_STR_0;
					lexme = lexme + c;
				}else if(c == '0') {
					state = DFA_STATE.DFA_STATE_CON_0;
					lexme = lexme + c;
				}else if(isDigit(c) && c != '0') {
					state = DFA_STATE.DFA_STATE_CON_1;
					lexme = lexme + c;
				}else if(cSinglOp.indexOf(c) != -1) {
					lexme = lexme + c;
					strTokens += genToken(iTknNum, lexme, "'" + lexme + "'");
					iTknNum++;
					state = DFA_STATE.DFA_STATE_INITIAL;
				}else if(c == '+') {
					state = DFA_STATE.DFA_STATE_ADD_0;
					lexme = lexme + c;
				}else if(c == '-') {
					state = DFA_STATE.DFA_STATE_SUB_0;
					lexme = lexme + c;
				}else if(c == '*') {
					state = DFA_STATE.DFA_STATE_MUL_0;
					lexme = lexme + c;
				}else if(c == '/') {
					state = DFA_STATE.DFA_STATE_DIV_0;
					lexme = lexme + c;
				}else if(c == '%') {
					state = DFA_STATE.DFA_STATE_MOD_0;
					lexme = lexme + c;
				}else if(c == '<') {
					state = DFA_STATE.DFA_STATE_LEF_0;
					lexme = lexme + c;
				}else if(c == '>') {
					state = DFA_STATE.DFA_STATE_RIG_0;
					lexme = lexme + c;
				}else if(c == '=') {
					state = DFA_STATE.DFA_STATE_ASS_0;
					lexme = lexme + c;
				}else if(c == '!') {
					state = DFA_STATE.DFA_STATE_OPP_0;
					lexme = lexme + c;
				}else if(c == '&') {
					state = DFA_STATE.DFA_STATE_AND_0;
					lexme = lexme + c;
				}else if(c == '|') {
					state = DFA_STATE.DFA_STATE_OR_0;
					lexme = lexme + c;
				}else if(c == '^') {
					state = DFA_STATE.DFA_STATE_XOR_0;
					lexme = lexme + c;
				}else if(c == ':') {
					state = DFA_STATE.DFA_STATE_COL_0;
					lexme = lexme + c;
				}else if(c == '#') {
					state = DFA_STATE.DFA_STATE_POU_0;
					lexme = lexme + c;
				}else if(c == '.') {
					state = DFA_STATE.DFA_STATE_DOT_0;
					lexme = lexme + c;
				}else if(Character.isSpace(c)) {
					
				}else if(c == Character.MAX_VALUE) {
					cIndex = 5;
					strTokens += genToken(iTknNum, "<EOF>", "EOF");
					end = true;
				}
				break;
			case DFA_STATE_NOTE_1:
				if(cIndex == this.srcLines.get(lIndex).length()) {
					state = DFA_STATE.DFA_STATE_INITIAL;
				}
				break;
			case DFA_STATE_NOTE_2:
				if(c == '*') {
					state = DFA_STATE.DFA_STATE_INITIAL;
				}
				break;
			case DFA_STATE_ADD_0:
				if(c == '+') {
					strTokens += genToken(iTknNum, "++", "'++'");
					iTknNum++;
				}else if(c == '=') {
					strTokens += genToken(iTknNum, "+=", "'+='");
					iTknNum++;
				}else {
					strTokens += genToken2(iTknNum, "+", "'+'");
					iTknNum++;
					keep = true;
				}
				state = DFA_STATE.DFA_STATE_INITIAL;
				break;
			case DFA_STATE_SUB_0:
				if(c == '-') {
					strTokens += genToken(iTknNum, "--", "'--'");
					iTknNum++;
				}else if(c == '=') {
					strTokens += genToken(iTknNum, "-=", "'-='");
					iTknNum++;
				}else if(c == '>') {
					strTokens += genToken(iTknNum, "->", "'->'");
					iTknNum++;
				}else {
					strTokens += genToken2(iTknNum, "-", "'-'");
					iTknNum++;
					keep = true;
				}
				state = DFA_STATE.DFA_STATE_INITIAL;
				break;
			case DFA_STATE_MUL_0:
				if(c == '=') {
					strTokens += genToken(iTknNum, "*=", "'*='");
					iTknNum++;
				}else {
					strTokens += genToken2(iTknNum, "*", "'*'");
					iTknNum++;
					keep = true;
				}
				state = DFA_STATE.DFA_STATE_INITIAL;
				break;
			case DFA_STATE_DIV_0:
				if(c == '=') {
					strTokens += genToken(iTknNum, "/=", "'/='");
					iTknNum++;
					state = DFA_STATE.DFA_STATE_INITIAL;
				}else if(c == '/' && flagnote) {
					state = DFA_STATE.DFA_STATE_NOTE_1;
				}else if(c == '*' && flagnote) {
					state = DFA_STATE.DFA_STATE_NOTE_2;
				}else {
					strTokens += genToken2(iTknNum, "/", "'/'");
					iTknNum++;
					keep = true;
					state = DFA_STATE.DFA_STATE_INITIAL;
				}
				break;
			case DFA_STATE_MOD_0:
				if(c == '>') {
					strTokens += genToken(iTknNum, "%>", "'%>'");
					iTknNum++;
				}else if(c == '=') {
					strTokens += genToken(iTknNum, "%=", "'%='");
					iTknNum++;
				}else if(c == ':') {
					strTokens += genToken(iTknNum, "%:", "'%:'");
					iTknNum++;
				}else {
					strTokens += genToken2(iTknNum, "%", "'%'");
					iTknNum++;
					keep = true;
				}
				state = DFA_STATE.DFA_STATE_INITIAL;
				break;
			case DFA_STATE_LEF_0:
				if(c == '%') {
					strTokens += genToken(iTknNum, "<%", "'<%'");
					iTknNum++;
					state = DFA_STATE.DFA_STATE_INITIAL;
				}else if(c == '=') {
					strTokens += genToken(iTknNum, "<=", "'<='");
					iTknNum++;
					state = DFA_STATE.DFA_STATE_INITIAL;
				}else if(c == ':') {
					strTokens += genToken(iTknNum, "<:", "'<:'");
					iTknNum++;
					state = DFA_STATE.DFA_STATE_INITIAL;
				}else if(c == '<') {
					state = DFA_STATE.DFA_STATE_LEF_2;
				}else {
					strTokens += genToken2(iTknNum, "<", "'<'");
					iTknNum++;
					keep = true;
					state = DFA_STATE.DFA_STATE_INITIAL;
				}
				break;
			case DFA_STATE_LEF_2:
				if(c == '=') {
					strTokens += genToken(iTknNum, "<<=", "'<<='");
					iTknNum++;
				}else {
					strTokens += genToken2(iTknNum, "<<", "'<<'");
					iTknNum++;
					keep = true;
				}
				state = DFA_STATE.DFA_STATE_INITIAL;
				break;
			case DFA_STATE_RIG_0:
				if(c == '=') {
					strTokens += genToken(iTknNum, ">=", "'>='");
					iTknNum++;
					state = DFA_STATE.DFA_STATE_INITIAL;
				}else if(c == '>') {
					state = DFA_STATE.DFA_STATE_RIG_2;
				}else {
					strTokens += genToken2(iTknNum, ">", "'>'");
					iTknNum++;
					keep = true;
					state = DFA_STATE.DFA_STATE_INITIAL;
				}
				break;
			case DFA_STATE_RIG_2:
				if(c == '=') {
					strTokens += genToken(iTknNum, ">>=", "'>>='");
					iTknNum++;
				}else {
					strTokens += genToken2(iTknNum, ">>", "'>>'");
					iTknNum++;
					keep = true;
				}
				state = DFA_STATE.DFA_STATE_INITIAL;
				break;
			case DFA_STATE_ASS_0:
				if(c == '=') {
					strTokens += genToken(iTknNum, "==", "'=='");
					iTknNum++;
				}else {
					strTokens += genToken2(iTknNum, "=", "'='");
					iTknNum++;
					keep = true;
				}
				state = DFA_STATE.DFA_STATE_INITIAL;
				break;
			case DFA_STATE_OPP_0:
				if(c == '=') {
					strTokens += genToken(iTknNum, "!=", "'!='");
					iTknNum++;
				}else {
					strTokens += genToken2(iTknNum, "!", "'!'");
					iTknNum++;
					keep = true;
				}
				state = DFA_STATE.DFA_STATE_INITIAL;
				break;
			case DFA_STATE_AND_0:
				if(c == '&') {
					strTokens += genToken(iTknNum, "&&", "'&&'");
					iTknNum++;
				}else if(c == '=') {
					strTokens += genToken(iTknNum, "&=", "'&='");
					iTknNum++;
				}else {
					strTokens += genToken2(iTknNum, "&", "'&'");
					iTknNum++;
					keep = true;
				}
				state = DFA_STATE.DFA_STATE_INITIAL;
				break;
			case DFA_STATE_OR_0:
				if(c == '|') {
					strTokens += genToken(iTknNum, "||", "'||'");
					iTknNum++;
				}else if(c == '=') {
					strTokens += genToken(iTknNum, "|=", "'|='");
					iTknNum++;
				}else {
					strTokens += genToken2(iTknNum, "|", "'|'");
					iTknNum++;
					keep = true;
				}
				state = DFA_STATE.DFA_STATE_INITIAL;
				break;
			case DFA_STATE_XOR_0:
				if(c == '=') {
					strTokens += genToken(iTknNum, "^=", "'^='");
					iTknNum++;
				}else {
					strTokens += genToken2(iTknNum, "^", "'^'");
					iTknNum++;
					keep = true;
				}
				state = DFA_STATE.DFA_STATE_INITIAL;
				break;
			case DFA_STATE_COL_0:
				if(c == '>') {
					strTokens += genToken(iTknNum, ":>", "':>'");
					iTknNum++;
				}else {
					strTokens += genToken2(iTknNum, ":", "':'");
					iTknNum++;
					keep = true;
				}
				state = DFA_STATE.DFA_STATE_INITIAL;
				break;
			case DFA_STATE_POU_0:
				if(c == '#') {
					strTokens += genToken(iTknNum, "##", "'##'");
					iTknNum++;
				}else {
					strTokens += genToken2(iTknNum, "#", "'#'");
					iTknNum++;
					keep = true;
				}
				state = DFA_STATE.DFA_STATE_INITIAL;
				break;
			case DFA_STATE_DOT_0:
				if(c == '.') {
					state = DFA_STATE.DFA_STATE_DOT_1;
				}else {
					strTokens += genToken2(iTknNum, ".", "'.'");
					iTknNum++;
					keep = true;
					state = DFA_STATE.DFA_STATE_INITIAL;
				}
				break;
			case DFA_STATE_DOT_1:
				if(c == '.') {
					strTokens += genToken(iTknNum, "...", "'...'");
					iTknNum++;
				}
				state = DFA_STATE.DFA_STATE_INITIAL;
				break;
			case DFA_STATE_ID:
				if(isAlphaOrDigit(c)) {
					lexme = lexme + c;
				}else {
					if(this.charprefix.contains(lexme) && c == '\'') {
						lexme = lexme + c;
						state = DFA_STATE.DFA_STATE_CHR_0;
					}else if(this.Stringprefix.contains(lexme) && c == '\"') {
						lexme = lexme + c;
						state = DFA_STATE.DFA_STATE_STR_0;
					}else {
						if(this.keywordSet.contains(lexme)) {
							strTokens += genToken2(iTknNum, lexme, "'" + lexme + "'");
						}else {
							strTokens += genToken2(iTknNum, lexme, "Identifier");
						}
						iTknNum++;
						state = DFA_STATE.DFA_STATE_INITIAL;
						keep = true;
					}
					
				}
				break;
			case DFA_STATE_CHR_0:
				lexme = lexme + c;
				if(c == '\\') {
					state = DFA_STATE.DFA_STATE_CHR_1;
				}else if(c == '\'') {
					strTokens += genToken(iTknNum, lexme, "CharacterConstant");
					iTknNum++;
					state = DFA_STATE.DFA_STATE_INITIAL;
				}
				break;
			case DFA_STATE_CHR_1:
				if(this.cEscSequence.indexOf(c) != -1) {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CHR_0;
				}else if(isOctal(c)) {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CHR_0;
				}else if(c == 'x') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CHR_2;
				}else {
					state = DFA_STATE.DFA_STATE_CHR_ILL;
					keep = true;
				}
				break;
			case DFA_STATE_CHR_2:
				if(isHex(c)) {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CHR_0;
				}else {
					state = DFA_STATE.DFA_STATE_CHR_ILL;
					keep = true;
				}
				break;
			case DFA_STATE_CHR_ILL:
				lexme = lexme + c;
				if(c == '\'') {
					strTokens += genToken(iTknNum, lexme, "IllegalCharacter");
					iTknNum++;
					state = DFA_STATE.DFA_STATE_INITIAL;
				}
				break;
			case DFA_STATE_STR_0:
				lexme = lexme + c;
				if(c == '\\') {
					state = DFA_STATE.DFA_STATE_STR_1;
				}else if(c == '\"') {
					strTokens += genToken(iTknNum, lexme, "StringLiteral");
					iTknNum++;
					state = DFA_STATE.DFA_STATE_INITIAL;
				}
				break;
			case DFA_STATE_STR_1:
				if(this.cEscSequence.indexOf(c) != -1) {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_STR_0;
				}else if(isOctal(c)) {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_STR_0;
				}else if(c == 'x') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_STR_2;
				}else {
					state = DFA_STATE.DFA_STATE_STR_ILL;
					keep = true;
				}
				break;
			case DFA_STATE_STR_2:
				if(isHex(c)) {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_STR_0;
				}else {
					state = DFA_STATE.DFA_STATE_STR_ILL;
					keep = true;
				}
				break;
			case DFA_STATE_STR_ILL:
				lexme = lexme + c;
				if(c == '\"') {
					strTokens += genToken(iTknNum, lexme, "IllegalString");
					iTknNum++;
					state = DFA_STATE.DFA_STATE_INITIAL;
				}
				break;
			case DFA_STATE_CON_0:
				if(c == 'x' || c == 'X') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_4;
				}else if(isOctal(c)) {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_5;
				}else if(c == '.') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_2;
				}else if(c == 'e' || c == 'E') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_15;
				}else if(c == 'u' || c == 'U') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_9;
				}else if(c == 'l') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_7;
				}else if(c == 'L') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_12;
				}else {
					strTokens += genToken2(iTknNum, lexme, "IntegerConstant");
					iTknNum++;
					state = DFA_STATE.DFA_STATE_INITIAL;
					keep = true;
				}
				break;
			case DFA_STATE_CON_1:
				if(isDigit(c)) {
					lexme = lexme + c;
				}else if(c == '.') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_2;
				}else if(c == 'e' || c == 'E') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_15;
				}else if(c == 'u' || c == 'U') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_9;
				}else if(c == 'l') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_7;
				}else if(c == 'L') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_12;
				}else { 
					strTokens += genToken2(iTknNum, lexme, "IntegerConstant");
					iTknNum++;
					state = DFA_STATE.DFA_STATE_INITIAL;
					keep = true;					
				}
				break;	
			case DFA_STATE_CON_2:
				if(isDigit(c)) {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_3;
				}else {
					state = DFA_STATE.DFA_STATE_CON_ILL;
					keep = true;
				}
				break;
			case DFA_STATE_CON_3:
				if(isDigit(c)) {
					lexme = lexme + c;
				}else if(c == 'e' || c == 'E') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_15;
				}else if(c == 'f' || c == 'F' || c == 'l' || c == 'L') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_18;
				}else {
					strTokens += genToken2(iTknNum, lexme, "FloatingConstant");
					iTknNum++;
					state = DFA_STATE.DFA_STATE_INITIAL;
					keep = true;							
				}
				break;
			case DFA_STATE_CON_4:
				if(isHex(c)) {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_6;
				}else {
					state = DFA_STATE.DFA_STATE_CON_ILL;
					keep = true;
				}
				break;
			case DFA_STATE_CON_5:
				if(isOctal(c)) {
					lexme = lexme + c;
				}else if(c == 'u' || c == 'U') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_9;
				}else if(c == 'l') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_7;
				}else if(c == 'L') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_12;
				}else { 
					strTokens += genToken2(iTknNum, lexme, "IntegerConstant");
					iTknNum++;
					state = DFA_STATE.DFA_STATE_INITIAL;
					keep = true;					
				}
				break;
			case DFA_STATE_CON_6:
				if(isHex(c)) {
					lexme = lexme + c;
				}else if(c == 'u' || c == 'U') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_9;
				}else if(c == 'l') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_7;
				}else if(c == 'L') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_12;
				}else if(c == '.') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_19;
				}else if(c == 'p' || c == 'P') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_21;
				}else { 
					strTokens += genToken2(iTknNum, lexme, "IntegerConstant");
					iTknNum++;
					state = DFA_STATE.DFA_STATE_INITIAL;
					keep = true;					
				}
				break;
			case DFA_STATE_CON_7:
				if(c == 'l') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_8;
				}
				else if(c == 'u' || c == 'U') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_14;
				}
				else {
					strTokens += genToken2(iTknNum, lexme, "IntegerConstant");
					iTknNum++;
					state = DFA_STATE.DFA_STATE_INITIAL;
					keep = true;
				}
				break;
			case DFA_STATE_CON_8:
				if(c == 'u' || c == 'U') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_14;
				}else {
					strTokens += genToken2(iTknNum, lexme, "IntegerConstant");
					iTknNum++;
					state = DFA_STATE.DFA_STATE_INITIAL;
					keep = true;
				}
				break;
			case DFA_STATE_CON_9:
				if(c == 'l') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_10;
				}else if(c == 'L') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_11;
				}else {
					strTokens += genToken2(iTknNum, lexme, "IntegerConstant");
					iTknNum++;
					state = DFA_STATE.DFA_STATE_INITIAL;
					keep = true;
				}
				break;
			case DFA_STATE_CON_10:
				if(c == 'l') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_14;
				}else {
					strTokens += genToken2(iTknNum, lexme, "IntegerConstant");
					iTknNum++;
					state = DFA_STATE.DFA_STATE_INITIAL;
					keep = true;
				}
				break;
			case DFA_STATE_CON_11:
				if(c == 'L') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_14;
				}else {
					strTokens += genToken2(iTknNum, lexme, "IntegerConstant");
					iTknNum++;
					state = DFA_STATE.DFA_STATE_INITIAL;
					keep = true;
				}
				break;
			case DFA_STATE_CON_12:
				if(c == 'L') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_13;
				}
				else if(c == 'u' || c == 'U') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_14;
				}
				else {
					strTokens += genToken2(iTknNum, lexme, "IntegerConstant");
					iTknNum++;
					state = DFA_STATE.DFA_STATE_INITIAL;
					keep = true;
				}
				break;
			case DFA_STATE_CON_13:
				if(c == 'u' || c == 'U') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_14;
				}else {
					strTokens += genToken2(iTknNum, lexme, "IntegerConstant");
					iTknNum++;
					state = DFA_STATE.DFA_STATE_INITIAL;
					keep = true;
				}
				break;
			case DFA_STATE_CON_14:
				strTokens += genToken2(iTknNum, lexme, "IntegerConstant");
				iTknNum++;
				state = DFA_STATE.DFA_STATE_INITIAL;
				keep = true;
				break;
			case DFA_STATE_CON_15:
				if(c == '-' || c == '+') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_16;
				}else if(isDigit(c)) {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_17;
				}else {
					state = DFA_STATE.DFA_STATE_CON_ILL;
					keep = true;
				}
				break;
			case DFA_STATE_CON_16:
				if(isDigit(c)) {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_17;
				}else {
					state = DFA_STATE.DFA_STATE_CON_ILL;
					keep = true;
				}
				break;
			case DFA_STATE_CON_17:
				if(isDigit(c)) {
					lexme = lexme + c;
				}else if(c == 'f' || c == 'F' || c == 'l' || c == 'L') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_18;
				}else {
					strTokens += genToken2(iTknNum, lexme, "FloatingConstant");
					iTknNum++;
					state = DFA_STATE.DFA_STATE_INITIAL;
					keep = true;							
				}
				break;
			case DFA_STATE_CON_18:
				strTokens += genToken2(iTknNum, lexme, "FloatingConstant");
				iTknNum++;
				state = DFA_STATE.DFA_STATE_INITIAL;
				keep = true;							
				break;
			case DFA_STATE_CON_19:
				if(isHex(c)) {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_20;
				}else {
					state = DFA_STATE.DFA_STATE_CON_ILL;
					keep = true;
				}
				break;
			case DFA_STATE_CON_20:
				if(isHex(c)) {
					lexme = lexme + c;
				}else if(c == 'p' || c == 'P') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_21;
				}else if(c == 'f' || c == 'F' || c == 'l' || c == 'L') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_18;
				}else {
					strTokens += genToken2(iTknNum, lexme, "FloatingConstant");
					iTknNum++;
					state = DFA_STATE.DFA_STATE_INITIAL;
					keep = true;							
				}
				break;
			case DFA_STATE_CON_21:
				if(c == '-' || c == '+') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_22;
				}else if(isHex(c)) {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_23;
				}else {
					state = DFA_STATE.DFA_STATE_CON_ILL;
					keep = true;
				}
				break;
			case DFA_STATE_CON_22:
				if(isHex(c)) {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_23;
				}else {
					state = DFA_STATE.DFA_STATE_CON_ILL;
					keep = true;
				}
				break;
			case DFA_STATE_CON_23:
				if(isHex(c)) {
					lexme = lexme + c;
				}else if(c == 'f' || c == 'F' || c == 'l' || c == 'L') {
					lexme = lexme + c;
					state = DFA_STATE.DFA_STATE_CON_18;
				}else {
					strTokens += genToken2(iTknNum, lexme, "FloatingConstant");
					iTknNum++;
					state = DFA_STATE.DFA_STATE_INITIAL;
					keep = true;							
				}
				break;
			case DFA_STATE_CON_ILL:
				strTokens += genToken2(iTknNum, lexme, "IllegalConstant");
				iTknNum++;
				state = DFA_STATE.DFA_STATE_INITIAL;
				keep = true;
				break;
			default:
				System.out.println("[ERROR]Scanner:line " + lIndex + ", column=" + cIndex + ", unreachable state!");
				break;
			}
		}
		
	
		String oFile = MiniCCUtil.removeAllExt(iFile) + MiniCCCfg.MINICC_SCANNER_OUTPUT_EXT;
		MiniCCUtil.createAndWriteFile(oFile, strTokens);
		
		return oFile;
	}

}
