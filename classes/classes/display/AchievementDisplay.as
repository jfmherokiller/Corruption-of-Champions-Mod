package classes.display 
{
	import classes.Achievement;
	import coc.view.BitmapDataSprite;
	import coc.view.Block;
	import coc.view.CoCButton;
	import coc.view.MainView;
	import coc.view.ToolTipView;
	import flash.filters.DropShadowFilter;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class AchievementDisplay extends Block
	{
		private var nameLabel:TextField;
		private var descLabel:TextField;
		public var bg:Sprite, ln:Sprite, icon:BitmapDataSprite;
		
		public function AchievementDisplay() 
		{
			var shadow:DropShadowFilter = new DropShadowFilter();
			shadow.strength = 0.4;
			
			this.height = 120;
			this.width = 250;
			
			this.bg = addBitmapDataSprite({
				x: 0, 
				y: 0,
				width: this.width,
				height: this.height,
				stretch: true,
				bitmapClass: ToolTipView.tooltipBg
			});
			this.ln = addBitmapDataSprite({
				x:10,
				y:25,
				width:230,
				height:1,
				fillColor:'#000000'
			});
			this.icon = addBitmapDataSprite({
				x:10,
				y:32,
				width:64,
				height:64,
				fillColor:'#000000'
			});
			
			this.nameLabel = addTextField( {
				text:"Lorem Ipsum",
				x: 10,
				y: 5,
				height: 25,
				width: 230,
				filters: [shadow],
				defaultTextFormat: {
					size: 18,
					bold: true,
					font: CoCButton.BUTTON_LABEL_FONT_NAME,
					align: 'left'
				}
			});
			this.descLabel = addTextField( {
				text:"Placeholder text is placeholder.",
				x: 75,
				y: 25,
				width: 165,
				height: 160,
				wordWrap: true,
				defaultTextFormat: {
					font: 'Times New Roman',
					size: 16,
					align: 'left'
				}
			});
			
		}
		
		public function setIcon(bmp:BitmapData):void {
			if (bmp != null) {
				var scale:Number = 64 / bmp.height;
				this.icon.scaleX = scale;
				this.icon.scaleY = scale;
				this.icon.graphics.clear();
				this.icon.graphics.beginBitmapFill(bmp, null, false, false);
				this.icon.graphics.drawRect(0, 0, bmp.width, bmp.height);
				this.icon.graphics.endFill();
			}
		}
		
		public function setAchievement(achievement:Achievement):void {
			//this.setIcon(achievement.)
			this.nameLabel.text = achievement.title;
			if (achievement.icon != null) this.setIcon(achievement.icon);
			if (achievement.isUnlocked()) {
				this.descLabel.text = achievement.descUnlocked;
				this.nameLabel.textColor = 0x00f000;
				this.bg.alpha = 1;
				this.icon.alpha = 1;
			}
			else {
				this.descLabel.text = achievement.descLocked;
				this.nameLabel.textColor = 0xb00000;
				this.bg.alpha = 0.4;
				this.icon.alpha = 0.4;
				if (achievement.isShadow) {
					this.descLabel.text = "This is a hidden achievement...";
				}
			}
			var tf:TextFormat = this.nameLabel.getTextFormat();
			//Shrink if text is cut off.
			for (var i:int = 1; i < 3; i++) {
				if (this.nameLabel.textWidth > this.nameLabel.width) {
					tf.size = 18 - (i * 2);
					this.nameLabel.setTextFormat(tf);
				}
			}
		}
		
	}

}