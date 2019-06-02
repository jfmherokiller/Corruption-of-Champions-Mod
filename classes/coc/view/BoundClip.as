/**
 * Coded by aimozg on 02.12.2017.
 */
package coc.view {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class BoundClip extends MovieClip {
		
		private static var _nextContent:Sprite;
		
		public function BoundClip() {
			if (nextContent != null) {
				addChild(nextContent);
			}
		}
		
		public static function set nextContent(newContent:Sprite):void { _nextContent = newContent; }
		public static function get nextContent():Sprite { return _nextContent; }
		
	}
}
