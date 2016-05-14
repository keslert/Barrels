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
		
		
		public function Engine(rootMC:Sprite) {
			ROOT = rootMC;
			r = new Sprite();
			ROOT.addChild(r);
			GB.gui.y=485;
			ROOT.addChild(GB.gui);
			
			gameCamera = new GameCamera(r);
			cannons = new Array();
			enemys = new Array();
			items = new Array();
			walls = new Array();
			GB.LEVEL=5;
			levelDesign = new LevelDesign(r,cannons,enemys,items,walls);
			buildLevel();
			createHero();
			
		}
		private function buildLevel() {
			ROOT.addEventListener(Event.ENTER_FRAME,updateGame);
			levelDesign.createLevel();
		}
		private function createHero():void {
			hero=new Hero();
			hero.assignCannons(cannons);
			hero.assignEnemys(enemys);
			hero.assignItems(items);
			hero.assignWalls(walls);
			hero.placeHero(cannons[0]);
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
			if(!hero.goalReached) {
				hero.updateHero();
				gameCamera.updateCamera(hero.x,hero.y);
			} else {
				ROOT.removeEventListener(Event.ENTER_FRAME,updateGame);
				advanceLevel();
			}
		}
		private function advanceLevel():void {
			levelDesign.cleanupLevel();
			levelDesign.levelAdvance();
			buildLevel();
			hero.placeHero(cannons[0]);
			hero.goalReached = false;
			var b = Level.getBoundary(GB.LEVEL);
			hero.setBounds(b[0],b[1]);
		}
		public function keysDown(event: KeyboardEvent): void{
			trace(event.keyCode);
			if(event.keyCode==32 && !spaceDown) {
				spaceDown = true;
				hero.fire();
			}
			if(event.keyCode==38 && !spaceDown) {
				spaceDown = true;
				hero.fire();
			}
			if(event.keyCode==90) {
				gameCamera.zoom();
			}
		}
		public function keysUp(event: KeyboardEvent): void{
			if(event.keyCode==32) {
				spaceDown = false;
			}
			if(event.keyCode==38) {
				spaceDown = false;
			}
			if(event.keyCode==90) {
				gameCamera.unzoom();
			}
		}
	}
	
}
