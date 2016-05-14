package  {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class Item extends MovieClip {
		private var x1:int;
		private var y1:int;
		private var x2:int;
		private var y2:int;
		private var type:String;
		private var points:int;
		private var speed:int;
		private var radius:int;
		private var xSpeed:Number;
		private var ySpeed:Number;
		private var stiffness:int;
		private var moveable:Boolean;
		private var returning:Boolean;
		private var found:Boolean;
		private var mc:Sprite;
		
		public function Item(mc:Sprite,x1:int,y1:int,x2:int,y2:int,moveable:Boolean,speed:int,radius:int) {
			this.x1=x1;
			this.y1=y1;
			this.x2=x2;
			this.y2=y2;
			this.moveable=moveable;
			this.speed=speed;
			this.radius = radius*radius;
			this.stiffness = 8;
			this.returning = false;
			this.found = false;
			this.x=x1;
			this.y=y1;
			this.mc=mc;
			mc.addChild(this);
		}
		public function recycleItem(x1:int,y1:int,x2:int,y2:int,moveable:Boolean,speed:int,radius:int) {
			this.x1=x1;
			this.y1=y1;
			this.x2=x2;
			this.y2=y2;
			this.moveable=moveable;
			this.speed=speed;
			this.radius = radius*radius;
			this.returning = false;
			this.found = false;
			this.x=x1;
			this.y=y1;
			this.visible = true;
		}
								
		public function updateLocation():void {
			//if(moveable)
			if(returning) returnLocation();
		}
		public function returnLocation():void {
			var vx = int((x1-this.x )/stiffness);
			var vy = int((y1-this.y )/stiffness);
			if(vx == 0 && vy == 0) returning = false;
			this.x+= vx;
			this.y+= vy;
		}
		public function getRadius():int {
			return radius;
		}
		public function hitByHero():void {
			found=true;
			GB.gui.itemFound();
			this.visible = false;
			this.x = -1000;
		}
		public function isFound() {
			return found;
		}
	}
}
