package  {
	import flash.display.Sprite;
	
	public class GameCamera {
		private static var STIFFNESS :Number = 5;		// higher = less stiff
		
		private static var WIDTH:Number = 640;
		private static var HEIGHT:Number = 480;
		private static var VIEW:Number = 300;
		private var MC :Sprite;
		
		public function GameCamera (mc:Sprite):void
		{
			MC = mc;
		}
		
		public function updateCamera(cx:Number,cy:Number):void
		{
			var vx = int((-cx+WIDTH/2-MC.x )/GameCamera.STIFFNESS);
			var vy = int((-cy+HEIGHT/2-MC.y )/GameCamera.STIFFNESS);
			MC.x += vx;
			MC.y += vy;
		}
		public function setCamera(cx:Number,cy:Number):void {
			MC.x = cx+WIDTH/2;
			MC.y = cy+HEIGHT/2;
		}
		public function keysUp(key:uint) {
			if(key==37) {
				WIDTH=640+VIEW;
			} else if(key==39) {
				WIDTH=640-VIEW;
			}
			if(key==38) {
				HEIGHT=480+VIEW;
			} else if(key==40) {
				HEIGHT=480-VIEW;
			}
		}
		public function keysDown(key:uint) {
			if(key==37) {
				WIDTH=640;
			} else if(key==39) {
				WIDTH=640;
			}
			if(key==38) {
				HEIGHT=480;
			} else if(key==40) {
				HEIGHT=480;
			}
		}
	}
}