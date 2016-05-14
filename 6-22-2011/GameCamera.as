package  {
	import flash.display.Sprite;
	
	public class GameCamera {
		private static var STIFFNESS :Number = 5;		// higher = less stiff
		
		private static var WIDTH:Number = 640;
		private static var HEIGHT:Number = 480;
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
		public function zoom() {
			MC.scaleX = .5;
			MC.scaleY = .5;
		}
		public function unzoom() {
			MC.scaleX = 1;
			MC.scaleY = 1;
		}
	}
}