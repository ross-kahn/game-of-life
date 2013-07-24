package src {
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	
	public class EnterGameBtn extends SimpleButton {
		
		
		public function EnterGameBtn() {
			// constructor code
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent){
			(parent as Document).init();
			
		}
	}
	
}
