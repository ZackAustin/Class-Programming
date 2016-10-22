
public class CeilingFanLowCommand implements Command {
	CeilingFan ceilingFan;
	FanState prevSpeed;
  
	public CeilingFanLowCommand(CeilingFan ceilingFan) {
		this.ceilingFan = ceilingFan;
	}
 
	public void execute() {
		prevSpeed = ceilingFan.getSpeed();
		ceilingFan.setSpeed(new FanLowState());
	}
 
	public void undo() {
		ceilingFan.setSpeed(prevSpeed);
	}

	public String toString()
	{
		return "FanLowCommand";
	}
}
