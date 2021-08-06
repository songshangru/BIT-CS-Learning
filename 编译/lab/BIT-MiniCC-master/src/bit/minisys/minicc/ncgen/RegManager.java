package bit.minisys.minicc.ncgen;
import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.LinkedList;

public class RegManager {
	List<Reg> regs = new LinkedList<Reg>();
	Map<Integer,Boolean> used = new HashMap<Integer, Boolean>();
	int ptr=8;
	
	RegManager(){
		for(int i=0;i<32;i++) {
			regs.add(new Reg(i));
		}
		for(int i=8;i<=15;i++) {
			used.put(i, false);
		}
	}
	
	Reg getReg(int i) {
		if(i >= 8 && i <=15) {
			used.put(i, true);
		}
		return (Reg)regs.get(i);
	}
	
	Reg getRegt1() {
		return regs.get(24);
	}
	
	Reg getRegt2() {
		return regs.get(25);
	}
	
	Reg getRegArg(int i) {
		if(i>=0&&i<4) {
			return regs.get(i+4);
		}
		return null;
	}
	

	
	Reg getAvailReg() {
		for(int i=8;i<=15;i++) {
			Reg reg = regs.get(i);
			if(reg.var == null) {
				reg = getReg(i);
				return reg;
			}
		}
		return null;
	}
	
	void freeAllReg() {
		for(int i=8;i<=15;i++) {
			if(regs.get(i).var!=null) {
				regs.get(i).var.savetomem();
			}
		}
	}
	
	int getNRUReg() {
		while(used.get(ptr)) {
			used.put(ptr, false);
			incPtr();
		}
		int res = ptr;
		incPtr();
		return res;
	}
	
	void incPtr() {
		ptr = (ptr-7)%8+8;
	}
	
}

class Reg{
	int ID;
	Sunit var = null;
	Reg(int i){
		ID = i;
	}
}
