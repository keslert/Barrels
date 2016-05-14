package  {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.display.Shape;
	
	public class Hero extends MovieClip {
		private var x1:int;
		private var x2:int;
		
		private var xSpeed:Number;
		private var ySpeed:Number;
		private var gravity:Number;
		private var windSpeed:Number;
		private var curCannon:Cannon;
		private var inCannon:Boolean;
		private var moveable:Boolean;
		private var cannonDelay:int;
		private var xBound:int;
		private var yBound:int;
		public var goalReached:Boolean;
		
		private var cannons:Array;
		private var enemys:Array;
		private var items:Array;
		private var walls:Array;
		
		public function Hero() {
			// constructor code
			windSpeed=0;
			gravity=.5;
			inCannon=false;
			var i = Level.getBoundary(GB.LEVEL);
			setBounds(i[0],i[1]);
		}
		public function assignCannons(cannonArray:Array) {
			cannons=cannonArray;
		}
		public function assignEnemys(enemyArray:Array) {
			enemys=enemyArray;
		}
		public function assignItems(itemArray:Array) {
			items=itemArray;
		}
		public function assignWalls(wallArray:Array) {
			walls=wallArray;
		}
		public function placeHero(c:Cannon):void {
			goalReached=false;
			this.visible=false;
			moveable=false;
			curCannon = c;
			curCannon.unlock();
			cannonDelay=5;
			if(c == cannons[cannons.length-1]) goalReached=true;
		}
		public function fire():void {
			if(!goalReached) {
				this.visible = true;
				moveable = true;
				this.x = curCannon.x;
				this.y = curCannon.y;
				this.rotation = curCannon.rotation;
				this.xSpeed = curCannon.getXFire();
				this.ySpeed = curCannon.getYFire();
				curCannon.lock();
			}
		}
		public function updateHero() {
			if(moveable) {
				updateLocation();
			} else {
				this.x = curCannon.x;
				this.y = curCannon.y;
			}
		}
		private function updateSpeed() {
			ySpeed+=gravity;
		}
		private function updateLocation() {
			updateSpeed();
			this.x+=xSpeed;
			this.y+=ySpeed;
			cannonDelay--;
			checkHitTestCannons();
			if(this.x < 0 || this. x > xBound || this.y < 0 || this.y > yBound)
				placeHero(curCannon);
			checkHitTestEnemys();
			checkHitTestItems();
			checkHitTestWalls();
		}
		
		private function checkHitTestCannons() {
			for(var i=0;i<cannons.length;i++) {
				var c:Cannon = cannons[i];
				if(c != curCannon || cannonDelay < 0) {
					var xDif = (this.x-c.x)*(this.x-c.x);
					if(xDif < c.getRadius()) {
						var yDif = (this.y-c.y)*(this.y-c.y);
						if(yDif < c.getRadius()) {
							var dif = Math.sqrt(xDif+yDif);
							if(dif < c.getRadius()) {
								placeHero(c);
								i=1000;
							}
						}
					}
				}
			}
		}
		private function checkHitTestEnemys() {
			for(var i=0;i<enemys.length;i++) {
				var e:Enemy = enemys[i];
				var xDif = (this.x-e.x)*(this.x-e.x);
				if(xDif < e.getRadius()) {
					var yDif = (this.y-e.y)*(this.y-e.y);
					if(yDif < e.getRadius()) {
						var dif = Math.sqrt(xDif+yDif);
						if(dif < e.getRadius()) {
							placeHero(curCannon);
						}
					}
				}
			}
		}
		private function checkHitTestItems() {
			for(var i=0;i<items.length;i++) {
				var e:Item = items[i];
				if(!e.isFound()) {
					var xDif = (this.x-e.x)*(this.x-e.x);
					if(xDif < e.getRadius()) {
						var yDif = (this.y-e.y)*(this.y-e.y);
						if(yDif < e.getRadius()) {
							var dif = Math.sqrt(xDif+yDif);
							if(dif < e.getRadius()) {
								e.hitByHero();
							}
						}
					}
				}
			}
		}
		private function checkHitTestWalls() {
			for(var i=0;i<walls.length;i++) {
				var w:Wall = walls[i];
				
				var xDif = (this.x-w.getX())*(this.x-w.getX());
				if(xDif < w.getXRad()) {
					var yDif = (this.y-w.getY())*(this.y-w.getY());
					if(yDif < w.getYRad()) {
						placeHero(curCannon);
					}
				}
			}
		}
		
		public function setBounds(x1:int,y1:int):void {
			xBound = x1;
			yBound = y1;
		}
	}
}
