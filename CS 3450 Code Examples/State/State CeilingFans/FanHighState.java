

public class FanHighState implements FanState
{
	public FanState nextState() {
		return new FanMediumState();
	}

	public String toString() {
		return "high";
	}
}
