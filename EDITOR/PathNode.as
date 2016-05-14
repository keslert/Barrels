package  {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class PathNode extends MovieClip {
		private var object;
		private var locked:Boolean;
		public function PathNode(o) {
			object=o;
			locked=true;
			this.x = object.x;
			this.y = object.y;
			this.addEventListener(MouseEvent.MOUSE_DOWN, unlock);
			this.addEventListener(MouseEvent.MOUSE_UP, lock);
		}
		public function updatePath() {
			//this.x = cannon.getX2();
			//this.y = cannon.getY2();
			if(!locked) {
				object.reDrawPath(int(this.x/25)*25,int(this.y/25)*25);
				object.resetLoc();
			}
		}
		private function unlock(e:MouseEvent):void {
			locked = false;
			e.currentTarget.startDrag();
		}
		public function isLocked():Boolean {
			return locked;
		}
		private function lock(e:MouseEvent):void {
			locked = true;
			e.currentTarget.stopDrag();
			this.x = int(this.x/25)*25;
			this.y = int(this.y/25)*25;
			object.calculateSpeed();
		}
	}
}