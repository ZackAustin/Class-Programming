
public class CeilingFanCycleCommand implements Command {
	CeilingFan ceilingFan;
	FanState prevSpeed;
  
	public CeilingFanCycleCommand(CeilingFan ceilingFan) {
		this.ceilingFan = ceilingFan;
	}
 
	public void execute() {
		prevSpeed = ceilingFan.getSpeed();
		System.out.println("Cycling from " + prevSpeed + " to " + prevSpeed.nextState());
		ceilingFan.setSpeed(prevSpeed.nextState());
	}
 
	public void undo() {
		ceilingFan.setSpeed(prevSpeed);
	}

	public String toString()
	{
		return "FanCycleCommand";
	}
}
