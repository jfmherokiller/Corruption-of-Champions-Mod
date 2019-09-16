package classes.Scenes.Dungeons.DragonCity 
{
	import classes.Appearance;
	import classes.Ass;
	import classes.CockTypesEnum;
	import classes.BodyParts.Butt;
	import classes.BodyParts.Hips;
	import classes.Monster;
	import classes.StatusEffects;
	import classes.Vagina;

	public class KoboldBroodmother extends Monster
	{
		private var milkCooldown:int = 0;
		private var cumshotCooldown:int = 1;
		
		private function enticingBrood():void {
			outputText("The kobold broodmother wiggles her sexy body all over in an attempt to entice you!");
			var lustDmg:Number = 5 + rand(5);
			lustDmg += rand(player.cor / 15) + rand(player.lib / 5);
			player.takeLustDamage(lustDmg);
			combatRoundOver();
		}
		
		private function spitSlipperyGoo():void {
			outputText("The kobold broodmother spits her slippery goo towards your hands in an attempt to make you lose your grip!");
			player.createStatusEffect(StatusEffects.SlipperySlime, 2 + rand(3), 0, 0, 0);
			combatRoundOver();
		}
		
		private function broodCumCANNONZ():void {
			outputText("The kobold broodmother fires her cum at you in an attempt to arouse you! ");
			if (player.shield == shields.DRGNSHL || player.shield == shields.RUNESHL) {
				outputText("Luckily, you raise your shield just in time and the shield absorbs the liquids harmlessly much to her chagrin!");
			}
			else {
				outputText("You get hit and you're slimy all over! This reeks!");
				var lustDmg:Number = 5 + rand(10);
				lustDmg += rand(player.sens / 5);
				player.takeLustDamage(lustDmg);
				this.lust -= 10;
				this.fatigue += 15;
				this.cumshotCooldown = 3;
			}
			combatRoundOver();
		}
		
		private function broodUsesMilkDRINK():void {
			outputText("The kobold broodmother drinks some milk from her teat in order to heal herself! And getting a bit aroused too.");
			this.restoreHP(this.maxHP() / 3);
			this.takeLustDamage(5);
			this.milkCooldown = 3;
			combatRoundOver();
		}
		
		override public function doAI():void {
			if (!handleStun()) {
				return;
			}
			var moveChooser:Array = [enticingBrood, enticingBrood, enticingBrood];
			if (!player.hasStatusEffect(StatusEffects.SlipperySlime)) moveChooser.push(spitSlipperyGoo);
			if (cumshotCooldown <= 0) moveChooser.push(broodCumCANNONZ);
			if (milkCooldown <= 0 && HPRatio() < 0.4) moveChooser.push(broodUsesMilkDRINK);
			//Tick down cooldown.
			if (cumshotCooldown > 0) cumshotCooldown--;
			if (milkCooldown > 0) milkCooldown--;
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.dungeons.dragoncity.koboldBroodmother.winOverBoldBroodmother();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.dungeons.dragoncity.koboldBroodmother.loseToBoldBroodmother();
		}
		
		public function KoboldBroodmother() 
		{
			this.a = "the ";
			this.short = "kobold broodmother";
			this.imageName = "kobold-broodmother";
			this.long = "She is a hermaphroditic reptilian creature, visibly similar to but larger than a regular Kobold. She wears nothing but a few bangles; you have a perfect view of her pillowy boobs, they look grossly large and out of place on her and constantly leak milk, like a cow’s. Her dripping wet pussy and reptilian dick, which is 13 inches long and 2 inches thick, throb with her apparent excitement. She is covered in fine muddy-green scales, shining with the glossy juices she seems to be constantly leaking. Her long, spindly fingers and toes are elongated and end in wicked-looking claws, while vestigial wings flap uselessly upon her back, and she has a prehensile tail. A crest of spines starts at her brow and trail down the length of her spine to the tip of her tail, though they seem more decorative than anything. She drools a slick looking translucent slime, slavering this around with a long draconic tongue.";
			this.race = "Kobold";
			// this.plural = false;
			this.createBreastRow(Appearance.breastCupInverse("HHH"));
			this.createCock(13, 2, CockTypesEnum.LIZARD);
			this.createVagina(false, Vagina.WETNESS_SLICK, Vagina.LOOSENESS_LOOSE);
			this.ass.analLooseness = Ass.LOOSENESS_NORMAL;
			this.ass.analWetness = Ass.WETNESS_MOIST;
			this.tallness = 4*12+6;
			this.hips.rating = Hips.RATING_AVERAGE;
			this.butt.rating = Butt.RATING_TIGHT;
			this.skin.tone = "bronzed";
			this.hair.color = "nonexistent";
			this.hair.length = 0;
			initStrTouSpeInte(65, 75, 55, 45);
			initLibSensCor(80, 50, 75);
			this.weaponName = "claws";
			this.weaponVerb= "scratches";
			this.weaponAttack = 20;
			this.weaponPerk = "";
			this.weaponValue = 0;
			this.armorName = "scales";
			this.armorDef = 16;
			this.bonusHP = 560;
			this.lust = 40;
			this.bonusLust = 50;
			this.lustVuln = .4;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 17;
			this.gems = rand(45) + 80;
			this.additionalXP = 160;
			checkMonster();
		}
		
	}

}