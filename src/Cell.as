package src {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	public class Cell extends MovieClip {
		
		public static const BODY:int = 0;
		public static const CORNER:int = 1;
		public static const EDGE:int = 2;
		
		private var active:Boolean;
		private var neighbors:Vector.<Cell>;
		private var loc:Point;
		
		public function get Location():Point { return loc;}
		public function get Active():Boolean { return active;}
		
		public function Cell(row:int, column:int) {
			// constructor code
			
			loc = new Point(column, row);
			active = false;
			cellColor.visible = false;
			neighbors = new Vector.<Cell>();
			addEventListener(MouseEvent.CLICK, onClick);
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		public function setNeighbors(nVector:Vector.<Cell>){
			for each(var nCell:Cell in nVector){
				neighbors.push(nCell);
			}
		}
		
		public function getNeighbors():Vector.<Cell>{
			return neighbors;
		}
		
		public function numLiveNeighbors():int{
			var liveNeighbors:int = 0;
			for each(var cell:Cell in neighbors){
				if(cell.Active){
					liveNeighbors++;
				}
			}
			return liveNeighbors;
		}
		
		public function numDeadNeighbors():int{
			var deadNeighbors:int = 0
			for each(var cell:Cell in neighbors){
				if(!cell.Active){
					deadNeighbors++;
				}
			}
			return deadNeighbors;
		}
		
		public function notifyToggle(){
			(parent as Board).toggleCell(this);
		}
		
		private function onClick(e:MouseEvent){
			if(!(parent as Board).Running){
				notifyToggle();
			}
		}
		
		private function onMouseOver(e:MouseEvent){
			if(!(parent as Board).Running){
				cellColor.visible = true;
			}
			
		}
		
		private function onMouseOut(e:MouseEvent){
			if(!(parent as Board).Running){
				cellColor.visible = false;
			}
		}
		
		public function toggleActive(){
			active = active ? false : true;
			play();
		}
		
		public override function toString():String{
			return "[Cell (" + loc.x + ", " + loc.y + "): " + (active ? "Active" : "Inactive") + "]";
		}
		
	}
	
}
