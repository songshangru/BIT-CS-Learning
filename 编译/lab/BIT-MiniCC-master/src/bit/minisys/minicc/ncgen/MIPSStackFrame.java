package bit.minisys.minicc.ncgen;
import java.util.List;
import java.util.LinkedList;
import java.util.HashMap;
import java.util.Map;

public class MIPSStackFrame {
	public List<Sunit> sargs = new LinkedList<Sunit>();
	private Sunit retaddr;
	public List<Sunit> svars = new LinkedList<Sunit>();
	private SymbolMap smap = new SymbolMap();
	public int size;
	
	MIPSStackFrame(LinkedList<MyQuat> funcqs,RegManager regman){
		size = 0;
		retaddr = new Sunit("@ret");
		int indexarg=0;
		for(MyQuat q:funcqs) {
			if(q.getOp().equals("Func_Beg")) {
				
			}else if(q.getOp().equals("param")) {
				Sunit arg = new Sunit(q.getRes());
				Reg areg = regman.getRegArg(indexarg);
				areg.var = arg;
				arg.inreg = true;
				arg.areg = areg;
				indexarg++;
				sargs.add(arg);
				smap.sym2svar.put(q.getRes(), arg);
			}else if(q.getOp().equals("var")) {
				if(this.getVar(q.getRes())!=null){
					continue;
				}
				Sunit var = new Sunit(q.getRes());
				svars.add(var);
				smap.sym2svar.put(q.getRes(), var);
			}else if(q.getOp().equals("arr")) {
				if(this.getVar(q.getRes())!=null){
					continue;
				}
				String name = q.getRes();
				String[] segs = q.getOpnd1().split("<");
				int limit = Integer.parseInt(segs[1].substring(0,segs[1].length()-1));
				if(segs.length == 3) {
					limit = limit * Integer.parseInt(segs[2].substring(0,segs[2].length()-1));
				}
				for(int i=0;i<limit;i++) {
					Sunit a = new Sunit(q.getRes(),i);
					if(i==0) {
						smap.sym2svar.put(name, a);
					}
					svars.add(a);
				}
			}
		}
		for(int i=svars.size()-1;i>=0;i--) {
			Sunit var=svars.get(i);
			smap.svar2off.put(var, size);
			size += 4;
		}
		smap.svar2off.put(retaddr, size);
		size += 4;
		for(int i=sargs.size()-1;i>=0;i--) {
			Sunit arg=sargs.get(i);
			smap.svar2off.put(arg, size);
			size += 4;
		}
	}
	
	//public int getArrOffset(Sunit var,int )
	
	public int getOffset(Sunit var) {
		return smap.svar2off.get(var);
	}
	
	public Sunit getVar(String s) {
		return smap.sym2svar.get(s);
	}
	
	public int getOffset(String s) {
		if(getVar(s) == null)
			return -1;
		else
			return getOffset(getVar(s));
	}
	
	public int getRetOffset() {
		return smap.svar2off.get(retaddr);
	}
	
	
}




