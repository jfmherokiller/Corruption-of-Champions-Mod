package classes.Scenes.Dungeons.DragonCity 
{
	import classes.Appearance;
	import classes.Ass;
	import classes.BodyParts.Butt;
	import classes.BodyParts.Hips;
	import classes.Monster;

	public class Kobold extends Monster
	{
		private function biteAttack():void {
			combatRoundOver();
		}
		
		private function lickAttack():void {
			combatRoundOver();
		}
		
		private function kissAttack():void {
			combatRoundOver();
		}
		
		private function spitStickyGoo():void {
			combatRoundOver();
		}
		
		private function stripAttack():void {
			combatRoundOver();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.dungeons.dragoncity.kobold.victoryOverPunyKobold();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.dungeons.dragoncity.kobold.loseToKoboldzYAPYAPYAP();
		}
		
		public function Kobold(multi:Boolean = false)
		{
			this.a = "a ";
			this.short = "kobold";
			this.imageName = "kobold";
			if (multi) 
				this.long = "The kobolds are small, reptilian, impish creatures; they hop excitedly from one leg to another as they wait their turn to strike, letting out high-pitched yips and growls at each other, some even copping a feel of each other’s tails. They have a stunted, sexless physique and wear nothing but a few bangles; you can see no sign of any physical gender on them at all. They are covered in fine muddy-brown scales, some are dotted with the muck of their kin. Their long, spindly fingers and toes end in wicked-looking claws, while they are wingless and have a prehensile tail, though you can’t see any sign of spines on their tail ends. They snap their jaws intermittently but mostly are content to let their draconic tongues flop out, almost as long as they are tall, and allow thick green slime to drool copiously from their gaping maws. They switch positions constantly, and the ones who aren’t busy, take some time to make out and laugh at you teasingly.";
			else
				this.long = "The kobold is a small, reptilian, impish creature, which hops excitedly from one leg to another as it waits to strike, letting out high-pitched yips and growls. It has a stunted, sexless physique and wears nothing but a few bangles; you can see no sign of any physical gender on it at all. It is covered in fine muddy-brown scales. Its long, spindly fingers and toes end in wicked-looking claws, while it is wingless and has a prehensile tail, though it lacks Ember’s spines. It snaps its jaws intermittently but mostly is content to let its draconic tongue flop out, almost as long as it is tall, and allow thick green slime to drool copiously from its gaping maw.";
			this.race = "Kobold";
			// this.plural = false;
			this.initGenderless();
			this.createBreastRow(Appearance.breastCupInverse("AA"));
			this.ass.analLooseness = Ass.LOOSENESS_NORMAL;
			this.ass.analWetness = Ass.WETNESS_NORMAL;
			this.tallness = 4*12+6;
			this.hips.rating = Hips.RATING_AVERAGE;
			this.butt.rating = Butt.RATING_TIGHT;
			this.skin.tone = "bronzed";
			this.hair.color = "nonexistent";
			this.hair.length = 0;
			initStrTouSpeInte(65, 65, 80, 50);
			initLibSensCor(55, 40, 75);
			this.weaponName = "claws";
			this.weaponVerb= "scratches";
			this.weaponAttack = 20;
			this.weaponPerk = "";
			this.weaponValue = 0;
			this.armorName = "scales";
			this.armorDef = 15;
			this.bonusHP = 360;
			this.lust = 20;
			this.lustVuln = .4;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 15;
			this.gems = rand(45) + 55;
			checkMonster();
		}
		
	}

}