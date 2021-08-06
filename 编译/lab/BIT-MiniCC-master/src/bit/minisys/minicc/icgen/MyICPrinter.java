package bit.minisys.minicc.icgen;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import bit.minisys.minicc.parser.ast.*;
import bit.minisys.minicc.semantic.SymbolTable;


public class MyICPrinter {
	private  List<Quat> quats;
	private  Map<String,SymbolTable> functable;
	private  Map<String,SymbolTable> subscopetable;
	public MyICPrinter(List<Quat> quats,Map<String,SymbolTable> functable,Map<String,SymbolTable> subscopetable) {
		this.quats = quats;
		this.functable = functable;
		this.subscopetable = subscopetable;
	}
	public void print(String filename) {
		StringBuilder sb = new StringBuilder();
		for (Quat quat : quats) {
			String op = quat.getOp();
			if(op.equals("Func_Beg")||op.equals("Scope_Beg")) {
				String res = astStr(quat.getRes());
				String opnd1 = astStr(quat.getOpnd1());
				String opnd2;
				int pcnt;
				SymbolTable table;
				if(op.equals("Func_Beg")) {
					pcnt = ((ASTFunctionDeclarator)quat.getRes()).params.size();
					opnd2 = ""+pcnt;
					table = functable.get(res);
				}else {
					pcnt = -1;
					opnd2 = "";
					table = subscopetable.get(res);
				}
				sb.append("("+op+","+ opnd1+","+opnd2 +"," + res+")\n");
				String scopename = res;
				for(int i=0;i<table.items.size();i++) {
					res = (String)table.index.get(i);
					if(i<pcnt) {
						op = "param";
						opnd1 = table.get_var_type(res);
						opnd2 = "";
					}else {
						if(table.get_arr_limit(res)==null) {
							opnd1 = table.get_var_type(res);
							op = "var";
						}else {
							opnd1 = table.get_var_type(res);
							op = "arr";
							opnd2 = "";
							LinkedList limit = table.get_arr_limit(res);
							for(int j=0;j<limit.size();j++) {
								opnd1 += "<" + limit.get(j) + ">";
							}
						}
					}
					opnd2 = scopename;
					sb.append("("+op+","+ opnd1+","+opnd2 +"," + res+")\n");

				}
			}else {
				String res = astStr(quat.getRes());
				String opnd1 = astStr(quat.getOpnd1());
				String opnd2 = astStr(quat.getOpnd2());
				sb.append("("+op+","+ opnd1+","+opnd2 +"," + res+")\n");
			}
			
		}
		// write
		try {
			FileWriter fileWriter = new FileWriter(new File(filename));
			fileWriter.write(sb.toString());
			fileWriter.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	private String astStr(ASTNode node) {
		if (node == null) {
			return "";
		}else if (node instanceof ASTIdentifier) {
			return ((ASTIdentifier)node).value;
		}else if (node instanceof ASTIntegerConstant) {
			return ((ASTIntegerConstant)node).value+"";
		}else if (node instanceof ASTFloatConstant) {
			return ((ASTFloatConstant)node).value+"";
		}else if (node instanceof ASTCharConstant) {
			return   ((ASTCharConstant)node).value  ;
		}else if (node instanceof ASTStringConstant) {
			return ((ASTStringConstant)node).value  ;
		}else if (node instanceof TemporaryValue) {
			return ((TemporaryValue)node).name();
		}else if (node instanceof ControlLabel) {
			return ((ControlLabel)node).name;
		}else if (node instanceof ASTVariableDeclarator) {
			return ((ASTVariableDeclarator)node).getName();
		}else if (node instanceof ASTFunctionDeclarator) {
			return ((ASTFunctionDeclarator)node).getName();
		}else if (node instanceof ASTToken) {
			if(((ASTToken)node).value.equals("int")) {
				return "int";
			}else if(((ASTToken)node).value.equals("void")) {
				return "void";
			}else if(((ASTToken)node).value.equals("float")) {
				return "float";
			}else if(((ASTToken)node).value.equals("char")) {
				return "char";
			}
			else return "";
		}else {
			return "";
		}
	}
}
