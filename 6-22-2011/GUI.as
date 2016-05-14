package  {
	import flash.display.MovieClip;
	public class GUI extends MovieClip{
		
		
		public function GUI() {
			// constructor code
		}
		public function itemFound():void {
			var i:int = int(this.foundItemsText.text)+1;
			this.foundItemsText.text = ""+i;
		}

	}
	
}
