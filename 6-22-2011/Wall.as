package  {
	import flash.display.Sprite;
	import flash.display.Shape;
	
	public class Wall {
		private var x1:int;
		private var y1:int;
		private var xLen:int;
		private var yLen:int;
		private var xRad:int;
		private var yRad:int;
		
		private var mc:Sprite;
		private var PARENT:Sprite;

		public function Wall(r:Sprite,x1:int,y1:int,xLen:int,yLen:int) {
			PARENT=r;
			this.x1=x1;
			this.y1=y1;
			this.xLen=xLen;
			this.yLen=yLen;
			
			xRad = xLen*xLen;
			yRad = yLen*yLen;
			mc=new Sprite();
			mc.x = x1;
			mc.y = y1;
			PARENT.addChild(mc);
			drawWall();
		}
		public function recycleWall(x1:int,y1:int,xLen:int,yLen:int) {
			this.x1=x1;
			this.y1=y1;
			this.xLen=xLen;
			this.yLen=yLen;
			
			xRad = xLen*xLen;
			yRad = yLen*yLen;
			mc.x = x1;
			mc.y = y1;
			drawWall();
		}
		private function drawWall() {
			trace("HERE");
			mc.graphics.beginFill(0x333333,1);
			mc.graphics.drawRect(-xLen,-yLen,xLen*2,yLen*2);
			mc.graphics.endFill();
			mc.cacheAsBitmap = true;
		}
		public function clearPath() {
			mc.graphics.clear();
		}
		public function setX(x1:int) {
			mc.x = x1;
		}
		public function setY(y1:int) {
			mc.y = y1;
		}
		public function getX():int {
			return x1;
		}
		public function getY():int {
			return y1;
		}
		public function getXRad():int {
			return xRad;
		}
		public function getYRad():int {
			return yRad;
		}
		
	}
	
}
