package classes.Scenes.Dungeons.DragonCity 
{
	import classes.Scenes.Dungeons.DungeonAbstractContent;
	import classes.GlobalFlags.*;
	
	public class KoboldGoddessScenes extends DungeonAbstractContent
	{
		public function KoboldGoddessScenes() {}
		
		public function winOverKatharja():void {
			//#1 Victory Royale!
			flags[kFLAGS.DRAGON_CITY_KOBOLD_GODDESS_DEFEATED] = 1;
			clearOutput();
			outputText("(Placeholder) The self-proclaimed Kobold 'Goddess' falls at your [feet]. What do you do now?");
			menu();
			if (player.hasCock()) addButton(0, "PC Pitch", personalTimeWithKatharja);
			if (flags[kFLAGS.EMBER_HATCHED] > 0 && (flags[kFLAGS.EMBER_GENDER] == 1 || flags[kFLAGS.EMBER_GENDER] == 3)) addButton(1, "Ember Pitch", emberUpKatharja);
			addButton(2, "Kobold Rape", haveKoboldsBangKatharja);
			addButton(3, "Kill Her", finallyEliminateKatharjaNum1VictoryRoyale);
			
		}
		
		private function personalTimeWithKatharja():void {
			clearOutput();
			outputText("You have a hell of a time with Katharja and came.");
			flags[kFLAGS.DRAGON_CITY_KOBOLD_GODDESS_FUCKED] = 1;
			player.orgasm('dick');
			combat.cleanupAfterCombat();
		}
		
		private function emberUpKatharja():void {
			clearOutput();
			outputText("Ember gets up and personal with Katharja.");
			combat.cleanupAfterCombat();
		}
		
		private function haveKoboldsBangKatharja():void {
			clearOutput();
			outputText("The kobolds decide to have their way with Katharja.");
			combat.cleanupAfterCombat();
		}
		
		private function finallyEliminateKatharjaNum1VictoryRoyale():void {
			clearOutput();
			outputText("You make a quick work of the corrupted dragon and the kobolds witness your acts, and scamper off in fear! So much for being a 'goddess'!");
			flags[kFLAGS.DRAGON_CITY_KOBOLD_GODDESS_DEFEATED] = 2;
			combat.cleanupAfterCombat();
		}
		
		public function loseToTheGoddessBadEndz():void {
			//Todo: Split into two versions. Ember and non-Ember.
			clearOutput();
			outputText("This is where you would have a horrible Bad End. For now, Katharja laughs at your defeat and chides at your failed attempt. At least you're welcome to try again!");
			combat.cleanupAfterCombat();
			//getGame().gameOver();
		}
		
	}

}