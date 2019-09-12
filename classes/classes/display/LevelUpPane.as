package classes.display 
{
	import classes.CoC;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.internals.Utils;
	import coc.view.*;
	import com.bit101.components.Label;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	

	public class LevelUpPane extends Block
	{
		public function LevelUpPane() {}
		
		private var _initialized:Boolean = false;
		
		internal static const ATTRIBUTE_H:int = 70;
		internal static const ATTRIBUTE_W:int = 400;
		internal static const ATTRIBUTE_X:int = MainView.TEXTZONE_X + Math.floor(MainView.TEXTZONE_W / 2) - Math.floor(ATTRIBUTE_W / 2);
		
		public function configureLevelUpMenu():void {
			if (initialized) {
				return; //Already configured.
			}
			//Configure the layout.
			/*var levelUpContent:Block = new Block({
				name: "LevelUpMenu",
				x: MainView.TEXTZONE_X,
				y: MainView.TEXTZONE_Y,
				height: MainView.TEXTZONE_H,
				width: MainView.TEXTZONE_W
			});*/
			var levelUpMessage:TextField = new TextField();
				levelUpMessage.name = "LevelMessage";
				levelUpMessage.height = 60;
				levelUpMessage.width = ATTRIBUTE_W;
				levelUpMessage.x = MainView.TEXTZONE_X + Math.floor(MainView.TEXTZONE_W / 2) - Math.floor(levelUpMessage.width / 2);
				levelUpMessage.y = MainView.TEXTZONE_Y + 30;
				levelUpMessage.defaultTextFormat = new TextFormat("Palatino Linotype, serif", 32, "#000000", true, false, false, null, null, TextFormatAlign.CENTER);
				levelUpMessage.htmlText = "You are now level xx!";
			var attributeMessage:TextField = new TextField();
				attributeMessage.name = "AttributeMessage";
				attributeMessage.height = 40;
				attributeMessage.width = ATTRIBUTE_W;
				attributeMessage.x = MainView.TEXTZONE_X + Math.floor(MainView.TEXTZONE_W / 2) - Math.floor(attributeMessage.width / 2);
				attributeMessage.y = MainView.TEXTZONE_Y + 100;
				attributeMessage.defaultTextFormat = new TextFormat("Palatino Linotype, serif", 24, "#000000", false, false, false, null, null, TextFormatAlign.CENTER);
				levelUpMessage.htmlText = "You have <b>xx</b> points left to spend.";
			this.addElement(levelUpMessage);
			this.addElement(attributeMessage);
			for (var i:int = 0; i < 4; i++) {
				var attributeBackground:BitmapDataSprite = new BitmapDataSprite({
					name: "Background" + ["Str", "Tou", "Spe", "Int"][i],
					bitmapClass: MainView.DisclaimerBG,
					stretch: true,
					height: ATTRIBUTE_H,
					width: ATTRIBUTE_W,
					x: MainView.TEXTZONE_X + Math.floor(MainView.TEXTZONE_W / 2) - Math.floor(ATTRIBUTE_W / 2),
					y: MainView.TEXTZONE_Y + Math.floor(MainView.TEXTZONE_H / 3) + (i * 75)
				});
				var attributeButtonAdd:CoCButton = new CoCButton({
					bitmapClass: MainView.ButtonBackgroundSm,
					name: "Button" + ["Str", "Tou", "Spe", "Int"][i] + "Plus",
					height: MainView.BTN_H,
					width: MainView.BTN_H,
					x: attributeBackground.x + attributeBackground.width - MainView.BTN_H - 15,
					y: attributeBackground.y + 15,
					labelText: "+1",
					callback: Utils.curry(kGAMECLASS.playerInfo.addAttribute, ["str", "tou", "spe", "int"][i])
				});
				var attributeButtonSubtract:CoCButton = new CoCButton({
					bitmapClass: MainView.ButtonBackgroundSm,
					name: "Button" + ["Str", "Tou", "Spe", "Int"][i] + "Minus",
					height: MainView.BTN_H,
					width: MainView.BTN_H,
					x: attributeBackground.x + 15,
					y: attributeBackground.y + 15,
					labelText: "-1",
					callback: Utils.curry(kGAMECLASS.playerInfo.subtractAttribute, ["str", "tou", "spe", "int"][i])
				});
				var attributeName:TextField = new TextField();
					attributeName.name = "Label" + ["Str", "Tou", "Spe", "Int"][i];
					attributeName.height = 40;
					attributeName.width = (ATTRIBUTE_W / 2);
					attributeName.x = attributeBackground.x + Math.floor(ATTRIBUTE_W / 2) - Math.floor(attributeName.width / 2);
					attributeName.y = attributeBackground.y;
					attributeName.selectable = false;
					attributeName.defaultTextFormat = new TextFormat("Palatino Linotype, serif", 24, "#000000", true, false, false, null, null, TextFormatAlign.CENTER),
					attributeName.htmlText = ["Strength", "Toughness", "Speed", "Intelligence"][i];
				var attributeNumber:TextField = new TextField();
					attributeNumber.name = "Number" + ["Str", "Tou", "Spe", "Int"][i];
					attributeNumber.height = 50;
					attributeNumber.width = 80;
					attributeNumber.x = attributeBackground.x + 70;
					attributeNumber.y = attributeBackground.y + 25;
					attributeNumber.selectable = false;
					attributeNumber.defaultTextFormat = new TextFormat("Palatino Linotype, serif", 32, "#000000", false, false, false, null, null, TextFormatAlign.RIGHT);
					attributeNumber.htmlText = "--";
				var attributeModify:TextField = new TextField();
					attributeModify.name = "Number" + ["Str", "Tou", "Spe", "Int"][i] + "Mod";
					attributeModify.height = 50;
					attributeModify.width = 80;
					attributeModify.x = attributeBackground.x + 160;
					attributeModify.y = attributeBackground.y + 25;
					attributeModify.selectable = false;
					attributeModify.defaultTextFormat = new TextFormat("Palatino Linotype, serif", 32, "#00C000", false, false, false, null, null, TextFormatAlign.LEFT);
					attributeModify.htmlText = "--";
				var attributeResult:TextField = new TextField();
					attributeResult.name = "Number" + ["Str", "Tou", "Spe", "Int"][i] + "Rslt";
					attributeResult.height = 50;
					attributeResult.width = 100;
					attributeResult.x = attributeBackground.x + 230;
					attributeResult.y = attributeBackground.y + 25;
					attributeResult.selectable = false;
					attributeResult.defaultTextFormat = new TextFormat("Palatino Linotype, serif", 32, "#000000", true, false, false, null, null, TextFormatAlign.LEFT);
					attributeResult.htmlText = "--";
				this.addElement(attributeBackground);
				this.addElement(attributeButtonAdd);
				this.addElement(attributeButtonSubtract);
				this.addElement(attributeName);
				this.addElement(attributeNumber);
				this.addElement(attributeModify);
				this.addElement(attributeResult);
			}
			kGAMECLASS.mainView.addElement(this);
			initialized = true; //Mark that this is initialized.
			hide();
		}
		
		public function get initialized():Boolean { return _initialized; }
		public function set initialized(bool:Boolean):void { _initialized = bool; }
		
		public function show():void {
			this.visible = true;
		}
		public function hide():void {
			this.visible = false;
		}
	}

}