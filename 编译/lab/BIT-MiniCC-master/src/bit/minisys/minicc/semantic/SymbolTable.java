package bit.minisys.minicc.semantic;
import bit.minisys.minicc.parser.ast.*;

import java.util.List;
import java.util.LinkedList;
import java.util.Map;
import java.util.LinkedHashMap;

public class SymbolTable {
	public SymbolTable father;
	public Map items = new LinkedHashMap<>();
	public LinkedList index = new LinkedList();
	
	public void addvar(String name, String type){
		var_item i = new var_item();
		i.name = name;
		i.type = type;
		i.arr_limit = null;
		items.put(name, i);
		index.add(name);
	}
	
	public void addvar(String name, String type, LinkedList limit){
		var_item i = new var_item();
		i.name = name;
		i.type = type;
		i.arr_limit = limit;
		items.put(name, i);
		index.add(name);
	}
	
	public void addfunc(String name, String type, LinkedList args) {
		func_item i = new func_item();
		i.name = name;
		i.type = type;
		i.returnflag = false;
		i.args = new LinkedList();
		i.args = args;
		items.put(name, i);
	}
	
	public boolean find_cur(String name) {
		return this.items.containsKey(name);
		
	}
	
	public boolean find(String name) {
		if(this.items.containsKey(name) == true)
			return true;
		else {
			if(this.father==null)
				return false;
			else
				return father.find(name);
		}
	}
	
	public String get_var_type(String name) {
		if(items.containsKey(name)==true) {
			return (String) ((var_item) this.items.get(name)).type;
		}else {
			if(this.father==null)
				return null;
			else
				return father.get_var_type(name);
		}
	}
	
	public LinkedList get_arr_limit(String name) {
		if(items.containsKey(name)==true) {
			return (LinkedList) ((var_item) this.items.get(name)).arr_limit;
		}else {
			if(this.father==null)
				return null;
			else
				return father.get_arr_limit(name);
		}
	}
	
	public LinkedList get_func_arg(String name) {
		if(items.containsKey(name)==true) {
			return (LinkedList) ((func_item) this.items.get(name)).args;
		}
		return null;
	}
	
	public String get_func_type(String name) {
		if(items.containsKey(name)==true) {
			return (String) ((func_item) this.items.get(name)).type;
		}
		return null;
	}
	
}

class var_item{
	public String name;
	public String type;
	public List arr_limit = new LinkedList();
}

class func_item{
	public String name;
	public String type;
	public boolean returnflag;
	public List args = new LinkedList();
}
