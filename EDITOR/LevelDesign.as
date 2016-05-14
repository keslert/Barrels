package  {
	import flash.display.Sprite;
	
	public class LevelDesign {
		
		private var boundary:Boundary;
		private var cannons:Array;
		private var enemys:Array;
		private var items:Array;
		private var walls:Array;
		private var hero:Hero;
		private var cannonsRecycle:Array;
		private var enemysRecycle:Array;
		private var itemsRecycle:Array;
		private var wallsRecycle:Array;
		private var endCannon:EndCannon;
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
			updateGUI();
		}
		public function createLevel():void {
			createBoundary();
			createCannons();
			createEnemys();
			createItems();
			createWalls();
			updateGUI();
		}
		public function createNewLevel():void {
			createBoundary();
		}
		public function addCannon():Cannon {
			var cannon:Cannon;
			if(cannonsRecycle.length > 0) {
				cannon = cannonsRecycle.pop();
				cannon.recycleCannon(GB.myX,GB.myY,GB.myX,GB.myY,3,false,false,0,0,0,2,false,0,20);
			} else {
				cannon = new Cannon(r,GB.myX,GB.myY,GB.myX,GB.myY,3,false,false,0,0,0,2,false,0,20);
				cannons.push(cannon);
			}
			return cannon;
			//cannon = cannons[cannons.length-1];
			//cannon.gotoAndStop(2);
			//cannon.unlock();
		}
		public function addEnemy():Enemy {
			var enemy:Enemy;
			if(enemysRecycle.length > 0) {
				enemy = enemysRecycle.pop();
				enemy.recycleEnemy(GB.myX,GB.myY,GB.myX,GB.myY,true,false,3,25,1)
			} else {
				enemy = new Enemy(r,GB.myX,GB.myY,GB.myX,GB.myY,true,false,3,25,1);
				enemys.push(enemy);
			}
			return enemy;
		}
		public function addItem(type:int):Item {
			var item:Item;
			if(itemsRecycle.length > 0) {
				item = itemsRecycle.pop();
				item.recycleItem(GB.myX,GB.myY,GB.myX,GB.myY,false,0,20,type);
			} else {
				item = new Item(r,GB.myX,GB.myY,GB.myX,GB.myY,false,0,20,type);
				items.push(item);
			}
			return item;
		}
		public function addWall():Wall {
			var wall:Wall;
			if(wallsRecycle.length > 0) {
				wall = wallsRecycle.pop();
				wall.recycleWall(GB.myX,GB.myY,50,50);
			} else {
				wall = new Wall(r,GB.myX,GB.myY,50,50);
				walls.push(wall);
			}
			return wall;
		}
		private function createBackground() {
			r.addChild(new Background());
		}
		public function removeCannon(c:Cannon) {
			c.x = -1000;
			c.pathNode.x=-1000;
			c.clearPath();
			c.lock();
			cannonsRecycle.push(c);
		}
		public function removeEnemy(e:Enemy) {
			e.x = -1000;
			e.pathNode.x=-1000;
			e.clearPath();
			e.lock();
			enemysRecycle.push(e);
		}
		public function removeItem(i:Item) {
			i.x = -1000;
			itemsRecycle.push(i);
		}
		public function removeWall(w:Wall) {
			w.setX(-1000);
			trace(w.getX());
			w.clearPath();
			wallsRecycle.push(w);
		}
		private function createBoundary() {
			var c = Level.getBoundary(GB.LEVEL);
			if(boundary==null)
				boundary = new Boundary(r,c[0],c[1]);
			else
				boundary.reDraw(c[0],c[1]);
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
		private function updateGUI():void {
			GB.gui.foundItemsText.text = "0";
			GB.gui.totalItemsText.text = "/"+Level.getItems(GB.LEVEL).length;
		}
		public function printBoundary():String {
			return boundary.printout();
		}
		private function createCannons() {
			var cannon:Cannon;
			var c = Level.getCannon(GB.LEVEL);
			var l = c.length-1;
			var i:int;
			for(i=0;i<l;i++) {
				if(cannonsRecycle.length > 0) {
					cannon = cannonsRecycle.pop();
					cannon.recycleCannon(c[i][0],c[i][1],c[i][2],c[i][3],c[i][4],c[i][5],c[i][6],c[i][7],
										c[i][8],c[i][9],c[i][10],c[i][11],c[i][12],c[i][13])
					cannons.push(cannon);
				} else {
					cannons.push(new Cannon(r,c[i][0],c[i][1],c[i][2],c[i][3],c[i][4],c[i][5],c[i][6],c[i][7],
										c[i][8],c[i][9],c[i][10],c[i][11],c[i][12],c[i][13]));
				}
			}
			endCannon = new EndCannon(r,c[l][0],c[l][1]);
			if(GB.LEVEL==0) {
				endCannon.gotoAndStop(2);
				for(i=0;i<l;i++) {
					cannon = cannons[i];
					var t = c[i][14];
					var n = c[i][15];
					cannon.setType(t,n);
					cannon.cannonInfo.updateInfo();
				}
			}
		}
		private function createEnemys() {
			var c = Level.getEnemys(GB.LEVEL);
			for(var i=0;i<c.length;i++) {
				if(enemysRecycle.length > 0) {
					var enemy:Enemy = enemysRecycle.pop();
					enemy.recycleEnemy(c[i][0],c[i][1],c[i][2],c[i][3],c[i][4],c[i][5],c[i][6],c[i][7],c[i][8]);
					enemys.push(enemy);
				} else {
					enemys.push(new Enemy(r,c[i][0],c[i][1],c[i][2],c[i][3],c[i][4],c[i][5],c[i][6],c[i][7],c[i][8]));
				}
			}
		}
		private function createItems() {
			var c = Level.getItems(GB.LEVEL);
			for(var i=0;i<c.length;i++) {
				if(itemsRecycle.length > 0) {
					var item:Item = itemsRecycle.pop();
					item.recycleItem(c[i][0],c[i][1],c[i][2],c[i][3],c[i][4],c[i][5],c[i][6],c[i][7])
					items.push(item);
				} else {
					items.push(new Item(r,c[i][0],c[i][1],c[i][2],c[i][3],c[i][4],c[i][5],c[i][6],c[i][7]));
				}
			}
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
		public function getLastCannon():EndCannon {
			return endCannon;
		}
	}
}
