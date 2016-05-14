package  {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class Enemy extends MovieClip{
		private var x1:int;
		private var x2:int;
		private var y1:int;
		private var y2:int;
		public var speed:int;
		private var xSpeed:Number;
		private var ySpeed:Number;
		private var radius:int;
		public var spin:Boolean; //DOES THE BARREL SPIN 360?
		private var moveable:Boolean; //CAN THE BARREL MOVE
		
		private var mc:Sprite;
		private var path:Sprite;
		
		public var pathNode:PathNode;
		private var enemyInfo:EnemyInfo;
		public var type:uint;
		public function Enemy(mc:Sprite,x1:int,y1:int,x2:int,y2:int,moveable:Boolean,spin:Boolean,speed:int,radius:int,type:int) {
			this.x1=x1;
			this.y1=y1;
			this.x2=x2;
			this.y2=y2;
			this.moveable=moveable;
			this.spin=spin;
			this.speed=speed;
			this.mc=mc;
			this.radius = radius*radius;
			this.type = type;
			path = new Sprite();
			mc.addChild(path);
			calculateSpeed();
			this.x=x1;
			this.y=y1;
			mc.addChild(this);
			pathNode = new PathNode(this);
			mc.addChild(pathNode);
			this.gotoAndStop(type);
			initDragger();
			enemyInfo = new EnemyInfo(this);
			mc.addChild(enemyInfo);
		}
		public function recycleEnemy(x1:int,y1:int,x2:int,y2:int,moveable:Boolean,spin:Boolean,speed:int,radius:int,type:int) {
			this.x1=x1;
			this.y1=y1;
			this.x2=x2;
			this.y2=y2;
			this.moveable=moveable;
			this.spin=spin;
			this.speed=speed;
			this.mc=mc;
			this.radius = radius*radius;
			this.type = type;
			calculateSpeed();
			this.x=x1;
			this.y=y1;
			this.gotoAndStop(type);
			enemyInfo.updateInfo();
			this.visible=true;
		}
		public function calculateSpeed():void {
			if(moveable) {
				var dy:Number = y2-y1;
				var dx:Number = x2-x1;
				var angle:Number = Math.atan2(dy, dx);
				xSpeed = Math.cos(angle)*speed;
				ySpeed = Math.sin(angle)*speed;
				drawPath();
			}
			if(y2 < y1) { //NECESSARY CORRECTION
				var t = y1;
				y1 = y2;
				y2 = t;
			}
		}
		private function drawPath() {
			path.graphics.lineStyle(2,600000,1);
			path.graphics.moveTo(x1,y1);
			path.graphics.lineTo(x2,y2);
			path.graphics.drawCircle(x1,y1,3);
			path.graphics.drawCircle(x2,y2,3);
			path.graphics.lineStyle(5,300000,.8);
			path.graphics.drawCircle(x1,y1,1);
			path.graphics.drawCircle(x2,y2,1);
			path.cacheAsBitmap = true;
		}
		public function clearPath() {
			path.graphics.clear();
		}
		public function reDrawPath(newX:int,newY:int) {
			x2=newX;
			y2=newY;
			clearPath();
			moveable = true;
			drawPath();
		}
		public function updateEnemy():void {
			if(spin)	
				this.rotation+=5;
			updateLocation();
			pathNode.updatePath();
		}
		private function updateLocation():void {
			if(moveable) {
				this.x+=xSpeed;
				this.y+=ySpeed;				
				if (xSpeed < 0)
				{
					if (this.x < x1)
					{
						xSpeed *=  -1;
						ySpeed *= -1;
						this.x = x1;
						if(ySpeed < 0)this.y=y2;
						else this.y=y1;
					}
				}
				else
				{
					if (this.x > x2)
					{
						xSpeed *=  -1;
						ySpeed *= -1;
						this.x = x2;
						if(ySpeed > 0)this.y=y1;
						else this.y=y2;
					}
				}
				
				if (ySpeed < 0)
				{
					if (this.y < y1)
					{
						ySpeed *= -1;
						xSpeed *= -1;
						this.y = y1;
						if(xSpeed < 0)this.x=x2;
						else this.x=x1;
					}
				}
				else
				{
					if (this.y > y2)
					{
						ySpeed *= -1;
						xSpeed *= -1;
						this.y = y2;
						if(xSpeed > 0)this.x=x1;
						else this.x=x2;
					}
				}
			}
			enemyInfo.x = this.x;
			enemyInfo.y = this.y+45;
		}
		public function getRadius():int {
			if(type==1) return 25;
			if(type==2) return 30;
			return 25;
		}
		private function initDragger():void	{
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}

		private function mouseDownHandler(e:MouseEvent):void {
			if(GB.ctrlDown)
				GB.levelDesign.removeEnemy(this);
			else if(pathNode.isLocked()) {
				e.currentTarget.startDrag();
				moveable = false;
			}
		}
		private function mouseUpHandler(e:MouseEvent):void {
			if(pathNode.isLocked()) {
				e.currentTarget.stopDrag();
				x1 = int(this.x/25)*25;
				y1 = int(this.y/25)*25;
				this.x = x1;
				this.y = y1;
				x2 = x1;
				y2 = y1;
				pathNode.x = x1;
				pathNode.y = y1;
				clearPath();
			}
		}
		public function resetLoc() {
			this.x = x1;
			this.y = y1;
		}
		public function unlock():void
		{
			moveable = true;
		}
		public function lock():void
		{
			moveable = false;
		}
		public function printout():String {
			//x1,y1,x2,y2,moveable,spinning,speed,radius
			return "["+x1+","+y1+","+x2+","+y2+","+moveable+","+spin+","+speed+","+getRadius()+","+type+"],";
		}
	}
}
