package  {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	public class CannonInfo extends MovieClip{
		
		private var cannon:Cannon;
		public function CannonInfo(cannon:Cannon) {
			this.cannon = cannon;
			updateInfo();
			updateBtn.addEventListener(MouseEvent.CLICK,update);
		}
		public function update(e:MouseEvent) {
			cannon.speed = int(speedText.text);
			cannon.freeSpin = (spinText.text=="0") ? false : true;
			cannon.rotSpeed = int(rotSpeedText.text);
			cannon.delay = int(delayText.text);
			cannon.delayReset = int(delayText.text);
			cannon.momentum = (momentumText.text=="0") ? false : true;
			cannon.power = Number(powerText.text);
			if(GB.LEVEL==0) {
				cannon.type = int(typeText.text);
				cannon.number = int(numberText.text);
				cannon.gotoAndStop(cannon.type);
				cannon.numberText.text = numberText.text;
				cannon.blackNumberText.text = numberText.text;
			}
		}
		public function updateInfo():void {
			if(GB.LEVEL==0) {
				this.gotoAndStop(2);
				typeText.text = ""+cannon.type;
				numberText.text = ""+cannon.number;
				cannon.gotoAndStop(cannon.type);
				if(cannon.type==2) {
					cannon.numberText.text = numberText.text;
					cannon.blackNumberText.text = numberText.text;
				}
			}
			speedText.text = ""+cannon.speed;
			spinText.text = (cannon.freeSpin) ? "1" : "0";
			rotSpeedText.text = ""+cannon.rotSpeed;
			delayText.text = ""+cannon.delay;
			momentumText.text = (cannon.momentum) ? "1" : "0";
			powerText.text = ""+cannon.power;
		}
	}
}
