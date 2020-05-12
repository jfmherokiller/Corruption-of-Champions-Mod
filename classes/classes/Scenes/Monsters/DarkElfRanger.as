/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Monsters 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.internals.*;

public class DarkElfRanger extends DarkElfScout
	{
		override public function DarkElfBowShooting():void
		{
			var Acc:Number = 0;
			Acc += (this.spe - player.spe);
			if (Acc < 0) Acc = 0;
			outputText("The black skinned elf aims her bow at you, drawing several arrows and starts shooting.\n\n");
			PoisonedBowShoot();
			if (rand(100) < (90 + Acc)) PoisonedBowShoot();
			else outputText("An arrow missed you.\n\n");
			if (rand(100) < (80 + Acc)) PoisonedBowShoot();
			else outputText("An arrow missed you.\n\n");
			if (rand(100) < (70 + Acc)) PoisonedBowShoot();
			else outputText("An arrow missed you.\n\n");
			if (rand(100) < (60 + Acc)) PoisonedBowShoot();
			else outputText("An arrow missed you.\n\n");
		}
		
		public function DarkElfRanger() 
		{
			this.a = "the ";
			this.short = "dark elf ranger";
			this.imageName = "dark elf";
			this.long = "This woman with dark skin has long pointed ears. You suspect her to be a dark elf, though why she’s here on the surface, you have no idea. Regardless, she’s dangerous and seems well equipped for kidnapping.";
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 30, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_MOIST;
			this.tallness = 72;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.lowerBody = LowerBody.ELF;
			this.skinTone = "dark";
			this.hairColor = "silver";
			this.hairLength = 13;
			initStrTouSpeInte(90, 130, 190, 100);
			initWisLibSensCor(100, 70, 80, 90);
			this.weaponName = "dagger";
			this.weaponVerb= "stab";
			this.weaponAttack = 5;
			this.weaponRangeName = "elven bow";
			this.weaponRangeVerb= "shoot";
			this.weaponRangeAttack = 30;
			this.armorName = "elven armor";
			this.armorDef = 12;
			this.armorMDef = 12;
			this.bonusLust = 20;
			this.lustVuln = .7;
			this.lust = 50;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 39;
			this.gems = rand(10) + 20;
			this.drop = new WeightedDrop().
					add(weaponsrange.BOWLIGH,1).
					add(consumables.ELFEARS,4);
			checkMonster();
		}	
	}
}