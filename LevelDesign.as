package  {
	import flash.display.Sprite;
	
	public class LevelDesign {
		private var background:Background;
		private var boundary:Boundary;
		private var cannons:Array;
		private var enemys:Array;
		private var items:Array;
		private var walls:Array;
		private var cannonsRecycle:Array;
		private var enemysRecycle:Array;
		private var itemsRecycle:Array;
		private var wallsRecycle:Array;
		
		private var r:Sprite;
		public function LevelDesign(mc:Sprite,cannons:Array,enemys:Array,items:Array,walls:Array) {
			r = mc;
			this.cannons=cannons;
			this.enemys=enemys;
			this.items = items;
			this.walls = walls;
			cannonsRecycle=new Array();
			enemysRecycle=new Array();
			itemsRecycle=new Array();
			wallsRecycle=new Array();
			createBackground();
		}
		public function createLevel():void {
			createBoundary();
			createCannons();
			createEnemys();
			createItems();
			createWalls();
			updateBackground();
			updateGUI();
		}
		private function createCannons() {
			var cannon:Cannon;
			var c = Level.getCannon(GB.LEVEL);
			var l:int = c.length;
			var i:int;
			for(i=0;i<l;i++) {
				if(cannonsRecycle.length > 0) {
					cannon = cannonsRecycle.pop();
					cannon.recycleCannon(c[i][0],c[i][1],c[i][2],c[i][3],c[i][4],c[i][5],c[i][6],c[i][7],
										c[i][8],c[i][9],c[i][10],c[i][11],c[i][12],c[i][13])
					cannons.push(cannon);
				} else {
					cannon = new Cannon(r,c[i][0],c[i][1],c[i][2],c[i][3],c[i][4],c[i][5],c[i][6],c[i][7],
										c[i][8],c[i][9],c[i][10],c[i][11],c[i][12],c[i][13])
					cannons.push(cannon);
				}
				if(GB.LEVEL==0) {
					cannon.setType(c[i][14],c[i][15]);
					//cannon.setType(1,c[i][15]);
				}
			}
			cannon = cannons[l-1];
			cannon.visible = false;
			cannon.unlock();
			if(GB.LEVEL==0) {
				cannon.gotoAndStop(3);
			} else {
				cannon.gotoAndStop(2);
			}			
		}
		private function createEnemys() {
			var c = Level.getEnemys(GB.LEVEL);
			for(var i=0;i<c.length;i++) {
				if(enemysRecycle.length > 0) {
					var enemy:Enemy = enemysRecycle.pop();
					enemy.recycleEnemy(c[i][0],c[i][1],c[i][2],c[i][3],c[i][4],c[i][5],c[i][6],c[i][7],c[i][8])
					enemys.push(enemy);
				} else {
					enemys.push(new Enemy(r,c[i][0],c[i][1],c[i][2],c[i][3],c[i][4],c[i][5],c[i][6],c[i][7],c[i][8]));
				}
			}
		}
		private function createItems() {
			GB.redGems=0;
			var item:Item;
			var c = Level.getItems(GB.LEVEL);
			for(var i=0;i<c.length;i++) {
				if(itemsRecycle.length > 0) {
					item = itemsRecycle.pop();
					item.recycleItem(c[i][0],c[i][1],c[i][2],c[i][3],c[i][4],c[i][5],c[i][6],c[i][7])
					items.push(item);
				} else {
					item = new Item(r,c[i][0],c[i][1],c[i][2],c[i][3],c[i][4],c[i][5],c[i][6],c[i][7]);
					items.push(item);
				}
				if(item.isRedGem()) GB.redGems++;
			}
		}
		private function createBoundary() {
			var c = Level.getBoundary(GB.LEVEL);
			if(boundary==null)
				boundary = new Boundary(r,c[0],c[1]);
			else
				boundary.reDraw(c[0],c[1]);
		}
		private function createWalls() {
			var w = Level.getWalls(GB.LEVEL);
			for(var i=0;i<w.length;i++) {
				if(wallsRecycle.length > 0) {
					var wall:Wall = wallsRecycle.pop();
					wall.recycleWall(w[i][0],w[i][1],w[i][2],w[i][3]);
					walls.push(wall);
				} else {
					walls.push(new Wall(r,w[i][0],w[i][1],w[i][2],w[i][3]));
				}
			}
		}
		private function createBackground() {
			background = new Background();
			r.addChild(background);
		}
		public function levelAdvance():void {
			GB.LEVEL++;
		}
		public function cleanupLevel() {
			while(cannons.length >0) {
				var cannon:Cannon = cannons.pop();
				cannon.x = -1000;
				cannon.visible = false;
				cannon.clearPath();
				cannonsRecycle.push(cannon);
			}
			while(enemys.length > 0) {
				var enemy:Enemy = enemys.pop();
				enemy.x = -1000;
				enemy.visible = false;
				enemy.clearPath();
				enemysRecycle.push(enemy);
			}
			while(items.length > 0) {
				var item:Item = items.pop();
				item.x = -1000;
				item.visible = false;
				itemsRecycle.push(item);
			}
			while(walls.length > 0) {
				var wall:Wall = walls.pop();
				wall.setX(-1000);
				wall.clearPath();
				wallsRecycle.push(wall);
			}
		}
		private function updateBackground():void {
			background.gotoAndStop(GB.LEVEL+1);
		}
		private function updateGUI():void {
			GB.gui.reset();
		}
		public function heroCannon():Cannon {
			if(GB.LEVEL==0) {
				var l:int = cannons.length;
				for(var i:int=0;i<l;i++) {
					var cannon:Cannon = cannons[i];
					if(cannon.number==GB.oldLevel) return cannon;
				}
			}
			return cannons[0];
		}
	}
}
