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
		public var itemsFound:int;
		
		private var cannons:Array;
		private var enemys:Array;
		private var items:Array;
		private var walls:Array;
		public var finalCannonVisible:int;
		private var engine:Engine;
		public function Hero(e:Engine) {
			engine=e;
			windSpeed=0;
			gravity=.5;
			inCannon=false;
			var i = Level.getBoundary(GB.LEVEL);
			setBounds(i[0],i[1]);
			finalCannonVisible=1;
			itemsFound=0;
		}
		public function assignCannons(cannonArray:Array) {
			cannons=cannonArray;
			
		}
		public function assignEnemys(enemyArray:Array) {
			enemys=enemyArray;
		}
		public function assignItems(itemArray:Array) {
			items=itemArray;
			if(items.length==0) {
				finalCannonVisible=0;
				Cannon(cannons[cannons.length-1]).visible=true;
			}
		}
		public function assignWalls(wallArray:Array) {
			walls=wallArray;
		}
		public function placeHero(c:Cannon):void {
			goalReached=false;
			this.visible=false;
			this.heroMC.gotoAndStop("neutral");
			moveable=false;
			curCannon = c;
			curCannon.unlock();
			if(curCannon.currentFrame==2) {
				if(GB.LEVEL==0) {
					goalReached=true;
					GB.LEVEL=c.number;
					c.placeOnTop();
					c.cannonMC.gotoAndStop("fire");
					c.lock();
				}
			} else curCannon.cannonMC.gotoAndStop("peek"); 
			cannonDelay=5;
			if(c == cannons[cannons.length-1]) {
				goalReached=true;
				GB.oldLevel=GB.LEVEL;
				StageSelect.passedOff(GB.LEVEL);
				GB.LEVEL=0;
				c.placeOnTop();
				c.cannonMC.gotoAndStop("fire");
				c.lock();
			}
		}
		public function fire():void {
			if(!goalReached) {
				this.visible = true;
				moveable = true;
				this.x = curCannon.x;
				this.y = curCannon.y;
				this.rotation = getRotation(curCannon.rotation);
				this.xSpeed = curCannon.getXFire();
				this.ySpeed = curCannon.getYFire();
				this.heroMC.gotoAndStop("roll");
				curCannon.cannonMC.gotoAndStop("fire");
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
			if(goalReached) {
				if(curCannon.cannonMC.fireMC.currentFrame==40) {
					nextLevel();
				}
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
				startCrash();
			checkHitTestEnemys();
			checkHitTestItems();
			checkHitTestWalls();
		}
		
		private function checkHitTestCannons() {
			var len = cannons.lengt h-finalCannonVisible;
			for(var i=0;i<len;i++) {
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
			var len = enemys.length;
			for(var i=0;i<len;i++) {
				var e:Enemy = enemys[i];
				var xDif = (this.x-e.x)*(this.x-e.x);
				if(xDif < e.getRadius()) {
					var yDif = (this.y-e.y)*(this.y-e.y);
					if(yDif < e.getRadius()) {
						var dif = Math.sqrt(xDif+yDif);
						if(dif < e.getRadius()) {
							startCrash();
						}
					}
				}
			}
		}
		private function checkHitTestItems() {
			var len = items.length;
			for(var i=0;i<len;i++) {
				var e:Item = items[i];
				if(!e.isFound()) {
					var xDif = (this.x-e.x)*(this.x-e.x);
					if(xDif < e.getRadius()) {
						var yDif = (this.y-e.y)*(this.y-e.y);
						if(yDif < e.getRadius()) {
							var dif = Math.sqrt(xDif+yDif);
							if(dif < e.getRadius()) {
								e.hitByHero();
								itemsFound++;
								if(itemsFound==items.length) {
									finalCannonVisible=0;
									var c:Cannon = cannons[cannons.length-1];
									c.visible = true;
									c.cannonMC.gotoAndPlay("appear");
								}
							}
						}
					}
				}
			}
		}
		private function checkHitTestWalls() {
			var len = walls.length;
			for(var i=0;i<len;i++) {
				var w:Wall = walls[i];
				
				var xDif = (this.x-w.getX())*(this.x-w.getX());
				if(xDif < w.getXRad()) {
					var yDif = (this.y-w.getY())*(this.y-w.getY());
					if(yDif < w.getYRad()) {
						startCrash();
					}
				}
			}
		}
		
		public function setBounds(x1:int,y1:int):void {
			xBound = x1;
			yBound = y1;
		}
		private function getRotation(rot:Number):Number {
			if(rot < 0) {
				this.scaleX=-1;
			} else {
				this.scaleX=1;
			}
			return rot;
		}
		public function crashDone():void {
			placeHero(curCannon);
		}
		private function startCrash():void {
			this.heroMC.gotoAndStop("crash");
			xSpeed=0;
			ySpeed=0;
		}
		public function nextLevel():void {
			engine.transitionLevel();
		}
	}
}
