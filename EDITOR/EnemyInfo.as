package  {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	public class EnemyInfo extends MovieClip{
		
		private var enemy:Enemy;
		public function EnemyInfo(e:Enemy) {
			enemy = e;
			updateBtn.addEventListener(MouseEvent.CLICK,update);
			updateInfo();
		}
		public function update(e:MouseEvent) {
			enemy.speed = int(speedText.text);
			enemy.spin = (spinText.text=="0") ? false : true;
			enemy.type = int(typeText.text);
			enemy.gotoAndStop(enemy.type);
		}
		public function updateInfo() {
			spinText.text = (enemy.spin) ? "1" : "0";
			speedText.text = ""+enemy.speed;
			typeText.text = ""+enemy.type;
		}
	}
}