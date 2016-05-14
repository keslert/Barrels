package  {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class EndCannon extends MovieClip {
		private var x1:int;
		private var y1:int;
		private var r:Sprite;
		public function EndCannon(r:Sprite,x1:int,y1:int) {
			this.r = r;
			r.addChild(this);
			this.x1 = x1;
			this.y1 = y1;
			this.x = x1;
			this.y = y1;
			initDragger();
		}
		private function initDragger():void	{
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}

		private function mouseDownHandler(e:MouseEvent):void {
			e.currentTarget.startDrag();
		}
		private function mouseUpHandler(e:MouseEvent):void {
			e.currentTarget.stopDrag();
			x1 = int(this.x/25)*25;
			y1 = int(this.y/25)*25;
			this.x = x1;
			this.y = y1;
		}

	}
	
}
