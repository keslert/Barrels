package  {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	
	public class Enemy extends MovieClip{
		private var x1:int;
		private var x2:int;
		private var y1:int;
		private var y2:int;
		private var speed:int;
		private var xSpeed:Number;
		private var ySpeed:Number;
		private var radius:int;
		private var spin:Boolean; //DOES THE BARREL SPIN 360?
		private var moveable:Boolean; //CAN THE BARREL MOVE
		
		private var mc:Sprite;
		private var path:Sprite;
		
		
		public function Enemy(mc:Sprite,x1:int,y1:int,x2:int,y2:int,moveable:Boolean,spin:Boolean,speed:int,radius:int) {
			this.x1=x1;
			this.y1=y1;
			this.x2=x2;
			this.y2=y2;
			this.moveable=moveable;
			this.spin=spin;
			this.speed=speed;
			this.mc=mc;
			this.radius = radius*radius;
			path = new Sprite();
			mc.addChild(path);
			calculateSpeed();
			this.x=x1;
			this.y=y1;
			mc.addChild(this);
		}
		public function recycleEnemy(x1:int,y1:int,x2:int,y2:int,moveable:Boolean,spin:Boolean,speed:int,radius:int) {
			this.x1=x1;
			this.y1=y1;
			this.x2=x2;
			this.y2=y2;
			this.moveable=moveable;
			this.spin=spin;
			this.speed=speed;
			this.mc=mc;
			this.radius = radius*radius;
			calculateSpeed();
			this.x=x1;
			this.y=y1;
			this.visible=true;
		}
		private function calculateSpeed():void {
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
			path.graphics.lineStyle(2,600000,.5);
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
		public function updateEnemy():void {
			if(spin)	
				this.rotation+=5;
			updateLocation();
		}
		private function updateLocation():void {
			if(moveable) {
				this.x+=xSpeed;
				this.y+=ySpeed;				
				if(xSpeed < 0) {
					if(this.x < x1) {
						xSpeed *=-1;
						this.x = x1;
					}
				} else {
					if(this.x > x2) {
						xSpeed *=-1;
						this.x = x2;
					}
				}
				if(ySpeed < 0) {
					if(this.y < y1) {
						ySpeed *=-1;
						this.y = y1;
					}
				} else {
					if(this.y > y2) {
						ySpeed *=-1;
						this.y = y2;
					}
				}
			}
		}
		public function getRadius():int {
			return radius;
		}
	}
}
