package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.MouseEvent;

	public class Cannon extends MovieClip
	{
		private var x1:int;
		private var x2:int;
		private var y1:int;
		private var y2:int;

		private var xMid:Number;
		private var yMid:Number;
		private var xDis:Number;
		private var yDis:Number;

		public var speed:int;
		private var xSpeed:Number;
		private var ySpeed:Number;
		public var rotStart:int;
		public var rotMax:int;
		public var rotMin:int;
		public var freeSpin:Boolean;//DOES THE BARREL SPIN 360?
		private var moveable:Boolean;//CAN THE BARREL MOVE
		public var momentum:Boolean;//DOES THE BARREL MOVE WITH MOMENTUM
		private var locked:Boolean;//STOPS THE CANNON FROM ROTATING
		public var delay:int;
		public var delayReset:int;
		public var power:Number;
		public var rotSpeed:Number;
		private var radius:Number;
		public var type:int;
		public var number:int;
		private var mc:Sprite;
		private var path:Sprite;
		private var rotater:Rotater;
		public var pathNode:PathNode;
		public var cannonInfo:CannonInfo;
		public function Cannon(mc:Sprite,x1:int,y1:int,x2:int,y2:int,speed:int,moveable:Boolean,momentum:Boolean,rStart:int,rMax:int,rMin:int,rSpeed:int,fSpin:Boolean,d:int,p:int)
		{
			// constructor code
			locked = false;
			path = new Sprite();
			mc.addChild(path);
			this.x1 = x1;
			this.y1 = y1;
			this.x2 = x2;
			this.y2 = y2;
			this.moveable = moveable;
			this.momentum = momentum;
			this.speed = speed;

			rotStart = rStart;
			rotMax = rMax;
			rotMin = rMin;
			rotSpeed = rSpeed;
			freeSpin = fSpin;
			delay = d;
			delayReset = d;
			power = p;
			this.rotation = rStart;
			this.x = x1;
			this.y = y1;
			this.mc = mc;
			
			radius = 35 * 35;
			calculateSpeed();
			mc.addChild(this);
			rotater = new Rotater(this);
			mc.addChild(rotater);
			pathNode = new PathNode(this);
			mc.addChild(pathNode);
			initDragger();
			cannonInfo = new CannonInfo(this);
			mc.addChild(cannonInfo);
		}
		public function recycleCannon(x1:int,y1:int,x2:int,y2:int,speed:int,moveable:Boolean,momentum:Boolean,rStart:int,rMax:int,rMin:int,rSpeed:int,fSpin:Boolean,d:int,p:int)
		{
			// constructor code
			locked = false;

			this.x1 = x1;
			this.y1 = y1;
			this.x2 = x2;
			this.y2 = y2;
			this.moveable = moveable;
			this.momentum = momentum;
			this.speed = speed;

			rotStart = rStart;
			rotMax = rMax;
			rotMin = rMin;
			rotSpeed = rSpeed;
			freeSpin = fSpin;
			delay = d;
			delayReset = d;
			power = p;
			this.rotation = rStart;
			this.x = x1;
			this.y = y1;
			this.mc = mc;
			radius = 35 * 35;
			this.visible = true;
			pathNode.x=x1;
			pathNode.y=y1;
			calculateSpeed();
			cannonInfo.updateInfo();
			rotater.updateInfo();
			//pathNode.updateInfo();
		}
		public function calculateSpeed():void {	
			this.x = x1;
			this.y = y1;
			if (moveable)
			{
				var dy:Number = y2 - y1;
				var dx:Number = x2 - x1;
				var angle:Number = Math.atan2(dy,dx);
				xSpeed = Math.cos(angle) * speed;
				ySpeed = Math.sin(angle) * speed;
				drawPath();
			}
			if (momentum)
			{
				initMomentum();
			}
			if (y2 < y1)
			{//NECESSARY CORRECTION
				var t = y1;
				y1 = y2;
				y2 = t;
			}
		}
		private function initMomentum():void
		{
			xDis = x2 - x1;
			if (xDis != 0)
			{
				xMid = x1+((xDis)/2);
				xDis = xDis * xDis;
			}
			yDis = y2 - y1;
			if (yDis != 0)
			{
				yMid = y1+((yDis)/2);
				yDis = yDis * yDis;
			}
		}
		private function drawPath()
		{
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
		public function clearPath()
		{
			path.graphics.clear();
		}
		public function reDrawPath(newX:int,newY:int) {
			x2=newX;
			y2=newY;
			clearPath();
			moveable = true;
			drawPath();
		}
		public function updateCannon():void
		{
			if (! locked)
			{
				updateRotation();
			}
			updateLocation();
			rotater.updateRotater();
			pathNode.updatePath();
		}
		private function updateRotation():void
		{
			var locRot = this.rotation;
			delay--;
			if (delay < 0)
			{
				if (locRot < 0)
				{
					locRot +=  360;
				}
				delay = delayReset;
				if (freeSpin)
				{//360 spin
					locRot +=  rotSpeed;
				}
				else
				{
					locRot +=  rotSpeed;
					if (rotSpeed > 0)
					{
						if (locRot > rotMax)
						{
							locRot = rotMax;
							rotSpeed *=  -1;
						}
					}
					else
					{
						if (locRot < rotMin)
						{
							locRot = rotMin;
							rotSpeed *=  -1;
						}
					}
				}
				this.rotation = locRot;
			}
		}
		private function updateLocation():void
		{
			if (moveable)
			{
				if (momentum)
				{
					var inertia:Number = getInertia();
					this.x +=  xSpeed * inertia;
					this.y +=  ySpeed * inertia;
				}
				else
				{
					this.x +=  xSpeed;
					this.y +=  ySpeed;
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
			rotater.x = this.x;
			rotater.y = this.y;
			cannonInfo.x = this.x;
			cannonInfo.y = this.y+55;
		}
		private function getInertia():Number
		{
			var xInertia = 0;
			var yInertia = 0;
			if (xDis > 0)
			{
				xInertia = 1-Math.sqrt((xMid-this.x)*(xMid-this.x)/xDis);
			}
			if (yDis > 0)
			{
				yInertia = 1-Math.sqrt((yMid-this.y)*(yMid-this.y)/yDis);
			}
			if (xInertia == 0)
			{
				return (yInertia*yInertia);
			}
			else if (yInertia==0)
			{
				return (xInertia*xInertia);
			}
			return (xInertia*yInertia);
		}
		public function unlock():void
		{
			moveable = true;
			locked = false;
		}
		public function lock():void
		{
			moveable = false;
			locked = true;
		}
		public function getXFire():Number
		{
			trace(this.rotation);
			return Math.cos((this.rotation-90)*Math.PI/180)*power;
		}
		public function getYFire():Number
		{
			return Math.sin((this.rotation-90)*Math.PI/180)*power;
		}
		public function getRadius():int
		{
			return radius;
		}
		public function setMax(i:int) {
			rotMax = i;
		}
		public function setMin(i:int) {
			rotMin = i;
		}
		public function getX2():int {
			return x2;
		}
		public function getY2():int {
			return y2;
		}
		private function initDragger():void	{
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}

		private function mouseDownHandler(e:MouseEvent):void {
			if(GB.ctrlDown)
				GB.levelDesign.removeCannon(this);
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
		public function setType(type:int, number:int) {
			this.type = type;
			this.number = number;
		}
		public function printout():String {
			//x1,y1,x2,y2,speed,moveable,momentum,rStart,rMax,rMin,rSpeed,fSpin,delay,power
			var s:String;
			if(GB.LEVEL!=0)
			s = "["+x1+","+y1+","+x2+","+y2+","+speed+","+moveable+","+momentum+","+rotStart+","+
			rotMax+","+rotMin+","+rotSpeed+","+freeSpin+","+delayReset+","+power+"],";
			else 
			s = "["+x1+","+y1+","+x2+","+y2+","+speed+","+moveable+","+momentum+","+rotStart+","+
			rotMax+","+rotMin+","+rotSpeed+","+freeSpin+","+delayReset+","+power+","+type+","+number+"],";
			return s;
		}
	}
}