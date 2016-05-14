package  {
	import flash.net.SharedObject;	
	public class LoadAndSave {
		public static var LOCAL:SharedObject = SharedObject.getLocal("Barrels");
		public static function getVal(key:String) {
			return LOCAL.data[key];
		}
		public static function clearData():void {
			LOCAL.clear();
		}
		public static function setVal(key:String, val) {
			LOCAL.data[key] = val;
			LOCAL.flush();
		}
		public static function saveGameData():void {
			LOCAL.data.completedLevels = StageSelect.completedLevels;
			LOCAL.data.goldenBarrels = GB.goldenBarrels;
		}
		public static function loadGameData():void {
			var a:Array = LOCAL.data.completedLevels;
			StageSelect.completedLevels = (a==null) ? new Array() : a;
			var n = LOCAL.data.goldenBarrels;
			GB.goldenBarrels=(n==null) ? 0 : n;
		}
	}
}