
public class CeilingFanOffCommand implements Command {
	CeilingFan ceilingFan;
	FanState prevSpeed;
  
	public CeilingFanOffCommand(CeilingFan ceilingFan) {
		this.ceilingFan = ceilingFan;
	}
 
	public void execute() {
		prevSpeed = ceilingFan.getSpeed();
		ceilingFan.setSpeed(new FanOffState());
	}
 
	public void undo() {
		ceilingFan.setSpeed(prevSpeed);
	}

	public String toString()
	{
		return "FanOffCommand";
	}
}
