package  {
	public class StageSelect {
		public static var completedLevels:Array = new Array();
		public static var goldenBarrels:int;
		public static function getCannons():Array {
			var cannons=[
			[100,1150,100,1150,3,false,false,45,45,45,2,false,0,27,1,0],
			[300,950,300,950,3,false,false,0,0,0,90,true,30,15,1,0],
			[300,800,300,800,3,false,false,180,180,180,-3,false,0,15,2,2],
			[150,950,150,950,3,false,false,85,85,85,-3,false,0,15,2,1],
			[300,1125,300,1125,3,false,false,0,0,0,-3,false,0,20,2,3],
			[450,950,450,950,3,false,false,90,90,275,180,false,30,25,2,4],
			[625,950,625,950,3,false,false,0,0,0,-2,false,0,21,2,5],
			[625,500,625,500,3,false,false,0,0,0,90,true,20,30,1,0],
			[250,525,250,525,3,false,false,0,70,0,-90,false,30,18,2,6],
			[875,500,875,500,3,false,false,0,0,0,-90,true,20,20,1,0],
			[875,350,875,350,3,false,false,0,180,180,-2,false,0,15,2,7],
			[1025,500,1025,500,3,false,false,0,275,80,-200,false,30,20,2,9],
			[875,625,875,625,3,false,false,0,0,0,2,false,0,15,2,8],
			[625,150,625,150,3,false,false,0,185,75,-120,false,30,30,2,10],
			[1200,150,1200,150,3,false,false,0,285,180,-120,false,30,30,2,11],
			[1200,400,1200,400,3,false,false,0,180,0,180,false,20,20,2,12],
			[1200,600,1200,600,3,false,false,0,180,0,180,false,20,20,2,13],
			[1200,875,1200,875,3,false,false,0,0,0,90,true,20,20,2,14],
			[1200,1000,1200,1000,3,false,false,0,0,0,2,false,0,15,2,15],
			[1325,875,1325,875,3,false,false,0,275,275,2,false,0,15,2,16],
			[1075,875,1075,875,3,false,false,0,275,85,-190,false,30,22,2,17],
			[1325,500,1325,500,3,false,false,0,180,80,-120,false,20,20,2,18],
			[250,150,250,150,0,false,false,0,80,80,5,true,0,20]
			];
			return cannons;
		}
		public static function getEnemys():Array {
			var enemys=[];
			if(!isCompletedArray([1,2,3,4])) {
				enemys.push([550,925,550,925,false,false,3,25,1]);
				enemys.push([550,975,550,975,false,false,3,25,1]);
			}
			if(!isCompletedArray([5,6])) {
				enemys.push([750,500,750,500,false,false,3,30,1]);
			}
			if(!isCompletedArray([7,8,9])) {
				enemys.push([625,400,625,400,false,false,3,25,1]);  
			}
			if(!isCompletedArray([15,16,17])) {
				enemys.push([1125,500,1125,500,false,false,3,25,1]);
			}
			return enemys;
		}
		public static function getItems():Array {
			var items=[];
			return items;
		}
		public static function getWalls():Array {
			var walls=[];
			return walls;
		}
		public static function getBoundary():Array {
			return [1125,1250];
		}
		public static function passedOff(level:int) {
			GB.SUCCESS=true;
			completedLevels.push(level);
		}
		public static function isCompleted(level:int):Boolean {
			if(completedLevels.indexOf(level)!=-1) return true;
			return false;
		}
		public static function isCompletedArray(levels:Array) {
			while(levels.length>0) {
				if(!isCompleted(levels.pop())) return false;
			}
			return true;
		}
	}
}