
public class CeilingFanCycleCommand implements Command {
	CeilingFan ceilingFan;
	int prevSpeed;
  
	public CeilingFanCycleCommand(CeilingFan ceilingFan) {
		this.ceilingFan = ceilingFan;
	}
 
	public void execute() {
		prevSpeed = ceilingFan.getSpeed();
		if (prevSpeed == CeilingFan.HIGH) {
			ceilingFan.medium();
		} else if (prevSpeed == CeilingFan.MEDIUM) {
			ceilingFan.low();
		} else if (prevSpeed == CeilingFan.LOW) {
			ceilingFan.off();
		} else if (prevSpeed == CeilingFan.OFF) {
			ceilingFan.high();
		}
	}
 
	public void undo() {
		if (prevSpeed == CeilingFan.HIGH) {
			ceilingFan.high();
		} else if (prevSpeed == CeilingFan.MEDIUM) {
			ceilingFan.medium();
		} else if (prevSpeed == CeilingFan.LOW) {
			ceilingFan.low();
		} else if (prevSpeed == CeilingFan.OFF) {
			ceilingFan.off();
		}
	}

	public String toString()
	{
		return "CycleCommand";
	}
}
