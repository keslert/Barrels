package  {
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.display.Shape;
	
	public class Boundary {
		private var xMax:int;
		private var yMax:int;
		private var mc:Sprite;
		private var PARENT:Sprite;
		
		public function Boundary(r:Sprite,x:int,y:int) {
			PARENT = r;
			this.xMax=x;
			this.yMax=y;
			mc = new Sprite();
			PARENT.addChild(mc);
			drawBoundary();
		}
		private function drawBoundary() {
			//mc.graphics.lineStyle(2,1,1);
			mc.graphics.beginFill(0xFFFFFF,1);
			mc.graphics.drawRect(0,0,xMax,yMax);
			mc.graphics.endFill();
			mc.cacheAsBitmap = true;
		}
		public function reDraw(x1:int,y1:int) {
			this.xMax=x1;
			this.yMax=y1;
			mc.graphics.clear();
			drawBoundary();
		}
	}
	
}
