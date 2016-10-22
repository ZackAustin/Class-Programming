

public class RemoteLoader {

	public static void main(String[] args)
	{
		RemoteControl remoteControl = new RemoteControl();

		CeilingFan ceilingFan = new CeilingFan("Living Room");

		CeilingFanMediumCommand ceilingFanMedium =
			new CeilingFanMediumCommand(ceilingFan);
		CeilingFanHighCommand ceilingFanHigh =
			new CeilingFanHighCommand(ceilingFan);
		CeilingFanLowCommand ceilingFanLow =
			new CeilingFanLowCommand(ceilingFan);
		CeilingFanOffCommand ceilingFanOff =
			new CeilingFanOffCommand(ceilingFan);
		CeilingFanCycleCommand ceilingFanCycle =
			new CeilingFanCycleCommand(ceilingFan);

		remoteControl.setCommand(0, ceilingFanHigh, ceilingFanOff);
		remoteControl.setCommand(1, ceilingFanMedium, ceilingFanOff);
		remoteControl.setCommand(2, ceilingFanLow, ceilingFanOff);
		remoteControl.setCommand(3, ceilingFanCycle, ceilingFanOff);

		System.out.println(remoteControl);
		remoteControl.onButtonWasPushed(0);
		remoteControl.offButtonWasPushed(0);

		System.out.println(remoteControl);

		remoteControl.onButtonWasPushed(1);
		System.out.println(remoteControl);

		remoteControl.undoButtonWasPushed();

		remoteControl.onButtonWasPushed(2);
		remoteControl.onButtonWasPushed(1);

		remoteControl.undoButtonWasPushed();

		System.out.println(remoteControl);

		remoteControl.onButtonWasPushed(3);
		remoteControl.onButtonWasPushed(3);
		remoteControl.onButtonWasPushed(3);
		remoteControl.onButtonWasPushed(3);
		remoteControl.onButtonWasPushed(3);
		remoteControl.onButtonWasPushed(3);
		remoteControl.onButtonWasPushed(3);
		remoteControl.undoButtonWasPushed();
	}
}
