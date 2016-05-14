package  {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.Event;
	public class Cannon extends MovieClip {
		private var x1:int;
		private var x2:int;
		private var y1:int;
		private var y2:int;
		
		private var xMid:Number;
		private var yMid:Number;
		private var xDis:Number;
		private var yDis:Number;
		
		private var speed:int;
		private var xSpeed:Number;
		private var ySpeed:Number;
		private var rotStart:int;
		private var rotMax:int;
		private var rotMin:int;
		private var freeSpin:Boolean; //DOES THE BARREL SPIN 360?
		private var moveable:Boolean; //CAN THE BARREL MOVE
		private var momentum:Boolean; //DOES THE BARREL MOVE WITH MOMENTUM
		private var locked:Boolean; //STOPS THE CANNON FROM ROTATING
		private var delay:int;
		private var delayReset:int;
		private var power:Number;
		private var rotSpeed:Number;
		private var radius:Number;
		public var type:int;
		public var number:int;
		private var mc:Sprite;
		private var path:Sprite;
		private var flyInCounter:uint;
		public function Cannon(mc:Sprite,x1:int,y1:int,x2:int,y2:int,speed:int,moveable:Boolean,momentum:Boolean,rStart:int,rMax:int,rMin:int,rSpeed:int,fSpin:Boolean,d:int,p:int) {
			// constructor code
			locked=true;
			path = new Sprite();
			mc.addChild(path);
			this.x1=x1;
			this.y1=y1;
			this.x2=x2;
			this.y2=y2;
			this.moveable=moveable;
			this.momentum=momentum;
			this.speed=speed;
			
			rotStart=rStart;
			rotMax=rMax;
			rotMin=rMin;
			rotSpeed=rSpeed;
			freeSpin=fSpin;
			delay=d;
			delayReset=d;
			power=p;
			this.rotation=rStart;
			this.x=x1;
			this.y=y1;
			this.mc=mc;
			
			radius = 35*35;
			calculateSpeed();
			mc.addChild(this);
		}
		public function recycleCannon(x1:int,y1:int,x2:int,y2:int,speed:int,moveable:Boolean,momentum:Boolean,rStart:int,rMax:int,rMin:int,rSpeed:int,fSpin:Boolean,d:int,p:int) {
			// constructor code
			locked=true;
			
			this.x1=x1;
			this.y1=y1;
			this.x2=x2;
			this.y2=y2;
			this.moveable=moveable;
			this.momentum=momentum;
			this.speed=speed;
			this.gotoAndStop(1);
			rotStart=rStart;
			rotMax=rMax;
			rotMin=rMin;
			rotSpeed=rSpeed;
			freeSpin=fSpin;
			delay=d;
			delayReset=d;
			power=p;
			this.rotation=rStart;
			this.x=x1;
			this.y=y1;
			this.mc=mc;
			radius = 35*35;
			this.visible = true;
			calculateSpeed();

		}
		private function calculateSpeed():void {
			if(moveable) {
				var dy:Number = y2-y1;
				var dx:Number = x2-x1;
				var angle:Number = Math.atan2(dy, dx);
				xSpeed = Math.cos(angle)*speed;
				ySpeed = Math.sin(angle)*speed;
				drawPath();
				if(xSpeed < .000001) xSpeed = 0;
			}
			if(momentum) {
				initMomentum();
			}
			if(y2 < y1) { //NECESSARY CORRECTION
				var t = y1;
				y1 = y2;
				y2 = t;
			}
		}
		private function initMomentum():void {
			xDis = x2-x1;
			if(xDis!=0) {
				xMid = x1+((xDis)/2);
				xDis = xDis*xDis;
			}
			yDis = y2-y1;
			if(yDis!=0) {
				yMid = y1+((yDis)/2);
				yDis = yDis*yDis;
			}
		}
		private function drawPath() {
			path.graphics.lineStyle(5,1,.2);
			path.graphics.moveTo(x1,y1);
			path.graphics.lineTo(x2,y2);
			path.graphics.drawCircle(x1,y1,5);
			path.graphics.drawCircle(x2,y2,5);
			path.graphics.lineStyle(5,1,.8);
			path.graphics.drawCircle(x1,y1,2);
			path.graphics.drawCircle(x2,y2,2);
			path.cacheAsBitmap = true;
		}
		public function clearPath() {
			path.graphics.clear();
		}
		public function updateCannon():void {
			if(!locked)	
				updateRotation();
			updateLocation();
		}
		private function updateRotation():void {
			var locRot = this.rotation;
			delay--;
			if(delay < 0) {			
				if(locRot < 0)
					locRot+=360;
				delay=delayReset;
				if(freeSpin) { //360 spin
					locRot+=rotSpeed;
				} else {
					locRot+=rotSpeed;
					if(rotSpeed > 0) {
						if(locRot > rotMax) {
							locRot = rotMax;
							rotSpeed*=-1;
						}
					} else {
						if(locRot < rotMin) {
							locRot = rotMin;
							rotSpeed*=-1;
						}
					}
				}
				this.rotation=locRot;
			} 
		}
		private function updateLocation():void {
			if(moveable) {
				if(momentum) {
					var inertia:Number = getInertia();
					this.x+=xSpeed*inertia;
					this.y+=ySpeed*inertia;
				} else {
					this.x+=xSpeed;
					this.y+=ySpeed;
				}
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
		}
		private function getInertia():Number {
			var xInertia=0;
			var yInertia=0;
			if(xDis > 0) {
				xInertia = 1-Math.sqrt((xMid-this.x)*(xMid-this.x)/xDis);
			}
			if(yDis > 0) {
				yInertia = 1-Math.sqrt((yMid-this.y)*(yMid-this.y)/yDis);
			}
			if(xInertia==0) 
				return (yInertia*yInertia);
			else if(yInertia==0)
				return (xInertia*xInertia);
			return (xInertia*yInertia);
		}
		public function unlock():void {
			locked=false;
		}
		public function lock():void {
			locked=true;
		}
		public function getXFire():Number {
			return Math.cos((this.rotation-90)*Math.PI/180)*power;
		}
		public function getYFire():Number {
			return Math.sin((this.rotation-90)*Math.PI/180)*power;
		}
		public function getRadius():int {
			return radius;
		}
		public function transformBarrel():void {
			this.cannonMC.gotoAndStop("transform");
			this.addEventListener(Event.ENTER_FRAME,transformUpdate);
			flyInCounter=0;
		}
		private function transformUpdate(e:Event):void {
			flyInCounter++;
			if(flyInCounter > 25) {
				this.removeEventListener(Event.ENTER_FRAME,transformUpdate);
				flyIn();
			}
		}
		public function flyIn():void {
			this.cannonMC.gotoAndStop("flyIn");
			this.addEventListener(Event.ENTER_FRAME,flyInUpdate);
			flyInCounter=0;
		}
		private function flyInUpdate(e:Event):void {
			flyInCounter++;
			if(flyInCounter > 25) {
				this.removeEventListener(Event.ENTER_FRAME,flyInUpdate);
				GB.engine.startLevel();
				this.cannonMC.gotoAndStop("peek");
			}
		}
		public function setType(type:int,number:int) {
			if(StageSelect.isCompleted(number)) type = 1;
			this.type = type;
			this.number= number;
			this.gotoAndStop(type);
		}
		public function placeOnTop():void {
			mc.removeChild(this);
			mc.addChild(this);
		}
	}
}