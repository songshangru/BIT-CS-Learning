package bit.minisys.minicc.simulator;

public class MIPSSimulator implements IMiniCCSimulator {
	public void run(String iFile){
		System.out.println("8. Simulating");
		
		if(iFile == null) {
			String[] args = new String[0];
			new mars.MarsLaunch(args);
			return;
		}
		
		/**
		 * 手动创建一个String[] args，初始化为空
		 * 为了适应mars.MarsLaunch(String[] args)的构造函数
		 * */
		String [] args = new String[1];
		args[0] = iFile;
		new mars.MarsLaunch(args);
		
		/**
		 * 调用时出现了一个权限问题：java.util.prefs.WindowsPreferences <init>
         * WARNING: Could not open/create prefs root node Software\JavaSoft\Prefs 
         * at root 0x80000002. Windows RegCreateKeyEx(...) returned error code 5.
         * 修改注册表权限即可
         * 1. Go into your Start Menu and type regedit into the search field.
		 * 2. Navigate to path HKEY_LOCAL_MACHINE\Software\JavaSoft
		 * 3. Right click on the JavaSoft folder and click on New -> Key
		 * 4. Name the new Key Prefs and everything should work.
		 * 
		 * Alternatively, save and execute a *.reg file with the following content:
		 * “Windows Registry Editor Version 5.00
		 * [HKEY_LOCAL_MACHINE\Software\JavaSoft\Prefs]”
		 * */
		System.out.println("8. Simulate not finished!");
	}
}
