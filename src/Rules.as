package src {
	
	public class Rules {

		// Instead of going through all cells, most of which will be empty, this goes through only the active cells and the neighbors
		// of active cells
		// Rule 1: Any live cell with fewer than two live neighbours dies, as if caused by under-population.
		// Rule 2: Any live cell with two or three live neighbours lives on to the next generation.
		// Rule 3: Any live cell with more than three live neighbours dies, as if by overcrowding.
		// Rule 4: Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

		public function Rules() {
			// constructor code
		}
		
		public function lifeCycle(cells:Vector.<Cell>){
			var toToggle:Vector.<Cell> = new Vector.<Cell>();
			var processed:Vector.<Cell> = new Vector.<Cell>();	// To prevent duplicates
			
			for each(var cell:Cell in cells){
				if(processed.indexOf(cell) == -1){
					processed.push(cell);
					if(!cell.Active){
						if(cell.numLiveNeighbors() == 3){
							trace("Rules: " + cell + " has been activated."); 
							toToggle.push(cell);
						}
					}else{
						if(cell.numLiveNeighbors() < 2){
							trace("Rules: " + cell + " has died from starvation.");
							toToggle.push(cell);
						}else if(cell.numLiveNeighbors() > 3){
							trace("Rules: " + cell + " has died from overcrowding.");
							toToggle.push(cell);
						}
					}
				}
			}
			for each(var tCell:Cell in toToggle){
				tCell.notifyToggle();
			}
			
			
		}

	}
	
}
