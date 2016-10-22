
public class CeilingFanMediumCommand implements Command {
	CeilingFan ceilingFan;
	FanState prevSpeed;
  
	public CeilingFanMediumCommand(CeilingFan ceilingFan) {
		this.ceilingFan = ceilingFan;
	}
 
	public void execute() {
		prevSpeed = ceilingFan.getSpeed();
		ceilingFan.setSpeed(new FanMediumState());
	}
 
	public void undo() {
		ceilingFan.setSpeed(prevSpeed);
	}

	public String toString()
	{
		return "FanMediumCommand";
	}
}
