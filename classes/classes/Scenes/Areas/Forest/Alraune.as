/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Forest 
{
	import classes.*;
	import classes.GlobalFlags.*;
	import classes.internals.ChainedDrop;

	public class Alraune extends Monster
	{
		public function trapLevel(adjustment:Number = 0):Number {
			if(!hasStatusEffect(StatusEffects.Level)) createStatusEffect(StatusEffects.Level,6,0,0,0);
			if(adjustment != 0) {
				addStatusValue(StatusEffects.Level,1,adjustment);
				if(statusEffectv1(StatusEffects.Level) < 1) changeStatusValue(StatusEffects.Level,1,1);
				if(statusEffectv1(StatusEffects.Level) > 6) changeStatusValue(StatusEffects.Level,1,6);
			}
			return statusEffectv1(StatusEffects.Level);
		}
		
		public function alrauneWait():void {
			clearOutput();
			outputText("You struggle against the alraune vines, forcefully pulling yourself a good distance away from her.\n\n");
			trapLevel(2);
			player.fatigue += 50;
			doAI();
		}
		
		public function alraunePollenCloud():void {
			clearOutput();
			outputText("The alraune giggles as she unleashes a thick cloud of pollen in your general direction.\n\n");
			outputText("\"<i>Just give in to me. I will make it so pleasurable for you.</i>\"\n\n");
			outputText("There is no way you will be able to not breathe it in and you feel your desire rise as the insidious aphrodisiac does its dirty work.\n\n");
			createStatusEffect(StatusEffects.LustAura, 0, 0, 0, 0);
		}
		
		public function alrauneStrangulate():void {
			clearOutput();
			outputText("The Alraune’s vines suddenly wrap tight around your neck and strangle you, preventing you from pronouncing any incantations. The plant woman gives you an annoyed glare.");
			outputText("\"<i>I’m done with your magic. Be a good " + player.mf("boy", "girl") + " and just give in.</i>\"");
			player.removeStatusEffect(StatusEffects.CastedSpell);
			player.createStatusEffect(StatusEffects.Sealed, 2, 10, 0, 0);
		}
		
		public function alrauneTeaseAttack():void {
			clearOutput();
			if (rand(2) == 1) {
				outputText("The alraune parts her grass-like hair away to reveal her supple breasts, moving her other hand to her nectar drenched pussy then back to her mouth. She sensually licks her fingers clean, then blows you a kiss.\n\n");
				outputText("\"<i>Don’t you want a taste of what my lovely body can offer? It is all yours to play with, all you need to do is give in to me.</i>\"\n\n");
			}
			else {
				outputText("The alraune grabs some of her nectar suggestively, letting it flow all over her breast, thigh and even in her hair.\n\n");
				outputText("\"<i>Mmmmmmm I so love being covered in sticky fluids. How about you?</i>\"\n\n");
			}
			outputText("Unable to take your gaze away from her lewd show, you feel yourself getting more aroused. ");
			var lustDmg:int = rand(player.lib / 20) + rand(this.lib / 10) + 10;
			game.dynStats("lus", lustDmg);
			outputText("\n\n");
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.Level)) {
				if (!hasStatusEffect(StatusEffects.Stunned) && player.hasStatusEffect(StatusEffects.CastedSpell)) alrauneStrangulate();
				else {
					var choice:Number = rand(2);
					if (choice == 0) alrauneTeaseAttack();
					if (choice == 1) {
						if (!hasStatusEffect(StatusEffects.LustAura)) alraunePollenCloud();
						else alrauneTeaseAttack();
					}
				}
				if (!hasStatusEffect(StatusEffects.Climbed)) {
					outputText("\n\nMeanwhile the vines keep pulling you toward the pitcher.");
					trapLevel(-1);
				}
				else removeStatusEffect(StatusEffects.Climbed);
				combatRoundOver();
			}
			else super.performCombatAction();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.forest.alrauneScene.alrauneDeepwoodsWon();
		}

		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			game.forest.alrauneScene.alrauneDeepwoodsLost();
		}
		
		public function Alraune() 
		{
			super();
			this.a = "an ";
			this.short = "alraune";
			this.imageName = "alraune";
			this.long = "You are fighting against an alraune, an intelligent plant with the torso of a woman and the lower body of a giant flower. She seems really keen on raping you.";
			this.createVagina(false, VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_GAPING);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = ANAL_LOOSENESS_STRETCHED;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.tallness = rand(14) + 59;
			this.hipRating = HIP_RATING_CURVY+3;
			this.buttRating = BUTT_RATING_EXPANSIVE;
			this.lowerBody = LOWER_BODY_TYPE_PLANT_FLOWER;
			this.skinTone = "light green";
			this.hairColor = "dark green";
			this.hairLength = 6;
			initStrTouSpeInte(10, 100, 10, 60);
			initLibSensCor(100, 50, 0);
			this.weaponName = "fist";
			this.weaponVerb="punch";
			this.weaponAttack = 1 + (1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "skin";
			this.armorDef = 45 + (5 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 100;
			this.bonusLust = 20;
			this.lust = 20 + rand(40);
			this.lustVuln = 0.2;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 20;
			this.gems = rand(20) + 5;
			this.drop = new ChainedDrop().add(consumables.MARAFRU, 1 / 6)
				//	.add(consumables.W__BOOK, 1 / 4)
				//	.add(consumables.BEEHONY, 1 / 2)
				//	.elseDrop(useables.B_CHITN);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.FireVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyPlantType, 0, 0, 0, 0);
			this.createStatusEffect(StatusEffects.GenericRunDisabled, 0, 0, 0, 0);
			createStatusEffect(StatusEffects.Level,4,0,0,0);
			this.str += 2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 20 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 12 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 20 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 1680;
			checkMonster();
		}
		
	}

}