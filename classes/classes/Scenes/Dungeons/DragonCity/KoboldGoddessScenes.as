package classes.Scenes.Dungeons.DragonCity 
{
	import classes.BaseContent;
	import classes.PerkLib;
	import classes.GlobalFlags.*;
	
	public class KoboldGoddessScenes extends BaseContent
	{
		public function KoboldGoddessScenes() {}
		
		public function winOverKatharja():void {
			if (player.hasPerk(PerkLib.Acid)) {
				outputText("Your acidity level drops to normal as you recover from the fire.\n\n");
				player.removePerk(PerkLib.Acid); //Remove acid slap as the goo PC recovers from dragonfire.
			}
			//#1 Victory Royale!
			flags[kFLAGS.DRAGON_CITY_KOBOLD_GODDESS_DEFEATED] = 1;
			clearOutput();
			outputText("(Placeholder) The self-proclaimed Kobold 'Goddess' falls at your [feet]. What do you do now?");
			menu();
			if (player.hasCock()) addButton(0, "PC Pitch", personalTimeWithKatharja);
			if (flags[kFLAGS.EMBER_HATCHED] > 0 && (flags[kFLAGS.EMBER_GENDER] == 1 || flags[kFLAGS.EMBER_GENDER] == 3)) addButton(1, "Ember Pitch", emberUpKatharja);
			addButton(2, "Kobold Rape", haveKoboldsBangKatharja);
			if (flags[kFLAGS.WATERSPORTS_ENABLED] > 0) addButton(3, "Mark w/ Piss", markKatharjaPeepee);
			addButton(4, "Kill Her", finallyEliminateKatharjaNum1VictoryRoyale);
			
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
		
		private function markKatharjaPeepee():void {
			clearOutput();
			outputText("You give Katharja a good marking with your piss, coating her in your scent and have a fucking afterward.");
			player.orgasm('generic');
			combat.cleanupAfterCombat();
		}
		
		private function finallyEliminateKatharjaNum1VictoryRoyale(executionMethod:int = 0):void {
			clearOutput();
			if (executionMethod == 0) {
				outputText("Who shall do the honours of executing Katharja, and what method?");
				menu();
				addButton(0, "You - Standard", finallyEliminateKatharjaNum1VictoryRoyale, 1).hint("A standard execution should ought to do the trick. FINISH HER!", "Standard Execution by You");
				addButton(1, "You - Behead Her", finallyEliminateKatharjaNum1VictoryRoyale, 2).hint("Standard execution not enough? Cut her head off to be displayed to the kobolds. FINISH HER! \n\n(Warning: Contains gore!)", "Behead Katharja");
				if (flags[kFLAGS.DRAGON_CITY_EMBER_TAGGED_ALONG] > 0) addButton(2, "Ember", finallyEliminateKatharjaNum1VictoryRoyale, 3).hint("Allow Ember to finally finish off Katharja.", "Execution by Ember");
				return;
			}
			else if (executionMethod == 1) {
				outputText("You make a quick work of the corrupted dragon and she is no more.");
			}
			else if (executionMethod == 2) {
				outputText("Taking advantage of the sharpness of your weapon, you raise it and get ready. In one quick swoop, the draconic head is severed from her neck and rolls onto the floor. You pick up the severed head to show to the kobolds, inciting fear into their hearts! With how fearsome and tough the dragon was, you stash the severed head to be kept for trophy.");
				player.createKeyItem("Trophy - Katharja's Head", 0, 0, 0, 0);
			}
			else if (executionMethod == 3) {
				outputText("You allow Ember to do the honours and that is easily done! Katharja is no more.");
			}
			outputText(" The kobolds witness the execution of the corrupted dragon, and scamper off in fear! So much for being a 'goddess'! ");
			if (silly()) outputText("<b>FATALITY!</b>");
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
		
		public function engageTheBoldBroodmother():void {
			clearOutput();
			outputText("You challenge the 'goddess' to a fight which she promptly accepts!");
			startCombat(new KoboldGoddess());
		}
		
	}

}