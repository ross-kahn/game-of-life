package src {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;	
	
	public class ButtonPanel extends MovieClip {
		
		
		public function ButtonPanel() {
			// constructor code
			pauseBtn.visible = false;
			pauseBtn.addEventListener(MouseEvent.CLICK, pauseClicked);
			playBtn.addEventListener(MouseEvent.CLICK, playClicked);
			restartBtn.addEventListener(MouseEvent.CLICK, restartClicked);
		}
		
		private function restartClicked(e:MouseEvent){
			(parent as Board).resetGame();
		}
		
		private function playClicked(e:MouseEvent){
			pauseBtn.visible = true;
			playBtn.visible = false;
			(parent as Board).playGame();
		}
		
		private function pauseClicked(e:MouseEvent){
			pauseBtn.visible = false;
			playBtn.visible = true;
			(parent as Board).pauseGame();
		}
		
		public function updateCycleCount(cycles:int){
			cycleCount.text = cycles.toString();
			(parent as Board).sendToRules();
		}
	}
	
}
