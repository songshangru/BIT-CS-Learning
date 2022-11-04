package bit.minisys.minicc.ncgen;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import bit.minisys.minicc.MiniCCCfg;
import bit.minisys.minicc.icgen.internal.IRBuilder;
import bit.minisys.minicc.icgen.internal.MiniCCICGen;
import bit.minisys.minicc.internal.util.MiniCCUtil;
import bit.minisys.minicc.ncgen.IMiniCCCodeGen;


public class MyCodeGen implements IMiniCCCodeGen{

	private CodeData cdata = new CodeData();
	private CodeText ctext = new CodeText();
	private String allcode;
	private List<MyQuat> quats;
	public int index_quat;
	public int tmplabelID;
	public MIPSStackFrame curframe;
	public RegManager regman = new RegManager();

	public MyCodeGen() {
		index_quat = 0;
		tmplabelID = 0;
	}
	
	@Override
	public String run(String iFile, MiniCCCfg cfg) throws Exception {
		String oFile = MiniCCUtil.remove2Ext(iFile) + MiniCCCfg.MINICC_CODEGEN_OUTPUT_EXT;

		if(!cfg.target.equals("mips")) {
			return oFile;
		}
		LoadIC(iFile);
		GenCode();

		System.out.println("7. Target code generation finished!");
		
		allcode = cdata.c + ctext.t;
		
		MiniCCUtil.createAndWriteFile(oFile, allcode);
		return oFile;
	}
	
	public MyQuat NextQuat() {
		if(index_quat<quats.size()) {
			MyQuat q = quats.get(index_quat);
			index_quat++;
			return q;
		}else{
			return null;
		}
		
	}
	
	public void LoadIC(String tFile) {
		quats = new LinkedList<MyQuat>();
		ArrayList<String> qStr = MiniCCUtil.readFile(tFile);
		for(String str: qStr) {
			if(str.trim().length() <= 0) {
				continue;
			}
			String res,op,opnd1,opnd2;
			String[] segs = str.split(",");
			op = segs[0].substring(1,segs[0].length());
			res = segs[3].substring(0,segs[3].length()-1);
			opnd1 = segs[1];
			opnd2 = segs[2];
			MyQuat q = new MyQuat(op,res,opnd1,opnd2);
			quats.add(q);
		}
	}
	
	String GenTmpLabel() {
		tmplabelID++;
		String label = "_tmplabel_" + tmplabelID++;
		return label;
	}
	
	private void GenCode() {
		MyQuat q = NextQuat();
		
		while(q != null) {
			if(q.getOp().equals("Func_Beg")) {
				GenCodeFunc(q);
			}
			q = NextQuat();
		}
	}
	
	private void GenCodeFunc(MyQuat qfunc) {
		ctext.AddLabel(qfunc.getRes());
		LinkedList<MyQuat> funcqs = new LinkedList<MyQuat>();
		funcqs.add(qfunc);
		MyQuat q = NextQuat();
		
		while(q.getOp().equals("param")||
			  q.getOp().equals("var")||
			  q.getOp().equals("arr")) {
			funcqs.add(q);
			q = NextQuat();
		}
		
		int tmpindexq = index_quat-1;
		
		while(q.getOp().equals("Func_End") == false) {
			//System.out.println(q.getOp()+","+q.getOpnd1());
			if(q.getOp().equals("var")){
				funcqs.add(q);
			}
			q = NextQuat();
		}
		index_quat = tmpindexq;
		q = NextQuat();
		
		curframe = new MIPSStackFrame(funcqs,regman);
		regman.freeAllReg();
		ctext.AddCode("subu $sp, $sp, " + curframe.size);
		while(q.getOp().equals("Func_End") == false) {
			//System.out.println(q.getOp()+","+q.getOpnd1());
			GenCodeOp(q);
			q = NextQuat();
		}
	}
	
	
	private void GenCodeOp(MyQuat q) {
		String op = q.getOp();
		//System.out.println(op+","+q.getOpnd1()+","+q.getOpnd2()+","+q.getRes());
		if(op.equals("label")) {
			SaveRegs();
			String label = q.getRes().substring(1,q.getRes().length());
			ctext.AddLabel(label);
		}else if(op.equals("j")) {
			SaveRegs();
			String label=q.getRes();
			ctext.AddCode("j "+label.substring(1,label.length()));
		}else if(op.equals("jf")) {
			SaveRegs();
			String label=q.getRes();
			String sym = q.getOpnd1();
			Sunit var = curframe.getVar(sym);
			Reg reg1 = getNewReg(var);
			Reg reg2 = regman.getRegt2();
			ctext.AddCode("li $" + reg2.ID + ", 0");
            ctext.AddCode("beq $" + reg1.ID + ", $" + reg2.ID + ", " + label.substring(1,label.length()));
		}else if(op.equals("ret")) {
			if(!q.getRes().equals("")) {
				Sunit var = curframe.getVar(q.getRes());
				if(var == null) {
					int con = Integer.parseInt(q.getRes());
					ctext.AddCode("li $v0, " + con);
				}else {
					Reg reg = getNewReg(var);
					ctext.AddCode("move $v0, $" + reg.ID);
				}
			}
			
			ctext.AddCode("addu $sp, $sp, " + curframe.size);
			ctext.AddCode("jr $ra");
		}else if(op.equals("arg")||op.equals("call")) {
			LinkedList<String> args = new LinkedList<String>();
			if(op.equals("arg")) {
				while(q.getOp().equals("arg")) {
					args.add(q.getRes());
					q = NextQuat();
				}
			}
			//call
			SaveRegs();
			for(int i=args.size()-1;i>=0;i--) {
				String sym = args.get(i);
				Reg srcreg;
				if(curframe.getVar(sym)==null) {
					//
					srcreg = regman.getRegt1();
					if(sym.charAt(0)=='"') {
						String label = cdata.AddString(sym);
						ctext.AddCode("la $" + srcreg.ID + ", " + label);
					}else {
						int con=Integer.parseInt(sym);
						srcreg = regman.getRegt1();
						ctext.AddCode("li $" + srcreg.ID + ", " + con);
					}
				}else {
					Sunit var = curframe.getVar(sym);
					srcreg = getNewReg(var);
				}
				int pos = args.size()-1-i;
				if(pos<4) {
					Reg tarreg = regman.getRegArg(i);
					ctext.AddCode("move $" + tarreg.ID + ", $" + srcreg.ID);
				}
			}
			ctext.AddCode("sw $ra, " + curframe.getRetOffset() + "($sp)");
			ctext.AddCode("jal " + q.getOpnd1());
			ctext.AddCode("lw $ra, " + curframe.getRetOffset() + "($sp)");
			//System.out.println(curframe.svars.size()+","+q.getOp()+","+q.getRes());
			Sunit var = curframe.getVar(q.getRes());
			if(var != null) {
				Reg reg = getOldReg(var);
				ctext.AddCode("move $" + reg.ID + ", $v0");
				var.inreg = true;
			}
		}else if(op.equals("=")||
		   op.equals("+=")||
		   op.equals("-=")||
		   op.equals("*=")||
		   op.equals("/=")||
		   op.equals("%=")) {
			//目前仅处理了=
			String symsrc = q.getOpnd1();
			String symtar = q.getRes();
			Sunit vartar = curframe.getVar(symtar);
			Reg regtar = getOldReg(vartar);
			if(curframe.getVar(symsrc)==null) {
				int con = Integer.parseInt(symsrc);
				ctext.AddCode("li $" + regtar.ID + ", " + con);
			}else {
				Sunit varsrc = curframe.getVar(symsrc);
				Reg regsrc = getNewReg(varsrc);
				ctext.AddCode("move $" + regtar.ID + ", $" + regsrc.ID);
			}
			vartar.inreg = true;
		}else if(op.equals("+")||
				 op.equals("-")||
				 op.equals("*")||
				 op.equals("/")||
				 op.equals("%")||
				 op.equals("==")||
				 op.equals("<")||
				 op.equals(">")||
				 op.equals("<=")||
				 op.equals(">=")||
				 op.equals("&&")||
				 op.equals("||")) {
			String sym1=q.getOpnd1(),sym2=q.getOpnd2(),symtar=q.getRes();
			//System.out.println(op+"," +symtar);
			Sunit var1,var2,vartar=curframe.getVar(symtar);
			Reg reg1,reg2,regtar=getNewReg(vartar);
			if(curframe.getVar(sym1)==null) {
				int con = Integer.parseInt(sym1);
				reg1 = regman.getRegt1();
				ctext.AddCode("li $" + reg1.ID + ", " + con);
			}else {
				var1 = curframe.getVar(sym1);
				reg1 = getNewReg(var1);
			}
			if(curframe.getVar(sym2)==null) {
				int con = Integer.parseInt(sym2);
				reg2 = regman.getRegt2();
				ctext.AddCode("li $" + reg2.ID + ", " + con);
			}else {
				var2 = curframe.getVar(sym2);
				reg2 = getNewReg(var2);				
			}
			if(op.equals("+")) {
				ctext.AddCode("add $"+regtar.ID+", $" + reg1.ID + ", $" + reg2.ID);
			}else if(op.equals("-")) {
				ctext.AddCode("sub $"+regtar.ID+", $" + reg1.ID + ", $" + reg2.ID);
			}else if(op.equals("*")) {
				ctext.AddCode("mul $"+regtar.ID+", $" + reg1.ID + ", $" + reg2.ID);
			}else if(op.equals("&&")) {
				ctext.AddCode("and $"+regtar.ID+", $" + reg1.ID + ", $" + reg2.ID);
			}else if(op.equals("||")) {
				ctext.AddCode("or $"+regtar.ID+", $" + reg1.ID + ", $" + reg2.ID);
			}else if(op.equals("/")) {
				ctext.AddCode("div $"+ reg1.ID + ", $" + reg2.ID);
				ctext.AddCode("mflo $"+regtar.ID);
			}else if(op.equals("%")) {
				ctext.AddCode("div $"+ reg1.ID + ", $" + reg2.ID);
				ctext.AddCode("mfhi $"+regtar.ID);
			}else {
				String tmpl1 = GenTmpLabel();
				String tmpl2 = GenTmpLabel();
				if(op.equals("==")) {
					ctext.AddCode("beq $"+reg1.ID+", $" + reg2.ID + ", " + tmpl1);
				}else if(op.equals("<")) {
					ctext.AddCode("blt $"+reg1.ID+", $" + reg2.ID + ", " + tmpl1);
				}else if(op.equals(">")) {
					ctext.AddCode("bgt $"+reg1.ID+", $" + reg2.ID + ", " + tmpl1);
				}else if(op.equals("<=")) {
					ctext.AddCode("ble $"+reg1.ID+", $" + reg2.ID + ", " + tmpl1);
				}else if(op.equals(">=")) {
					ctext.AddCode("bge $"+reg1.ID+", $" + reg2.ID + ", " + tmpl1);
				}
				ctext.AddCode("li $" + regtar.ID + ", 0");
				ctext.AddCode("b " + tmpl2);
				ctext.AddLabel(tmpl1);
				ctext.AddCode("li $" + regtar.ID + ", 1");
				ctext.AddLabel(tmpl2);
				
			}
			vartar.inreg = true;
		
		}else if(op.equals("++")) {
			String symtar=q.getRes();
			Sunit vartar=curframe.getVar(symtar);
			Reg regtar=getNewReg(vartar);
			ctext.AddCode("addi $"+regtar.ID+", $" + regtar.ID + ", 1");
			vartar.inreg = true;
		}else if(op.equals("=[]")) {
			String symoff = q.getOpnd1(),symarr = q.getOpnd2(),symtar = q.getRes();
			
			Sunit varoff = curframe.getVar(symoff);
			Sunit vararr = curframe.getVar(symarr);
			Sunit vartar = curframe.getVar(symtar);
			Reg t1 = regman.getRegt1(),t2=regman.getRegt2(),regoff = getNewReg(varoff);
			Reg regtar = getNewReg(vartar);
			ctext.AddCode("move $"+t2.ID+ ", $"+regoff.ID );
			ctext.AddCode("li $"+t1.ID+", 4");
			ctext.AddCode("mul $"+t2.ID+" , $"+t2.ID+" , $"+t1.ID);
			ctext.AddCode("sub $"+t1.ID+", $sp"+", $"+t2.ID);
			ctext.AddCode("addi $"+t1.ID+", $"+t1.ID+" , "+curframe.getOffset(vararr));
			ctext.AddCode("lw $"+t2.ID+", "+"($24)");

			
			ctext.AddCode("move $"+regtar.ID + ", $"+t2.ID);
			regtar.var.inreg=true;
		}else if(op.equals("[]=")) {
			String symoff = q.getOpnd2(),symarr = q.getRes(),symsrc = q.getOpnd1();
			Sunit varoff = curframe.getVar(symoff);
			Sunit vararr = curframe.getVar(symarr);
			Sunit varsrc = curframe.getVar(symsrc);
			Reg t1 = regman.getRegt1(),t2=regman.getRegt2(),regoff = getNewReg(varoff);
			Reg regsrc = getNewReg(varsrc);
			ctext.AddCode("move $"+t2.ID+ ", $"+regoff.ID );
			ctext.AddCode("li $"+t1.ID+", 4");
			ctext.AddCode("mul $"+t2.ID+" , $"+t2.ID+" , $"+t1.ID);
			ctext.AddCode("sub $"+t1.ID+", $sp"+", $"+t2.ID);
			ctext.AddCode("addi $"+t1.ID+", $"+t1.ID+" , "+curframe.getOffset(vararr));
			
			ctext.AddCode("sw $" + regsrc.ID + ", " + "($24)");
			
		}
	}
	
	Reg getNewReg(Sunit var) {
		if(var.inreg) {
			Reg reg = var.areg;
			regman.getReg(reg.ID);
			return reg;
		}
		Reg reg=regman.getAvailReg();
		if(reg==null) {
			int id=regman.getNRUReg();
			reg=regman.getReg(id);
			Sunit vartosave = reg.var;
			//System.out.println(vartosave.symbol);
			if(vartosave.inreg)
				ctext.AddCode("sw $" + id + ", " + curframe.getOffset(vartosave) + "($sp)");
			vartosave.savetomem();
			
			reg.var = var;
			var.inreg=true;
			var.areg = reg;
			ctext.AddCode("lw $" + reg.ID + ", " + curframe.getOffset(var) + "($sp)");
			return reg;
		}else {
			reg.var = var;
			var.areg = reg;
			var.inreg = true;
			ctext.AddCode("lw $" + reg.ID + ", " + curframe.getOffset(var) + "($sp)");
			return reg;
		}
	}
	
	Reg getOldReg(Sunit var) {
		if(var.inreg) {
			Reg reg = var.areg;
			regman.getReg(reg.ID);
			return reg;
		}
		Reg reg=regman.getAvailReg();
		if(reg==null) {
			int id=regman.getNRUReg();
			reg=regman.getReg(id);
			Sunit vartosave = reg.var;
			//System.out.println(vartosave.symbol+","+vartosave.inreg);
			if(vartosave.inreg) {
				ctext.AddCode("sw $" + id + ", " + curframe.getOffset(vartosave) + "($sp)");
			}
			vartosave.savetomem();
			
			reg.var = var;
			var.inreg=true;
			var.areg = reg;
			return reg;
		}else {
			reg.var = var;
			var.areg = reg;
			var.inreg = true;
			return reg;
		}
	}
	
	void SaveRegs() {
		for(int i=4;i<=15;i++) {
			Reg reg = regman.regs.get(i);
			Sunit var = reg.var;
			if(var==null)
				continue;
			if(var.inreg==true) {
				ctext.AddCode("sw $" + i + ", " + curframe.getOffset(var) + "($sp)");
			}
			var.savetomem();
		}
	}
	
}

class CodeData{
	int num;
	String c = ".data\n"
			+ "blank : .asciiz \" \"" + "\n";
	CodeData(){
		num = 0;
	}
	String AddString(String s) {
		num++;
		String tag = "_" + num + "sc";
		String str=tag + " :";
		str += " .asciiz ";
		str += s;
		str += "\n";
		c += str;
		return tag;
	}
}

class CodeText{
	String t = ".text\n"
			+ "__init:\n"
			+ "	lui $sp, 0x8000\n"
			+ "	addi $sp, $sp, 0x0000\n"
			+ "	move $fp, $sp\n"
			+ "	add $gp, $gp, 0x8000\n"
			+ "	jal main\n"
			+ "	li $v0, 10\n"
			+ "	syscall\n"
			+ "Mars_PrintInt:\n"
			+ "	li $v0, 1\n"
			+ "	syscall\n"
			+ "	li $v0, 4\n"
			+ "	move $v1, $a0\n"
			+ "	la $a0, blank\n"
			+ "	syscall\n"
			+ "	move $a0, $v1\n"
			+ "	jr $ra\n"
			+ "Mars_GetInt:\n"
			+ "	li $v0, 5\n"
			+ "	syscall\n"
			+ "	jr $ra\n"
			+ "Mars_PrintStr:\n"
			+ "	li $v0, 4\n"
			+ "	syscall\n"
			+ "	jr $ra\n";
	CodeText(){
		
	}
	String AddLabel(String s) {
		String tag = s;
		tag += ":\n";
		t += tag;
		return tag;
	}
	
	String AddCode(String s) {
		String code = "\t" + s + "\n";
		t += code;
		return code;
	}
	
}
