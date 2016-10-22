
public class CeilingFan {
	
	String location;
	FanState speed;
 
	public CeilingFan(String location) {
		this.location = location;
		speed = new FanOffState();
	}
  
	public void setSpeed(FanState newSpeed) {
		speed = newSpeed;
		System.out.println(location + " ceiling fan is on " + speed.toString());
	} 
 
	public FanState getSpeed() {
		return speed;
	}
}
