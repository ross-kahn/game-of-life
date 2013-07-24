package src {
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Ticker {

		private var btnPanel:ButtonPanel;
		private var cycleCount:int;
		private var cycleSpeed:Number;
		private var timer:Timer;

		public function Ticker(panel:ButtonPanel, speed:Number) {
			// constructor code
			btnPanel = panel;
			cycleCount = 0;
			cycleSpeed = speed;
			timer = new Timer(speed*1000);
			timer.addEventListener(TimerEvent.TIMER, tick);
		}
		
		public function playTicker(){
			timer.start();
		}
		
		public function pauseTicker(){
			timer.stop();
		}
		
		private function tick(e:TimerEvent){
			cycleCount++;
			btnPanel.updateCycleCount(cycleCount);
		}

	}
	
}
