package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import Hero;
	import Cannon;
	
	public class Engine {
	
		private var ROOT:Sprite;
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
		private var levelDesign:LevelDesign;
		private var paused:Boolean=true;
		
		public function Engine(rootMC:Sprite) {
			ROOT = rootMC;
			r = new Sprite();
			ROOT.addChild(r);
			GB.gui = new GUI(ROOT);
			gameCamera = new GameCamera(r);
			cannons = new Array();
			enemys = new Array();
			items = new Array();
			walls = new Array();
			GB.LEVEL=0;
			GB.engine = this;
			LoadAndSave.loadGameData();
			levelDesign = new LevelDesign(r,cannons,enemys,items,walls);
			levelDesign.createLevel();
			createHero();
			buildLevel();
		}
		public function startLevel():void {
			r.addEventListener(Event.ENTER_FRAME,updateGame);
			paused = false;
		}
		private function pauseLevel():void {
			r.removeEventListener(Event.ENTER_FRAME,updateGame);
			paused = true;
		}
		private function createHero():void {
			hero=new Hero(this);
			hero.assignCannons(cannons);
			hero.assignEnemys(enemys);
			hero.assignItems(items);
			hero.assignWalls(walls);
			r.addChild(hero);
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
			hero.updateHero();
			gameCamera.updateCamera(hero.x,hero.y);
		}
		public function buildLevel():void {
			levelDesign.cleanupLevel();
			levelDesign.createLevel();
			cannon = levelDesign.heroCannon()
			hero.placeHero(cannon);
			hero.goalReached = false;
			var b = Level.getBoundary(GB.LEVEL);
			hero.setBounds(b[0],b[1]);
			hero.finalCannonVisible=1;//one means not visible
			hero.itemsFound = 0;
			gameCamera.setCamera(-cannon.x,-cannon.y);
			if(Level.getItems(GB.LEVEL).length==0) {
				hero.finalCannonVisible=0;
				Cannon(cannons[cannons.length-1]).visible=true;
			}
			if(GB.LEVEL==0 && GB.SUCCESS) {
				cannon.transformBarrel();
			} else cannon.flyIn();
			GB.SUCCESS=false;
		}
		public function transitionLevel():void {
			pauseLevel();
			LoadAndSave.saveGameData();
			GB.gui.showInterlevelPage();
		}
		public function keysDown(event: KeyboardEvent): void{
			//trace(event.keyCode);
			if(event.keyCode==32 && !spaceDown && !paused) {
				spaceDown = true;
				hero.fire();
			} else {
				gameCamera.keysUp(event.keyCode);
			}
		}
		public function keysUp(event: KeyboardEvent): void{
			if(event.keyCode==32) {
				spaceDown = false;
			} else {
				gameCamera.keysDown(event.keyCode);
			}
		}
	}
}
