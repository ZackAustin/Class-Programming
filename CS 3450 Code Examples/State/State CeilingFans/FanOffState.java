

public class FanOffState implements FanState
{
	public FanState nextState() {
		return new FanHighState();
	}

	public String toString() {
		return "off";
	}
}
