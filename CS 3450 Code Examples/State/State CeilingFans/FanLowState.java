

public class FanLowState implements FanState
{
	public FanState nextState() {
		return new FanOffState();
	}

	public String toString() {
		return "low";
	}
}
