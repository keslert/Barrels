package  {
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.net.*;
		
	public class EditorEngine {
		
		private var r:Sprite;
		private var cannons:Array;
		private var cannon:Cannon;
		private var enemys:Array;
		private var enemy:Enemy;
		private var items:Array;
		private var item:Item;
		private var walls:Array;
		private var wall:Wall;
		private var hero:Hero;
		private var spaceDown:Boolean;
		private var gameCamera:GameCamera;
		private var menuGUI:MenuGUI;
		private var endCannon:EndCannon;
		private var varr:URLVariables;
		
		
		private var scrollSpeed:int;

		public function EditorEngine(rootMC:Sprite) {
			GB.ROOT = rootMC;
			r = new Sprite();
			GB.ROOT.addChild(r); 
			GB.gui.y=485;
			GB.ROOT.addChild(GB.gui);
			menuGUI = new MenuGUI();
			menuGUI.x=640;
			GB.ROOT.addChild(menuGUI);
			GB.LEVEL = 11;
			gameCamera = new GameCamera(r);
			gameCamera.updateCamera(200,200);
			cannons = new Array();
			enemys = new Array();
			items = new Array();
			walls = new Array();
			GB.levelDesign = new LevelDesign(r,cannons,enemys,items,walls);
			addListeners();
			GB.ROOT.addEventListener(Event.ENTER_FRAME,updateGame);
			GB.myX=GB.myY=200;
			scrollSpeed=25;
			if(GB.LEVEL > -1) {
				GB.levelDesign.createLevel();
				endCannon = GB.levelDesign.getLastCannon();
			} else {
				endCannon = new EndCannon(r,200,300);
				GB.levelDesign.createNewLevel();
			}
		}
		private function updateGame(event:Event):void {
			for(var i=0;i<cannons.length;i++) {
				cannon = cannons[i];
				cannon.updateCannon();
			}
			for(var j=0;j<enemys.length;j++) {
				enemy = enemys[j];
				enemy.updateEnemy();
			}
		}
		
		private function addListeners() {
			menuGUI.cannonMC.addEventListener(MouseEvent.MOUSE_DOWN, cannonClicked);
			menuGUI.enemyMC.addEventListener(MouseEvent.MOUSE_DOWN, enemyClicked);
			menuGUI.itemMC.addEventListener(MouseEvent.MOUSE_DOWN, itemClicked);
			menuGUI.itemMC2.addEventListener(MouseEvent.MOUSE_DOWN, itemClicked);
			menuGUI.wallMC.addEventListener(MouseEvent.MOUSE_DOWN, wallClicked);
			menuGUI.printBtn.addEventListener(MouseEvent.MOUSE_DOWN, printClicked);
		}
		private function cannonClicked(e:MouseEvent):void {
			GB.levelDesign.addCannon();
		}
		private function enemyClicked(e:MouseEvent):void {
			GB.levelDesign.addEnemy();
		}
		private function itemClicked(e:MouseEvent):void {
			if(e.target==menuGUI.itemMC2) GB.levelDesign.addItem(2);
			else GB.levelDesign.addItem(1);
		}
		private function wallClicked(e:MouseEvent):void {
			GB.levelDesign.addWall();
		}
		private function printClicked(e:MouseEvent):void {
			var s:String = "";
			var i:int;
			s+="cannons=[\n";
			for(i=0;i<cannons.length;i++) {
				cannon = cannons[i];
				if(cannon.x > 0)s+=cannon.printout()+"\n";
			}
			s+="["+endCannon.x+","+endCannon.y+","+endCannon.x+","+endCannon.y+",0,false,false,0,80,80,5,true,0,20]"
			s+="\n];\nreturn cannons;\n";
			s+="enemys=[ \n";
			for(i=0;i<enemys.length;i++) {
				enemy = enemys[i];
				if(enemy.x > 0)s+=enemy.printout()+"\n";
			}
			s = s.substr(0,s.length-2);
			s+="\n];\nreturn enemys;\n";
			s+="items=[ \n";
			for(i=0;i<items.length;i++) {
				item = items[i];
				if(item.x > 0)s+=item.printout()+"\n";
			}
			s = s.substr(0,s.length-2);
			s+="\n];\nreturn items;\n";
			s+="walls=[ \n";
			for(i=0;i<walls.length;i++) {
				wall = walls[i];
				if(wall.getX() > 0)s+=wall.printout()+"\n";
			}
			s = s.substr(0,s.length-2);
			s+="\n];\nreturn walls;\n";
			
			s+= "boundary:\n"+GB.levelDesign.printBoundary();
			trace(s);
		}
		public function keysDown(event: KeyboardEvent): void{
			trace(event.keyCode);
			if(event.keyCode==37) {
				GB.myX-=scrollSpeed;
				gameCamera.updateCamera(GB.myX,GB.myY);
			}else
			if(event.keyCode==38) {
				GB.myY-=scrollSpeed;
				gameCamera.updateCamera(GB.myX,GB.myY);
			}else
			if(event.keyCode==39) {
				GB.myX+=scrollSpeed;
				gameCamera.updateCamera(GB.myX,GB.myY);
			}else
			if(event.keyCode==40) {
				GB.myY+=scrollSpeed;
				gameCamera.updateCamera(GB.myX,GB.myY);
			}else
			if(event.keyCode==90) {
				gameCamera.zoom();
			}else
			if(event.keyCode==17) {
				GB.ctrlDown=true;
			}
		}
		public function keysUp(event: KeyboardEvent): void{
			if(event.keyCode==90) {
				gameCamera.unzoom();
			}else
			if(event.keyCode==17) {
				GB.ctrlDown=false;
			}
		}
	}
}
