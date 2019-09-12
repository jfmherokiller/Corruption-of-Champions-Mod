package classes.Items.Consumables 
{
	import classes.Cock;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;
	import classes.Player;
	import classes.internals.Utils;
	import classes.GlobalFlags.kGAMECLASS;
	/**
	 * ...
	 * @author ...
	 */
	public class GirthoPlus extends Consumable
	{
		
		public function GirthoPlus() {
			super("GirthoP", "GirthoPlus", "a needle filled with Girtho+", 100, "This is a small needle with a reservoir full of blue liquid with white lines spiraling along its length. A faded label marks it as 'GirthoPlus'.  If it's of any indication, it would focus on thickening cocks.");
		}
		
		override public function canUse():Boolean {
			return player.hasCock();
		}
		
		override public function useItem():Boolean {
			clearOutput();
			if (!player.hasCock()) {
				outputText("As you look over the needle, you realize that its intended purpose is to thicken a penis which you do not possess. Sighing dejectedly, you put away the needle.");
				return true;
			}
			outputText("You ponder the needle in your hand knowing it will thicken a cock it's injected into.");
			kGAMECLASS.output.menu();
			if (player.cockTotal() == 1) {
				kGAMECLASS.output.addButton(0, "Inject", chooseSingleCock);
				kGAMECLASS.output.addButton(1, "Don't", girthPlusCancel);
			}
			else {
				for (var i:int = 0; i < player.cockTotal(); i++) {
					kGAMECLASS.output.addButton(i, "Cock #" + (i + 1), chooseSingleCock, 1).hint(player.cockDescript(i) + "\nLength: " + player.cocks[i].cockLength + "\nThickness: " + player.cocks[i].cockThickness);
				}
				kGAMECLASS.output.addButton(10, "All", chooseAllCocks);
				kGAMECLASS.output.addButton(14, "Nevermind", girthPlusCancel);
			}
			return(true);
		}
		
		private function chooseSingleCock(cockNum:int = 0):void {
			outputText("You sink the needle into the base of your " + game.player.cockDescript(cockNum) + ". It hurts like hell, but as you depress the plunger, the pain vanishes, replaced by a tingling pleasure as the chemicals take effect.\n\n");
			outputText("Your " + game.player.cockDescript(cockNum) + " twitches and thickens, looking to be ");
			if (game.player.cocks[cockNum].cockThickness < game.player.cocks[cockNum].cockLength / 10) {
				game.player.cocks[cockNum].cockThickness *= 1.5;
				outputText("fattening significantly!");
			}
			else if (game.player.cocks[cockNum].cockThickness < game.player.cocks[cockNum].cockLength / 6) {
				game.player.cocks[cockNum].cockThickness *= 1.3;
				outputText("thickening quite noticably.");
			}
			else if (game.player.cocks[cockNum].cockThickness < game.player.cocks[cockNum].cockLength / 4) {
				game.player.cocks[cockNum].cockThickness *= 1.2;
				outputText("thickening noticably.");
			}
			else if (game.player.cocks[cockNum].cockThickness < game.player.cocks[cockNum].cockLength / 2) {
				game.player.cocks[cockNum].cockThickness *= 1.1;
				outputText("widening slightly.");
			}
			else {
				outputText("widening slightly, only to shrink back to how it was before you even injected. Seems like your extremely thick cock is already fat enough.");
			}
			outputText("\n\nOnce the growth has stopped, you discard the now-empty syringe.");
			game.inventory.itemGoNext();
		}
		
		private function chooseAllCocks():void {
			outputText("You sink the needle into the base of your " + game.player.multiCockDescriptLight() + ". It hurts like hell, but as you depress the plunger, the pain vanishes, replaced by a tingling pleasure as the chemicals take effect.\n\n");
			var cocksAffected:int = 0;
			var thickenMultiplier:Number = 1;
			thickenMultiplier + (0.8 / player.cockTotal());
			for (var i:int = 0; i < player.cockTotal(); i++) {
				cocksAffected++;
				if (game.player.cocks[i].cockThickness < game.player.cocks[i].cockLength / 10) {
					game.player.cocks[i].cockThickness *= Math.max(1.20, thickenMultiplier);
				}
				else if (game.player.cocks[i].cockThickness < game.player.cocks[i].cockLength / 6) {
					game.player.cocks[i].cockThickness *= Math.max(1.15, thickenMultiplier);
				}
				else if (game.player.cocks[i].cockThickness < game.player.cocks[i].cockLength / 4) {
					game.player.cocks[i].cockThickness *= Math.max(1.10, thickenMultiplier);
				}
				else if (game.player.cocks[i].cockThickness < game.player.cocks[i].cockLength / 2) {
					game.player.cocks[i].cockThickness *= Math.max(1.05, thickenMultiplier);
				}
				else {
					cocksAffected--;
				}
				if (cocksAffected == player.cockTotal()) {
					outputText("Your " + game.player.multiCockDescriptLight() + " twitch and thicken, each of them looking to be fattening and becoming more consistent in thickness.");
				}
				else if (cocksAffected > 1) {
					outputText(Num2Text + " of your " + game.player.multiCockDescriptLight() + " twitch and thicken, each of the affected cocks looking to be fattening and becoming more consistent in thickness.");
				}
				else if (cocksAffected == 1) {
					outputText("One of your " + game.player.multiCockDescriptLight() + " twitches and thickens, looking to be fattening.");
				}
				else {
					outputText("But alas, nothing happens. Looks like all of them are too thick to begin with and you've already wasted it. How disappointing.");
				}
			}
			outputText("\n\nOnce the growth has stopped, you discard the now-empty syringe.");
			game.inventory.itemGoNext();
		}
		
		private function girthPlusCancel():void {
			clearOutput();
			outputText("You put the vial away.\n\n");
			game.inventory.returnItemToInventory(this);
		}
		
	}

}