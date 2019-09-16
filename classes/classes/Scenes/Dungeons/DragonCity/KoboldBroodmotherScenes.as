package classes.Scenes.Dungeons.DragonCity 
{
	import classes.Scenes.Dungeons.DungeonAbstractContent;
	import classes.GlobalFlags.*;
	
	public class KoboldBroodmotherScenes extends DungeonAbstractContent
	{
		public function KoboldBroodmotherScenes() {}
		
		public function winOverBoldBroodmother(continuation:Boolean = false):void {
			flags[kFLAGS.DRAGON_CITY_KOBOLD_BROODMOTHER_DEFEATED] = 1;
			if (!continuation) {
				clearOutput();
				outputText("(Placeholder) The broodmother falls defeated at your [feet]. What will you do with her?");
			}
			else {
				outputText("\n\nWhat will you do next?");
			}
			menu();
			addButton(0, "Fuck Her", fuckTheBroodmotherUpRealGood);
			addButton(1, "Ride Her", rideTheBroodmothersCock);
			addButton(2, "Drink Milk", getAGoodDrinkingOfKoboldMilk);
			if (monster.HP <= 0) addButton(3, "Kill Her", slayTheBroodmotherNoMore).hint("End the kobold broodmother to ensure that no more corrupted kobolds will be born.");
			addButton(4, "Leave", combat.cleanupAfterCombat);
		}
		
		private function fuckTheBroodmotherUpRealGood():void {
			clearOutput();
			outputText("This scene will have you vaginally fill the broodmother for a good orgasm!");
			flags[kFLAGS.DRAGON_CITY_KOBOLD_BROODMOTHER_FUCKED] = 1;
			player.orgasm('dick');
			combat.cleanupAfterCombat();
		}
		
		private function rideTheBroodmothersCock():void {
			clearOutput();
			outputText("This scene will have you ride fill the broodmother for a good filling! And risk a kobold pregnancy.");
			flags[kFLAGS.DRAGON_CITY_KOBOLD_BROODMOTHER_FUCKED] = 1;
			player.orgasm('vaginal');
			combat.cleanupAfterCombat();
		}
		
		private function getAGoodDrinkingOfKoboldMilk():void {
			clearOutput();
			outputText("This scene will have you get a good fill of the broodmother's milk to heal you. And possibly fuck her.");
			player.restoreHP(100 + (player.maxHP() / 3));
			player.refillHunger(30);
			winOverBoldBroodmother(true);
			removeButton(2);
		}
		
		private function slayTheBroodmotherNoMore():void {
			clearOutput();
			outputText("You make a quick work of the hermaphroditic kobold. No longer shall she produce more of those degenerated lizard-creatures! The other kobolds witness your acts and quickly scamper off in fear.");
			flags[kFLAGS.DRAGON_CITY_KOBOLD_BROODMOTHER_DEFEATED] = 2; //2 indicated killed.
		}
		
		public function loseToBoldBroodmother():void {
			clearOutput();
			outputText("This is where you will get a bad end involving being used as her fucktoy.");
			outputText("\n\nOf course, since the dungeon is still under construction, the kobold broodmother grudingly lets you go.");
			outputText("\n\n//getGame().gameOver();");
			combat.cleanupAfterCombat();
		}
		
		public function engageTheBoldBroodmother():void {
			clearOutput();
			outputText("You challenge the broodmother to a fight which she promptly accepts. She also sends two of her minions!");
			startCombat(new KoboldBroodmother());
			monster2 = new Kobold();
			monster3 = new Kobold();
		}
	}

}