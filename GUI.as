package  {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	public class GUI extends Sprite{
		
		private var interlevelPage:InterlevelPage;
		private var _r:Sprite;
		public function GUI(_r:Sprite) {
			this._r = _r;
			this._r.addChild(this);
			interlevelPage = new InterlevelPage(this);
			clearDataBtn.addEventListener(MouseEvent.CLICK,clearData);
			clearLevelBtn.addEventListener(MouseEvent.CLICK,clearLevel);
		}
		public function itemFound(type:int):void {
			if(type==2) {
				GB.goldenBarrels++;
				goldenBarrelText.text = ""+GB.goldenBarrels;
			}
			else {
				var i:int = int(this.foundItemsText.text)+1;
				this.foundItemsText.text = ""+i;
			}
			
		}
		public function showInterlevelPage():void {
			interlevelPage._show();
		}
		public function startLevel():void {
			GB.engine.buildLevel();
		}
		public function reset():void {
			foundItemsText.text = "0";
			totalItemsText.text = "/"+GB.redGems;
			goldenBarrelText.text = ""+GB.goldenBarrels;
		}
		private function clearData(e:MouseEvent):void {
			LoadAndSave.clearData();
		}
		private function clearLevel(e:MouseEvent):void {
			var s = StageSelect.completedLevels;
			var l = s.length;
			for(var i:int=0;i<l;i++) {
				if(s[i]==int(levelText.text)) {
					s.splice(i,1);
					break;
				}
			}
			LoadAndSave.saveGameData();
		}
	}
}