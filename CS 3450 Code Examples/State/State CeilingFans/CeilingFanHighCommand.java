
public class CeilingFanHighCommand implements Command {
	CeilingFan ceilingFan;
	FanState prevSpeed;
  
	public CeilingFanHighCommand(CeilingFan ceilingFan) {
		this.ceilingFan = ceilingFan;
	}
 
	public void execute() {
		prevSpeed = ceilingFan.getSpeed();
		ceilingFan.setSpeed(new FanHighState());
	}
 
	public void undo() {
		ceilingFan.setSpeed(prevSpeed);
	}

	public String toString()
	{
		return "FanHighCommand";
	}
}
