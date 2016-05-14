package  {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	public class Rotater extends MovieClip{
		private var rotLocked:Boolean;
		private var maxLocked:Boolean;
		private var minLocked:Boolean;
		private var cannon:Cannon;
		
		public function Rotater(c:Cannon) {
			cannon=c;
			rotLocked=true;
			maxLocked=true;
			minLocked=true;
			this.rot.addEventListener(MouseEvent.MOUSE_DOWN, rotUnlock);
			GB.ROOT.addEventListener(MouseEvent.MOUSE_UP, rotLock);
			this.max.addEventListener(MouseEvent.MOUSE_DOWN, maxUnlock);
			GB.ROOT.addEventListener(MouseEvent.MOUSE_UP, maxLock);
			this.min.addEventListener(MouseEvent.MOUSE_DOWN, minUnlock);
			GB.ROOT.addEventListener(MouseEvent.MOUSE_UP, minLock);
			updateInfo();
		}
		public function updateRotater() {
			if(!rotLocked) {
				updateRot();
			}
			if(!maxLocked) {
				updateMax();
			}
			if(!minLocked) {
				updateMin();
			}
		}
		private function rotUnlock(e:MouseEvent) {
			rotLocked = false;
		}
		private function rotLock(e:MouseEvent) {
			rotLocked = true;
		}
		private function maxUnlock(e:MouseEvent) {
			maxLocked = false;
		}
		private function maxLock(e:MouseEvent) {
			maxLocked = true;
		}
		private function minUnlock(e:MouseEvent) {
			minLocked = false;
		}
		private function minLock(e:MouseEvent) {
			minLocked = true;
		}
		private function updateRot() {
			var angle = getAngle();
			this.rot.rotation = angle;
			cannon.rotation = angle;
		}
		private function updateMax() {
			var angle = getAngle();
			this.max.rotation = angle;
			cannon.setMax(angle);
		}
		private function updateMin() {
			var angle = getAngle();
			this.min.rotation = angle;
			cannon.setMin(angle);
		}
		private function getAngle():int {
			var dy:Number = this.mouseY;
			var dx:Number = this.mouseX;
			trace(this.x);
			var angle = int(Math.atan2(dy,dx)*57.29577951308232/5)*5+90;
			if(angle < 0 ) angle+=360;
			return angle;
		}
		public function updateInfo():void {
			rot.rotation = cannon.rotStart;
			max.rotation = cannon.rotMax;
			min.rotation = cannon.rotMin;
		}
	}
}
