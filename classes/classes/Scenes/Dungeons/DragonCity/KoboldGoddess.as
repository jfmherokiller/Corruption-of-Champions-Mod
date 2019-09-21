package classes.Scenes.Dungeons.DragonCity 
{
	import classes.Appearance;
	import classes.Ass;
	import classes.CockTypesEnum;
	import classes.BodyParts.Butt;
	import classes.BodyParts.Hips;
	import classes.Monster;
	import classes.StatusEffects;
	import classes.StatusEffects.Combat.IceBreathDebuff;
	import classes.PerkLib;
	import classes.internals.WeightedDrop;
	import classes.Vagina;
	
	// The Main Boss
	public class KoboldGoddess extends Monster
	{
		private var breathCooldown:int = 2;
		
		private function clawBiteAttack():void {
			outputText("The dragon attempts to claw and bite at you! ");
			if (getEvasionRoll()) {
				outputText("Thanks to your agility, you managed to avoid such strikes!");
			}
			else {
				outputText("You get hit and you wince in pain! ");
				var dmg:Number = str + weaponAttack;
				dmg = player.reduceDamage(dmg);
				player.takeDamage(dmg, true);
			}
			combatRoundOver();
		}
		
		private function tailWhipAttack():void {
			outputText("The dragon attempts to slam her tail against you! ");
			if (getEvasionRoll()) {
				outputText("Thanks to your agility, you managed to avoid such tail strike!");
			}
			else {
				outputText("You get hit and momentarily lose your defenses!");
				if (!player.hasStatusEffect(StatusEffects.TailWhip)) player.createStatusEffect(StatusEffects.TailWhip, 4, 0, 0, 0);
				var dmg:Number = str + (weaponAttack / 2);
				dmg = player.reduceDamage(dmg);
				player.takeDamage(dmg, true);
			}
			combatRoundOver();			
		}

		private function boldDragonfire():void {
			outputText("The dragon attempts to unleash fire from her mouth! ");
			if (getEvasionRoll()) {
				outputText("Thanks to your agility, you managed to avoid the infernal blaze!");
			}
			else {
				outputText("You get hit and take heavy damage! ");
				if (player.isGoo() && !player.hasPerk(PerkLib.Acid)) {
					outputText("<b>Being gooey, you become more acidic. As such, you can slap her back for extra damage!</b>");
					player.createPerk(PerkLib.Acid, 0, 0, 0, 0);
				}
				var dmg:Number = 50 + rand(100) + (inte * 2) + (player.newGamePlusMod() * 30);
				dmg = player.reduceDamage(dmg);
				player.takeDamage(dmg, true);
			}
			fatigue += 25;
			combatRoundOver();
		}

		private function boldDragonice():void {
			outputText("The dragon attempts to unleash ice from her mouth! ");
			if (getEvasionRoll()) {
				outputText("Thanks to your agility, you managed to avoid the chill blast!");
			}
			else {
				outputText("You get hit and now you're shivering frantically! ");
				var dmg:Number = 50 + rand(50) + (inte * 2) + (player.newGamePlusMod() * 25);
				dmg = player.reduceDamage(dmg);
				player.takeDamage(dmg, true);
				var ice:IceBreathDebuff = player.statusEffectByType(StatusEffects.IceBreath) as IceBreathDebuff;
				if (ice == null) {
					ice = new IceBreathDebuff();
					player.addStatusEffect(ice);
				}
				ice.increase();
			}
			fatigue += 25;
			combatRoundOver();
		}
		
		override protected function performCombatAction():void {
			var moveChooser:Array = [clawBiteAttack, clawBiteAttack, tailWhipAttack];
			if (breathCooldown <= 0 && fatigueLeft() >= 25) {
				moveChooser.push(boldDragonfire);
				moveChooser.push(boldDragonice);
			}
			//Tick down cooldown.
			if (breathCooldown > 0) breathCooldown--;
			moveChooser[rand(moveChooser.length)]();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.dungeons.dragoncity.koboldGoddess.winOverKatharja();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.dungeons.dragoncity.koboldGoddess.loseToTheGoddessBadEndz();
		}
		
		public function KoboldGoddess() {
			this.a = "";
			this.short = "Katharja";
			this.imageName = "kobold-goddess";
			this.long = "Before you stands Katharja, the self-proclaimed goddess of the kobolds! Unlike her subjects, Katharja is unquestionably a true dragon, a monstrous herm who stands 8 feet tall, covered in thick, dull-green scales. A decorative row of spikes runs in a line from between her eyes down her spine to the tip of her tail, while intimidating bull-like horns curve forward from the sides of her head. Instead of tail-blades like Ember has, her tail’s end thickens into a monstrous cudgel of gnarly bone, fit for crushing skulls. Burning mad red eyes glower at you, and she makes a show of running her draconic tongue along her razor-like teeth or clawed fingers, her tattered draconic wings flaring to make her look more intimidating. G-cup breasts bounce proudly upon her chest, while an arm-like draconic penis, easily 20” by 3”, juts from above her slavering cunt. She looks at you with distaste, like she was dealing with vermin far below her standing. Her stance is solid, with no openings and you can see the power behind her limbs; this is not going to be easy.";
			this.race = "Dragon";
			// this.plural = false;
			this.createBreastRow(Appearance.breastCupInverse("F"));
			this.createCock(20, 3, CockTypesEnum.DRAGON);
			this.createVagina(false, Vagina.WETNESS_NORMAL, Vagina.LOOSENESS_LOOSE);
			this.ass.analLooseness = Ass.LOOSENESS_NORMAL;
			this.ass.analWetness = Ass.WETNESS_NORMAL;
			this.tallness = 8*12;
			this.hips.rating = Hips.RATING_AVERAGE;
			this.butt.rating = Butt.RATING_TIGHT;
			this.skin.tone = "green";
			this.hair.color = "nonexistent";
			this.hair.length = 0;
			initStrTouSpeInte(85, 80, 80, 65);
			initLibSensCor(65, 40, 98);
			this.weaponName = "claws";
			this.weaponVerb= "scratches";
			this.weaponAttack = 30;
			this.weaponPerk = "";
			this.weaponValue = 0;
			this.armorName = "draconic scales";
			this.armorDef = 25;
			this.bonusHP = 700;
			this.lust = 40;
			this.bonusLust = 50;
			this.lustVuln = .4;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 18;
			this.gems = rand(45) + 80;
			this.additionalXP = 200;
			this.drop = NO_DROP;
			checkMonster();
		}	
	}

}