package  {
	
	public class Level {

		public function Level() {
			// constructor code
		}
		public static function getCannon(level:int):Array {
			//LAST CANNON IS ALWAYS THE GOAL
			var cannons;
			if(level==0) {
				return StageSelect.getCannons();
			}
			if(level==1) {
				cannons=[
				//x1,y1,x2,y2,speed,moveable,momentum,rStart,rMax,rMin,rSpeed,fSpin,delay,power
				[100,100,100,100,0,false,false,0,80,80,2,false,0,20],
				[300,100,100,100,0,false,false,0,80,80,3,false,0,20],
				[500,100,100,100,0,false,false,0,80,80,3,false,0,20],
				[700,100,100,100,0,false,false,0,80,80,5,true,0,20]
				]
				return cannons;
			} 
			if(level==2) {
				cannons=[
				//x1,y1,x2,y2,speed,moveable,momentum,rStart,rMax,rMin,rSpeed,fSpin,delay,power
				[100,100,100,100,0,false,false,0,80,80,5,false,0,20],
				[300,100,300,100,0,false,false,0,75,75,5,true,0,20],
				[700,100,100,100,0,false,false,0,80,80,5,true,0,20]
				]
				return cannons;
			}
			if(level==3) {
				cannons=[
				//x1,y1,x2,y2,speed,moveable,momentum,rStart,rMax,rMin,rSpeed,fSpin,delay,power
				[100,100,100,100,0,false,false,0,80,80,5,false,0,20],
				[300,100,300,100,0,false,false,0,75,75,5,false,0,20],
				[600,100,100,100,0,false,false,0,80,80,5,true,0,20]
				]
				return cannons;
			}
			if(level==4) {
				cannons=[
				//x1,y1,x2,y2,speed,moveable,momentum,rStart,rMax,rMin,rSpeed,fSpin,delay,power
				[100,100,100,100,0,false,false,0,80,80,5,false,0,20],
				[300,100,300,100,0,false,false,0,90,0,5,false,0,20],
				[600,100,100,100,0,false,false,0,80,80,5,true,0,20]
				]
				return cannons;
			}
			if(level==5) {
				cannons=[
				[50,75,50,75,3,false,false,0,90,0,3,false,0,20],
				[375,75,375,300,3,true,false,0,270,270,3,false,0,20],
				[200,300,200,300,3,false,false,0,0,0,3,true,0,20],
				[50,300,50,300,0,false,false,0,80,80,5,true,0,20]
				];
				return cannons;
			}
			if(level==6) {
				cannons=[
				[75,325,75,400,3,true,false,0,0,0,2,false,0,20],
				[50,75,375,75,10,true,true,0,225,135,2,false,0,20],
				[375,275,375,275,0,false,false,0,80,80,5,true,0,20]
				];
				return cannons;
			}
			if(level==7) {
				cannons=[
				[50,50,50,300,3,true,false,0,90,90,-2,false,0,20],
				[275,50,275,300,3,true,false,0,90,90,-2,false,0,20],
				[500,50,500,300,3,true,false,0,90,90,2,false,0,20],
				[750,75,750,75,0,false,false,0,80,80,5,true,0,20]
				];
				return cannons;
			}
			if(level==8) {
				cannons=[
				[50,50,50,200,3,true,false,0,180,0,-2,false,0,20],
				[400,125,400,125,0,false,false,0,80,80,5,true,0,20]
				];
				return cannons;
			}
			if(level==9) {
				cannons=[
				[75,50,75,50,3,false,false,0,180,180,-2,false,0,20],
				[75,325,350,325,10,true,true,0,0,0,2,false,0,20],
				[325,50,325,50,3,false,false,0,90,90,2,false,0,25],
				[550,50,750,50,3,true,false,0,275,90,15,false,10,20],
				[650,300,650,300,3,false,false,0,265,95,5,false,0,20],
				[425,550,750,550,3,true,false,0,335,5,-2,true,0,25],
				[75,525,75,525,0,false,false,0,80,80,5,true,0,20]
				];
				return cannons;
			}
			if(level==10) {
				cannons=[
				[150,1025,150,1025,3,false,false,0,0,0,22,true,5,25],
				[75,675,75,825,2,true,false,90,90,90,-2,false,0,25],
				[325,500,325,750,5,true,false,270,270,270,-3,false,0,25],
				[75,375,75,550,2,true,false,90,90,90,2,false,0,20],
				[325,225,325,450,5,true,false,270,270,270,-3,false,0,25],
				[125,250,125,250,3,false,false,0,90,0,-3,false,0,30],
				[675,225,675,225,3,false,false,0,0,0,45,true,15,17],
				[1225,150,1225,150,3,false,false,0,0,0,-2,true,0,20],
				[825,375,825,450,3,true,false,0,180,0,6,false,0,25],
				[1075,450,1425,450,5,true,false,0,0,0,5,true,0,25],
				[1425,750,1425,750,3,false,false,0,290,290,10,true,4,30],
				[1475,1050,1475,1050,3,false,false,0,355,355,-3,false,0,30],
				[600,825,600,825,0,false,false,0,80,80,5,true,0,20]
				];
				return cannons;
			}
			if(level==11) {
				cannons=[
				[800,750,800,750,3,false,false,0,0,0,2,false,0,30],
				[800,50,800,50,3,false,false,0,270,180,-47,false,20,25],
				[575,50,575,50,3,false,false,0,180,180,-2,false,0,20],
				[450,400,750,400,20,true,true,0,270,270,2,false,0,20],
				[575,750,575,750,3,false,false,0,0,0,-2,false,0,30],
				[200,300,200,300,0,false,false,0,80,80,5,true,0,20]
				];
				return cannons;
			}
			cannons=[
			//x1,y1,x2,y2,speed,moveable,momentum,rStart,rMax,rMin,rSpeed,fSpin,delay,power
			[500,100,100,100,0,false,false,0,80,80,5,true,0,20],
			[700,100,100,100,0,false,false,0,80,80,2,true,0,20],
			]
			return cannons;
			
		}
		public static function getEnemys(level:int):Array {
			var enemys;
			//x1,y1,x2,y2,moveable,spin,speed,radius) {
			if(level==0) {
				return StageSelect.getEnemys();
			}
			if(level==1) {
				enemys=[];
				return enemys;
			}
			if(level==2) {
				enemys=[];
				return enemys;
			}
			if(level==3) {
				enemys=[
				[500,000,500,200,true,true,2,25,1],
				]
				return enemys;
			}
			if(level==4) {
				enemys=[];
				return enemys;
			}
			if(level==5) {
				enemys=[];
				return enemys;
			}
			if(level==6) {
				enemys=[ 
				[275,150,450,150,true,true,3,25,1],
				[0,225,175,225,true,true,3,25,1]
				];
				return enemys;
			}
			if(level==7) {
				enemys=[ 
				[600,0,600,150,true,true,3,25,1]
				];
				return enemys;
			}
			if(level==8) {
				enemys=[ 
				[125,0,125,125,true,true,3,25,1],
				[175,125,175,250,true,true,3,25,1],
				[250,0,250,150,true,true,3,25,1],
				[325,125,325,250,true,true,3,25,1]
				];
			}
			if(level==9) {
				enemys=[ 
				[0,200,175,200,true,true,3,25,1],
				[275,200,400,200,true,true,3,25,1],
				[500,400,800,400,true,true,3,25,1]
				];
				return enemys;
			}
			if(level==10) {
				enemys=[ 
				[675,350,675,525,true,true,3,25,1],
				[1400,300,1575,375,true,true,3,30,2]
				];
				return enemys;
			}
			if(level==11) {
				enemys=[
				];
				return enemys;
			}
			enemys=[]
			return enemys;
		}
		public static function getItems(level:int):Array {
			var items;
			if(level==0) {
				return StageSelect.getItems();
			}
			if(level==1) {
				items=[];
				return items;
			}
			if(level==2) {
				items=[];
				return items;
			}
			if(level==3) {
				items=[];
				return items;
			}
			if(level==4) {
				//x1,y1,x2,y2,moveable,speed,radius) {
				items=[
				[450,40,0,0,false,0,20]
				]
				return items;
			}
			if(level==5) {
				items=[];
				return items;
			}
			if(level==6) {
				items=[
				[375,350,375,350,false,0,20,2]
				];
				return items;
			}
			if(level==7) {
				items=[ 
				[175,150,175,150,false,0,20],
				[400,150,400,150,false,0,20]
				];
				return items;
			}
			if(level==8) {
				items=[ 
				[325,50,325,50,false,0,20],
				[400,200,400,200,false,0,20],
				[175,50,175,50,false,0,20],
				[250,200,250,200,false,0,20]
				];
				return items;
			}
			if(level==9) {
				items=[ 
				[650,175,650,175,false,0,20],
				[575,475,575,475,false,0,20],
				[650,475,650,475,false,0,20],
				[725,475,725,475,false,0,20],
				[500,25,500,25,false,0,20]
				];
				return items;
			}
			if(level==10) {
				items=[ 
				[925,100,925,100,false,0,20],
				[1000,75,1000,75,false,0,20],
				[1075,100,1075,100,false,0,20],
				[1575,225,1575,225,false,0,20],
				[1450,925,1450,925,false,0,20],
				[1525,275,1525,275,false,0,20],
				[1575,275,1575,275,false,0,20]
				];
				return items;
			}
			if(level==11) {
				items=[ 
				[800,275,800,275,false,0,20,1],
				[800,500,800,500,false,0,20,1],
				[575,500,575,500,false,0,20,1],
				[575,275,575,275,false,0,20,1]
				];
				return items;
			}
			items=[]
			return items;
		}
		public static function getWalls(level:int):Array {
			var walls;
			if(level==0) {
				return StageSelect.getWalls();
			}
			if(level==1) {
				walls=[];
				return walls;
			}
			if(level==2) {
				walls=[];
				return walls;
			}
			if(level==3) {
				walls=[];
				return walls;
			}
			if(level==4) {
				walls=[];
				return walls;
			}
			if(level==5) {
				walls=[ 
				[200,175,100,50]
				];
				return walls;
			}
			if(level==6) {
				walls=[ 
				[225,275,50,150],
				[350,450,100,25],
				[200,450,25,25]
				];
				return walls;
			}
			if(level==7) {
				walls=[ 
				[175,50,50,50],
				[175,275,50,75],
				[400,50,50,50],
				[400,275,50,75],
				[700,250,125,100]
				];
				return walls;
			}
			if(level==8) {
				walls=[];
				return walls;
			}
			if(level==9) {
				walls=[ 
				[225,125,50,125],
				[200,425,200,50],
				[450,300,50,175],
				[550,175,50,50],
				[750,175,50,50]
				];
				return walls;
			}
			if(level==10) {
				walls=[ 
				[1450,200,50,50],
				[1525,100,50,50],
				[675,50,50,50],
				[450,1025,150,125],
				[425,850,75,50],
				[450,725,50,75],
				[450,525,25,125],
				[925,1100,325,50],
				[925,1000,50,50],
				[675,1000,50,50]
				];
				return walls;
			}
			if(level==11) {
				walls=[
				];
				return walls;
			}
			walls=[]
			return walls;
		}
		public static function getBoundary(level:int):Array {
			if(level==0) return StageSelect.getBoundary();
			if(level==1) return [800,200];
			if(level==2) return [800,200];
			if(level==3) return [800,200];
			if(level==4) return [800,200];
			if(level==5) return [425,375];
			if(level==6) return [450,475];
			if(level==7) return [825,350];
			if(level==8) return [450,250];
			if(level==9) return [800,600];
			if(level==10) return [1625,1150];
			if(level==11) return [925,850];
			return [800,400];
		}
	}
}
