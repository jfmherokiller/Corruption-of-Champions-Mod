package classes.display 
{
	import classes.Achievement;
	import classes.GlobalFlags.kGAMECLASS;
	import coc.view.*;
	import com.bit101.components.ScrollPane;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class AchievementPane extends ScrollPane
	{
		private var _stage:Stage;
		
		private var _content:Block;
		private var _contentChildren:int;
		
		private static var _initialized:Boolean = false;
		
		private var colNum:int = 0;
		private var yPos:int = 100;
		
		public var progressBar:StatBar;
		
		public function AchievementPane(xPos:int, yPos:int, width:int, height:int) {
			move(xPos,yPos);
			setSize(width,height);
			// Initiate a new container for content that will be placed in the scroll pane
			_content = new Block({layoutConfig:{
				type: Block.LAYOUT_NONE,
				direction: 'column',
				gap: 0
			}});
			_content.name = "controlContent";
			_content.addEventListener(Block.ON_LAYOUT,function(e:Event):void{
				if (content) {
					update();
				}
			});
			_contentChildren = 0;
			_background.alpha = 0;
			// Hook into some stuff so that we can fix some bugs that ScrollPane has
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			this.content.addChild(_content);
		}
		
		/**
		 * Cleanly get us a reference to the stage to add/remove other event listeners
		 * @param	e
		 */
		private function addedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			
			_stage = this.stage;
			
			_stage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseScrollEvent);
		}
		
		private function removedFromStage(e:Event):void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			_stage.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseScrollEvent);
		}
		
		private function mouseScrollEvent(e:MouseEvent):void
		{
			this._vScrollbar.value += -( e.delta * 8 );
			update();
		}
		
		public function get initialized():Boolean { return _initialized; }
		public function set initialized(bool:Boolean):void { _initialized = bool; }
		
		public function configureAchievementPane():void {
			if (_initialized) {
				return;
			}
			this.name = "Achievement_Pane";
			var title:TextField = new TextField();
				title.name = "Title";
				title.height = 60;
				title.width = this.width - 20;
				title.x = 10;
				title.y = 10;
				title.defaultTextFormat = new TextFormat("Palatino Linotype, serif", 32, "#000000", true, false, true, null, null, TextFormatAlign.CENTER);
				title.htmlText = "Achievements";
			var progress:StatBar = new StatBar({statName: "Progress:"});
				progress.value = 0;
				progress.maxValue = 0;
				progress.x = 0 + Math.floor(this.width / 2) - Math.floor(progress.width / 2);
				progress.y = 60;
				progress.showMax = true;
			progressBar = progress;
			_content.addElement(title);
			_content.addElement(progress);
			kGAMECLASS.mainView.addElement(this);
			//Mark that this is initialized.
			_initialized = true;
			hide();
		}
		
		public function addOrUpdateAchievementBox(achievement:Achievement):void {
			var acBox:AchievementDisplay;
			acBox = _content.getElementByName("Ach_" + achievement.getID()) as AchievementDisplay
			if (acBox != null) {
				acBox.setAchievement(achievement);
			}
			else {
				acBox = new AchievementDisplay();
				acBox.name = "Ach_" + achievement.getID();
				acBox.x = 5 + (colNum * acBox.width);
				acBox.y = yPos;
				acBox.setAchievement(achievement);
				colNum++;
				if (colNum > 2) {
					colNum = 0;
					yPos += acBox.height;
				}
				_content.addElement(acBox);
			}
		}
		
		public function addCategoryHeader(title:String):void {
			if (_content.getElementByName("Header_" + title.slice(0, 4))) {
				return; //Already found? Skip.
			}
			if (colNum > 0) yPos += 120;
			colNum = 0;
			var header:TextField = new TextField();
				header.name = "Header_" + title.slice(0, 4);
				header.height = 30;
				header.width = this.width - 20;
				header.x = 10;
				header.y = yPos;
				header.defaultTextFormat = new TextFormat("Palatino Linotype, serif", 18, "#000000", true, false, true, null, null, TextFormatAlign.CENTER);
				header.htmlText = title;
			yPos += header.height;
			
			_content.addElement(header);
		}
		
		public function updateBackground():void {
			_background.alpha = kGAMECLASS.mainView.textBGWhite.alpha;
		}
		
		public function show():void {
			this.visible = true;
		}
		public function hide():void {
			this.visible = false;
		}
		
	}

}