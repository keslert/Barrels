package  {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class BoundSizer extends MovieClip {
		private var boundary:Boundary;
		private var locked:Boolean;
		public function BoundSizer(b:Boundary) {
			boundary=b;
			locked=true;
			this.addEventListener(Event.ENTER_FRAME,updateSizer);
			this.addEventListener(MouseEvent.MOUSE_DOWN, unlock);
			this.addEventListener(MouseEvent.MOUSE_UP, lock);
		}
		private function updateSizer(e:Event) {
			boundary.reDraw(int(this.x/25)*25,int(this.y/25)*25);
		}
		private function unlock(e:MouseEvent):void {
			locked = false;
			e.currentTarget.startDrag();
		}
		private function lock(e:MouseEvent):void {
			locked = true;
			e.currentTarget.stopDrag();
			this.x = int(this.x/25)*25;
			this.y = int(this.y/25)*25;
		}

	}
}