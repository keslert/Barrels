package  {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class WallSizer extends MovieClip {
		private var wall:Wall;
		private var locked:Boolean;
		public function WallSizer(w:Wall) {
			wall=w;
			locked=true;
			this.addEventListener(Event.ENTER_FRAME,updateSizer);
			this.addEventListener(MouseEvent.MOUSE_DOWN, unlock);
			this.addEventListener(MouseEvent.MOUSE_UP, lock);
		}
		private function updateSizer(e:Event) {
			if(!locked)
				wall.reDraw(int(this.x/25)*25,int(this.y/25)*25);
			else {
				this.x=wall.getX()+wall.getXLen();
				this.y=wall.getY()+wall.getYLen();
			}
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