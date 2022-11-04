package bit.minisys.minicc.simulator;

public class RISCVSimulator implements IMiniCCSimulator {

	@Override
	public void run(String input) throws Exception {
		
		if(input == null) {
			String[] args = new String[0];
			new rars.MarsLaunch(args);
			return;
		}
		
		String[] args = new String[1];
		args[0] = input;
		new rars.MarsLaunch(args);
		
		System.out.println("8. Simulate not finished!");
	}

}
