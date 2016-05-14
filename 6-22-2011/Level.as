package  {
	
	public class Level {

		public function Level() {
			// constructor code
		}
		public static function getCannon(level:int):Array {
			//LAST CANNON IS ALWAYS THE GOAL
			var cannons;
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
				[100,50,100,50,0,false,false,0,80,80,5,false,0,20],
				[300,50,300,50,0,false,false,0,75,75,5,true,0,20],
				[600,50,100,50,0,false,false,0,80,80,5,true,0,20]
				]
				return cannons;
			}
			if(level==3) {
				cannons=[
				//x1,y1,x2,y2,speed,moveable,momentum,rStart,rMax,rMin,rSpeed,fSpin,delay,power
				[100,50,100,50,0,false,false,0,80,80,5,false,0,20],
				[300,50,300,50,0,false,false,0,75,75,5,false,0,20],
				[600,50,100,50,0,false,false,0,80,80,5,true,0,20]
				]
				return cannons;
			}
			if(level==4) {
				cannons=[
				//x1,y1,x2,y2,speed,moveable,momentum,rStart,rMax,rMin,rSpeed,fSpin,delay,power
				[100,50,100,50,0,false,false,0,80,80,5,false,0,20],
				[300,50,300,50,0,false,false,0,90,0,5,false,0,20],
				[600,50,100,50,0,false,false,0,80,80,5,true,0,20]
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
				[500,000,500,100,true,true,1,25],
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
				[275,150,450,150,true,true,3,25],
				[0,225,175,225,true,true,3,25]
				];
				return enemys;
			}
			if(level==7) {
				enemys=[ 
				[600,0,600,150,true,true,3,25]
				];
				return enemys;
			}
			if(level==8) {
				enemys=[ 
				[125,0,125,125,true,true,3,25],
				[175,125,175,250,true,true,3,25],
				[250,0,250,150,true,true,3,25],
				[325,125,325,250,true,true,3,25]
				];
			}
			if(level==9) {
				enemys=[ 
				[0,200,175,200,true,true,3,25],
				[275,200,400,200,true,true,3,25],
				[500,400,800,400,true,true,3,25]
				];
				return enemys;
			}
			enemys=[]
			return enemys;
		}
		public static function getItems(level:int):Array {
			var items;
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
				items=[];
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
			items=[]
			return items;
		}
		public static function getWalls(level:int):Array {
			var walls;
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
				[225,250,50,125],
				[325,425,125,50],
				[200,425,25,50]
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
			walls=[]
			return walls;
		}
		public static function getBoundary(level:int):Array {
			if(level==1) return [800,200];
			if(level==2) return [800,100];
			if(level==3) return [700,100];
			if(level==4) return [700,100];
			if(level==5) return [425,375];
			if(level==6) return [450,475];
			if(level==7) return [825,350];
			if(level==8) return [450,250];
			if(level==9) return [800,600];
			return [800,400];
		}
	}
}
