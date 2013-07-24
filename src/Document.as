package src {
	
	import flash.display.MovieClip;
	import flash.text.TextFormat;	
	
	public class Document extends MovieClip {
		
		private var board:Board;
		public const screenSize:int = 870;
		public const scrollerFontSize:int = 48;
		
		public function Document() {
			// constructor code
		}
		
		public function init(){
			var boardSize:int = sizeScroller.value;
			var cycleSpeed:Number = speedScroller.value;
			var rules = new Rules();
			board = new Board(rules);
			
			addChild(board);
			board.initBoard(boardSize, cycleSpeed);
			play();
		}
		
		public function resetGame(){
			removeChildren();
			play();
		}
		
		public function removeChildren(){
			if(board != null){
				removeChild(board);
			}
		}
	}
	
}
