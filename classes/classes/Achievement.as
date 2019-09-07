package classes 
{
	import classes.GlobalFlags.kGAMECLASS;
	import classes.display.AchievementDb;
	import classes.display.SpriteDb;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import classes.internals.LoggerFactory;

	/**
	 * Achievements 2.0
	 * @author Kitteh6660
	 */
	public class Achievement
	{
		private static var _achievementTotal:int = 0;
		private static var _achievementTrueTotal:int = 0;
		
		private var _title:String;
		private var _descLocked:String;
		private var _descUnlocked:String;
		private var _isShadow:Boolean;
		private var _id:int;

		private var _icon:BitmapData;
		
		//The constructor!
		public function Achievement(id:int, icon:Class, title:String, descLocked:String, descUnlocked:String = "", isShadow:Boolean = false) 
		{
			this._id = id;
			this._title = title;
			this._descLocked = descLocked;
			this._descUnlocked = descUnlocked;
			this._isShadow = isShadow;
			
			if (!isShadow) _achievementTotal++;
			_achievementTrueTotal++;
			
			if (icon != null) 
				this._icon = SpriteDb.bitmapData(icon);
			else
				this._icon = SpriteDb.bitmapData(AchievementDb.placeholder_unlocked);
		}
		
		public static function get currentAchievements():int {
			var temp:int = 0;
			for (var i:int = 0; i < 200; i++) {
				if (kGAMECLASS.achievements[i] > 0) {
					temp++
				}
			}
			return temp;
		}
		
		public static function get totalAchievements():int {
			return _achievementTotal;
		}
		
		//Accessible properties
		public function get title():String { return this._title; }
		
		public function get descLocked():String { return this._descLocked; }
		
		public function get descUnlocked():String {
			if (this._descUnlocked == "") return this._descLocked; //If you want unlocked and locked desc to be same.
			return this._descUnlocked;
		}
		
		public function get isShadow():Boolean { return this._isShadow; }
		
		public function get icon():BitmapData {
			if (isUnlocked())
				return this._icon;
			else
				return SpriteDb.bitmapData(AchievementDb.placeholder_locked);;
		}
		
		public function isUnlocked():Boolean {
			return kGAMECLASS.achievements[this._id] > 0;
		}
		
		public function getID():int{
			return this._id;
		}
		
	}

}