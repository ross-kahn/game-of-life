package src {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.display.SimpleButton;
	
	public class Board extends Sprite{

		public const buffer:int = 15;

		private var allCells:Vector.<Vector.<Cell>>;
		private var activeCells:Vector.<Cell>;
		private var running:Boolean;
		private var bSize:int;
		private var btnPanel:ButtonPanel; 
		private var ticker:Ticker;
		private var rules:Rules;

		public function get Running():Boolean {return running;}

		public function Board(rule:Rules) {
			// constructor code
			rules = rule;
		}
		
		public function resetGame(){
			(parent as Document).resetGame();
		}
		
		public function toggleCell(toSwitch:Cell){
			trace(toSwitch.Location);
			toSwitch.toggleActive();
			if(toSwitch.Active){
				activeCells.push(toSwitch);
			}else{
				activeCells.splice(activeCells.indexOf(toSwitch), 1);
			}
			//trace("Active cells: " + activeCells);
			//trace(toSwitch.getNeighbors()[0].getNeighbors());
		}
		
		public function sendToRules(){
			var allRelevantCells:Vector.<Cell> = new Vector.<Cell>();
			allRelevantCells = allRelevantCells.concat(activeCells);
			for each(var aCell:Cell in activeCells){
				allRelevantCells = allRelevantCells.concat(aCell.getNeighbors());
			}
			//trace(allRelevantCells);
			rules.lifeCycle(allRelevantCells);
		}
		
		public function pauseGame(){
			ticker.pauseTicker();
			running = false;
		}
		
		public function playGame(){
			ticker.playTicker();
			running = true;
		}
		
		public function initBoard(boardSize:int, cycleSpeed:Number){
			var rowCounter:int;
			var colCounter:int;
			var cellSize:Number = ((parent as Document).screenSize / boardSize);
			
			btnPanel = new ButtonPanel();
			ticker = new Ticker(btnPanel, cycleSpeed);
			allCells = new Vector.<Vector.<Cell>>(boardSize, true);
			activeCells = new Vector.<Cell>();
			running = false;
			bSize = boardSize;
			
			addChild(btnPanel);
			btnPanel.x = (parent as Document).screenSize + cellSize;
			btnPanel.y = cellSize;
			
			trace("Cell Size in pixels: " + cellSize.toString());
			
			for(rowCounter = 0; rowCounter < boardSize; rowCounter++){
				var currCellVector:Vector.<Cell> = new Vector.<Cell>(boardSize, true);
				
				for(colCounter = 0; colCounter < boardSize; colCounter++){
					var tempCell = new Cell(rowCounter, colCounter);
					addChild(tempCell);
					tempCell.width = cellSize;
					tempCell.height = cellSize;
					tempCell.x = (colCounter * cellSize)+buffer;
					tempCell.y = (rowCounter * cellSize)+buffer;
					currCellVector[colCounter] = tempCell;
				}
				allCells[rowCounter] = currCellVector;
			}
			initNeighbors();
		}
		
		private function isPlaneOutOfBounds(plane:int):Boolean{
			if(plane == 0 || plane == bSize){
				return true;
			}else{
				return false;
			}
		}
		
		private function initNeighbors(){
			var currCellNeighbors:Vector.<Cell>;
			var nTop:Boolean;
			var nRight:Boolean;
			var nBottom:Boolean;
			var nLeft:Boolean;
			
			for each( var currRow:Vector.<Cell> in allCells){
				for each(var currCell:Cell in currRow){
					//trace(currCell);
					currCellNeighbors = new Vector.<Cell>();
					
					// True if there are neighbors on right
					nRight = currCell.Location.x < bSize-1;
					
					// True if there are neighbors on the left
					nLeft = currCell.Location.x > 0;
					
					// True if there are neighbors on the bottom
					nBottom = currCell.Location.y < bSize-1;
					
					// True if there are neighbors on top
					nTop = currCell.Location.y > 0;
		
					if(nRight){
						currCellNeighbors.push(allCells[currCell.Location.y][currCell.Location.x+1]);		// Center right
						if(nTop){
							currCellNeighbors.push(allCells[currCell.Location.y-1][currCell.Location.x+1]);		// Top right
						}
						if(nBottom){
							currCellNeighbors.push(allCells[currCell.Location.y + 1][currCell.Location.x+1]);	// Bottom right
						}
					}
					
					if(nLeft){
						
						currCellNeighbors.push(allCells[currCell.Location.y][currCell.Location.x-1]);		// Center left
						if(nTop){
							currCellNeighbors.push(allCells[currCell.Location.y-1][currCell.Location.x-1]);		// Top left
						}
						if(nBottom){
							currCellNeighbors.push(allCells[currCell.Location.y + 1][currCell.Location.x-1]); 	// Bottom left
						}
					}
					
					if(nTop){
						currCellNeighbors.push(allCells[currCell.Location.y-1][currCell.Location.x]);		// Top center
					}
					
					if(nBottom){
						currCellNeighbors.push(allCells[currCell.Location.y + 1][currCell.Location.x]);		// Bottom center
					}
					currCell.setNeighbors(currCellNeighbors);
				}
			}
		}

	}
	
}
