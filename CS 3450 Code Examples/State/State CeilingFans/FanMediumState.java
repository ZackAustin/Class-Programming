

public class FanMediumState implements FanState
{
	public FanState nextState() {
		return new FanLowState();
	}

	public String toString() {
		return "medium";
	}
}
