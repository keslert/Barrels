package  {
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	
	public class Wall {
		private var x1:int;
		private var y1:int;
		private var xLen:int;
		private var yLen:int;
		private var xRad:int;
		private var yRad:int;
		
		private var mc:Sprite;
		private var PARENT:Sprite;
		public var wallSizer:WallSizer;
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
			wallSizer = new WallSizer(this);
			wallSizer.x=xLen+x1;
			wallSizer.y=yLen+y1;
			PARENT.addChild(wallSizer);
			initDragger();
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
			mc.graphics.beginFill(0x333333,.3);
			mc.graphics.drawRect(-xLen,-yLen,xLen*2,yLen*2);
			mc.graphics.endFill();
			mc.cacheAsBitmap = true;
		}
		public function clearPath() {
			mc.graphics.clear();
		}
		public function reDraw(newX:int,newY:int) {
			xLen=newX-mc.x;
			yLen=newY-mc.y;
			clearPath();
			drawWall();
		}
		public function setX(x1:int) {
			this.x1 = x1;
			mc.x = x1;
		}
		public function setY(y1:int) {
			this.y1 = y1;
			mc.y = y1;
		}
		public function getX():int {
			return x1;
		}
		public function getY():int {
			return y1;
		}
		public function getXLen():int {
			return xLen;
		}
		public function getYLen():int {
			return yLen;
		}
		public function getXRad():int {
			return xRad;
		}
		public function getYRad():int {
			return yRad;
		}
		private function initDragger():void	{
			mc.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			mc.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}

		private function mouseDownHandler(e:MouseEvent):void {
			if(GB.ctrlDown)
				GB.levelDesign.removeWall(this);
			else {
				e.currentTarget.startDrag();
			}
		}
		private function mouseUpHandler(e:MouseEvent):void {
			e.currentTarget.stopDrag();
			trace(mc.x);
			x1 = int(mc.x/25)*25;
			y1 = int(mc.y/25)*25;
			mc.x = x1;
			mc.y = y1;
		}
		public function printout():String {
			//x1,y1,xLen,yLen
			return "["+x1+","+y1+","+xLen+","+yLen+"],";
		}
		
	}
	
}
