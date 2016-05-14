package  {
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;

	public class InterlevelPage extends Sprite {
		private var _r:Sprite;
		public function InterlevelPage(_r:Sprite) {
			this._r = _r;
			this._r.addChild(this);
			this.visible = false;
		}
		public function _show():void {
			this.visible = true;
			this.addEventListener(KeyboardEvent.KEY_DOWN,checkKey);
		}
		public function _hide():void {
			this.removeEventListener(KeyboardEvent.KEY_DOWN,checkKey);
			GB.gui.startLevel();
			this.visible = false;
		}
		private function checkKey(event:KeyboardEvent) {
			if(event.keyCode==32) {
				_hide();
			}
		}
	}
}