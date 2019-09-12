package classes.Items.Consumables 
{
	import classes.BodyParts.*;
	import classes.GlobalFlags.*;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;
	import classes.Vagina;
	import classes.CockTypesEnum;
	
	/**
	 * @since June 23, 2019
	 * @author Kitteh6660
	 */
	public class OmnibiJuice extends Consumable
	{
		public static const TAINTED:int  = 0;
		public static const PURIFIED:int = 1;
		
		private var tainted:Boolean;
		
		public function OmnibiJuice(type:int) 
		{
			var id:String;
			var shortName:String;
			var longName:String;
			var description:String;
			var value:int;
			
			tainted = type === TAINTED;
			
			switch (type) {
				case TAINTED:
					id = "OmniJuc";
					shortName = "Omni Juice";
					longName = "a vial of Omnibi juice";
					description = 'This concoction, in what appears to be a crystalline vial, a translucent, milky brew seen nothing but a myth till now, is a flask of Omnibi Juice.'
					value = 20;
					break;
				case PURIFIED:
					id = "POmniJc";
					shortName = "P.OmniJuice";
					longName = "an untainted vial of Omnibi juice";
					description = 'This concoction, in what appears to be a crystalline vial, a translucent, milky brew seen nothing but a myth till now, is a flask of Omnibi Juice.'
					             +' This has been purified by Rathazul to prevent corruption.';
					value = 40;
					break;
				default: // Nothing here.
			}
			
			super(id, shortName, longName, value, description);
		}
		
		override public function useItem():Boolean
		{
			var tfSource:String = "omnibiJuice";
			if (!tainted) tfSource += "-purified";
			var temp:int;
			player.slimeFeed();
			var temp2:Number = 0;
			var temp3:Number = 0;
			var rando:Number = rand(100);
			if (player.hasPerk(PerkLib.HistoryAlchemist)) rando += 10;
			if (player.hasPerk(PerkLib.TransformationResistance)) rando -= 5 + rand(5);
			clearOutput();
			outputText("The juice feels so thick and creamy, sticky as well, hard to swallow. It has a sweet, milky aftertaste as if you are suckling from a lactating tit. The aroma that of a slutty cunt riding your face is near intoxicating. Then the other, barely noticeable twang, salty with a bit of sweetness you cannot place. ");
			if (player.cor <= 33) outputText("Just swallowing it makes you feel unclean.");
			if (player.cor > 33 && player.cor <= 66) outputText("Reminding you of something you just can't place.");
			if (player.cor > 66) outputText("Deliciously sinful in all the right ways.");
			if (player.cor >= 90) outputText(" You're sure what it must be distilled from: the cum of an incubus, the milk of a succubus, the love juices that flow from an omnibus, and the subtle, almost hidden taste" + (flags[kFLAGS.WATERSPORTS_ENABLED] > 0 ? " that of omnibus pee" : " that you really do not want to know") + ".");
			//Lowlevel changes
			if (rando < 45) {
				if (player.cocks.length == 1) {
					if (player.cocks[0].cockType !== CockTypesEnum.DEMON) outputText("\n\nYour " + player.cockDescript(0) + " becomes shockingly hard.  It turns a shiny inhuman purple and spasms, dribbling hot demon-like cum as it begins to grow.");
					else outputText("\n\nYour " + player.cockDescript(0) + " becomes shockingly hard.  It dribbles hot demon-like cum as it begins to grow.");
					if (rand(4) === 0) temp = player.increaseCock(0, 3);
					else temp = player.increaseCock(0, 1);
					if (temp < .5) outputText("  It stops almost as soon as it starts, growing only a tiny bit longer.");
					if (temp >= .5 && temp < 1) outputText("  It grows slowly, stopping after roughly half an inch of growth.");
					if (temp >= 1 && temp <= 2) outputText("  The sensation is incredible as more than an inch of lengthened dick-flesh grows in.");
					if (temp > 2) outputText("  You smile and idly stroke your lengthening " + player.cockDescript(0) + " as a few more inches sprout.");
					if (tainted) dynStats("int", 1, "lib", 2, "sen", 1, "lus", 5 + temp * 3, "cor", 1);
					else dynStats("int", 1, "lib", 2, "sen", 1, "lus", 5 + temp * 3);
					if (player.cocks[0].cockType !== CockTypesEnum.DEMON) outputText("  With the transformation complete, your " + player.cockDescript(0) + " returns to its normal coloration.");
					else outputText("  With the transformation complete, your " + player.cockDescript(0) + " throbs in an almost happy way as it goes flaccid once more.");
				}
				if (player.cocks.length > 1) {
					temp = player.cocks.length;
					temp2 = 0;
					//Find shortest cock
					while (temp > 0) {
						temp--;
						if (player.cocks[temp].cockLength <= player.cocks[temp2].cockLength) {
							temp2 = temp;
						}
					}
					if (rand(4) === 0) temp3 = player.increaseCock(temp2, 3);
					else temp3 = player.increaseCock(temp2, 1);
					if (tainted) dynStats("int", 1, "lib", 2, "sen", 1, "lus", 5 + temp * 3, "cor", 1);
					else dynStats("int", 1, "lib", 2, "sen", 1, "lus", 5 + temp * 3);
					//Grammar police for 2 cocks
					if (player.cockTotal() == 2) outputText("\n\nBoth of your " + player.multiCockDescriptLight() + " become shockingly hard, swollen and twitching as they turn a shiny inhuman purple in color.  They spasm, dripping thick ropes of hot demon-like pre-cum along their lengths as your shortest " + player.cockDescript(temp2) + " begins to grow.");
					//For more than 2
					else outputText("\n\nAll of your " + player.multiCockDescriptLight() + " become shockingly hard, swollen and twitching as they turn a shiny inhuman purple in color.  They spasm, dripping thick ropes of hot demon-like pre-cum along their lengths as your shortest " + player.cockDescript(temp2) + " begins to grow.");

					if (temp3 < .5) outputText("  It stops almost as soon as it starts, growing only a tiny bit longer.");
					if (temp3 >= .5 && temp3 < 1) outputText("  It grows slowly, stopping after roughly half an inch of growth.");
					if (temp3 >= 1 && temp3 <= 2) outputText("  The sensation is incredible as more than an inch of lengthened dick-flesh grows in.");
					if (temp3 > 2) outputText("  You smile and idly stroke your lengthening " + player.cockDescript(temp2) + " as a few more inches sprout.");
					outputText("  With the transformation complete, your " + player.multiCockDescriptLight() + " return to their normal coloration.");
				}
				//NO CAWKS?
				if (player.cocks.length == 0) {
					outputText("\n\n");
					mutations.growDemonCock(1);
					if (tainted) dynStats("lib", 3, "sen", 5, "lus", 10, "cor", 4);
					else dynStats("lib", 3, "sen", 5, "lus", 10);
				}
				//NO VAGORZ?
				if (player.vaginas.length == 0) {
					player.createVagina();
					player.vaginas[0].vaginalLooseness = Vagina.LOOSENESS_TIGHT;
					player.vaginas[0].vaginalWetness = Vagina.WETNESS_NORMAL;
					player.vaginas[0].virgin = true;
					player.setClitLength(.25);
					if (player.fertility <= 5) player.fertility = 6;
					outputText("\n\nAn itching starts in your crotch and spreads vertically.  You reach down and discover an opening.  You have grown a <b>new " + player.vaginaDescript(0) + "</b>!");
				}
			}
			//Mid-level changes
			else if (rando < 85) {
				if (player.cocks.length > 1) {
					outputText("\n\nYour cocks fill to full-size... and begin growing obscenely.  ");
					temp = player.cocks.length;
					while (temp > 0) {
						temp--;
						temp2 = player.increaseCock(temp, rand(3) + 2);
						temp3 = player.cocks[temp].thickenCock(1);
						if (temp3 < .1) player.cocks[temp].cockThickness += .05;
					}
					player.lengthChange(temp2, player.cocks.length);
					//Display the degree of thickness change.
					if (temp3 >= 1) {
						if (player.cocks.length == 1) outputText("\n\nYour cock spreads rapidly, swelling an inch or more in girth, making it feel fat and floppy.");
						else outputText("\n\nYour cocks spread rapidly, swelling as they grow an inch or more in girth, making them feel fat and floppy.");
					}
					if (temp3 <= .5) {
						if (player.cocks.length > 1) outputText("\n\nYour cocks feel swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. They are definitely thicker.");
						else outputText("\n\nYour cock feels swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. It is definitely thicker.");
					}
					if (temp3 > .5 && temp2 < 1) {
						if (player.cocks.length == 1) outputText("\n\nYour cock seems to swell up, feeling heavier. You look down and watch it growing fatter as it thickens.");
						if (player.cocks.length > 1) outputText("\n\nYour cocks seem to swell up, feeling heavier. You look down and watch them growing fatter as they thicken.");
					}
					if (tainted) dynStats("lib", 3, "sen", 5, "lus", 10, "cor", 3);
					else dynStats("lib", 3, "sen", 5, "lus", 10);
				}
				if (player.cocks.length == 1) {
					outputText("\n\nYour cock fills to its normal size and begins growing... ");
					temp3 = player.cocks[0].thickenCock(1);
					temp2 = player.increaseCock(0, rand(3) + 2);
					player.lengthChange(temp2, 1);
					//Display the degree of thickness change.
					if (temp3 >= 1) {
						if (player.cocks.length == 1) outputText("  Your cock spreads rapidly, swelling an inch or more in girth, making it feel fat and floppy.");
						else outputText("  Your cocks spread rapidly, swelling as they grow an inch or more in girth, making them feel fat and floppy.");
					}
					if (temp3 <= .5) {
						if (player.cocks.length > 1) outputText("  Your cocks feel swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. They are definitely thicker.");
						else outputText("  Your cock feels swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. It is definitely thicker.");
					}
					if (temp3 > .5 && temp2 < 1) {
						if (player.cocks.length == 1) outputText("  Your cock seems to swell up, feeling heavier. You look down and watch it growing fatter as it thickens.");
						if (player.cocks.length > 1) outputText("  Your cocks seem to swell up, feeling heavier. You look down and watch them growing fatter as they thicken.");
					}
					if (tainted) dynStats("lib", 3, "sen", 5, "lus", 10, "cor", 3);
					else dynStats("lib", 3, "sen", 5, "lus", 10);
				}
				if (player.cocks.length == 0) {
					outputText("\n\n");
					mutations.growDemonCock(1);
					if (tainted) dynStats("lib", 3, "sen", 5, "lus", 10, "cor", 3);
					else dynStats("lib", 3, "sen", 5, "lus", 10);
				}
				//Gain pussy or wetten it!
				if (player.vaginas.length == 0) {
					player.createVagina();
					player.vaginas[0].vaginalLooseness = Vagina.LOOSENESS_TIGHT;
					player.vaginas[0].vaginalWetness = Vagina.WETNESS_NORMAL;
					player.vaginas[0].virgin = true;
					player.setClitLength(.25);
					if (player.fertility <= 5) player.fertility = 6;
					outputText("\n\nAn itching starts in your crotch and spreads vertically.  You reach down and discover an opening.  You have grown a <b>new " + player.vaginaDescript(0) + "</b>!");
				}
				if (player.vaginas.length > 0) {
					outputText("\n\n");
					//0 = dry, 1 = wet, 2 = extra wet, 3 = always slick, 4 = drools constantly, 5 = female ejaculator
					if (player.vaginas[0].vaginalWetness == Vagina.WETNESS_SLAVERING) {
						if (player.vaginas.length == 1) outputText("Your " + player.vaginaDescript(0) + " gushes fluids down your leg as you spontaneously orgasm.");
						else outputText("Your " + player.vaginaDescript(0) + "s gush fluids down your legs as you spontaneously orgasm, leaving a thick puddle of pussy-juice on the ground.  It is rapidly absorbed by the earth.");
						player.orgasm('Vaginal');
						if (tainted) dynStats("cor", 1);
					}
					if (player.vaginas[0].vaginalWetness == Vagina.WETNESS_DROOLING) {
						if (player.vaginas.length == 1) outputText("Your pussy feels hot and juicy, aroused and tender.  You cannot resist as your hands dive into your " + player.vaginaDescript(0) + ".  You quickly orgasm, squirting fluids everywhere.  <b>You are now a squirter</b>.");
						if (player.vaginas.length > 1) outputText("Your pussies feel hot and juicy, aroused and tender.  You cannot resist plunging your hands inside your " + player.vaginaDescript(0) + "s.  You quiver around your fingers, squirting copious fluids over yourself and the ground.  The fluids quickly disappear into the dirt.");
						player.orgasm('Vaginal');
						if (tainted) dynStats("cor", 1);
					}
					if (player.vaginas[0].vaginalWetness == Vagina.WETNESS_SLICK) {
						if (player.vaginas.length == 1) outputText("You feel a sudden trickle of fluid down your leg.  You smell it and realize it's your pussy-juice.  Your " + player.vaginaDescript(0) + " now drools lubricant constantly down your leg.");
						if (player.vaginas.length > 1) outputText("You feel sudden trickles of fluids down your leg.  You smell the stuff and realize it's your pussies-juices.  They seem to drool lubricant constantly down your legs.");
					}
					if (player.vaginas[0].vaginalWetness == Vagina.WETNESS_WET) {
						outputText("You flush in sexual arousal as you realize how moist your cunt-lips have become.  Once you've calmed down a bit you realize they're still slick and ready to fuck, and always will be.");
					}
					if (player.vaginas[0].vaginalWetness == Vagina.WETNESS_NORMAL) {
						if (player.vaginas.length == 1) outputText("A feeling of intense arousal passes through you, causing you to masturbate furiously.  You realize afterwards that your " + player.vaginaDescript(0) + " felt much wetter than normal.");
						else outputText("A feeling of intense arousal passes through you, causing you to masturbate furiously.  You realize afterwards that your " + player.vaginaDescript(0) + " were much wetter than normal.");
					}
					if (player.vaginas[0].vaginalWetness == Vagina.WETNESS_DRY) {
						outputText("You feel a tingling in your crotch, but cannot identify it.");
					}
					temp = player.vaginas.length;
					while (temp > 0) {
						temp--;
						if (player.vaginas[temp].vaginalWetness < Vagina.WETNESS_SLAVERING) player.vaginas[temp].vaginalWetness++;
					}
				}
			}
			//High level change
			else {
				if (player.cockTotal() < 10) {
					if (rand(10) < int(player.cor / 25)) {
						outputText("\n\n");
						mutations.growDemonCock(rand(2) + 2);
						if (tainted) dynStats("lib", 3, "sen", 5, "lus", 10, "cor", 5);
						else dynStats("lib", 3, "sen", 5, "lus", 10);
					}
					else {
						mutations.growDemonCock(1);
					}
					if (tainted) dynStats("lib", 3, "sen", 5, "lus", 10, "cor", 3);
					else dynStats("lib", 3, "sen", 5, "lus", 10);
				}
				if (player.biggestTitSize() >= 1) { 
					player.growTits(temp, player.breastRows.length, true, 3);
				}
			}
			//Neck restore
			if (player.neck.type !== Neck.NORMAL && changes < changeLimit && rand(4) === 0) {
				mutations.restoreNeck(tfSource);
			}
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) === 0) {
				mutations.restoreRearBody(tfSource);
			}
			//Ovi perk loss
			if (rand(5) === 0) {
				mutations.updateOvipositionPerk(tfSource);
			}
			//Demonic changes - higher chance with higher corruption.
			if (rand(40) + player.cor / 3 > 35 && tainted) {
				mutations.demonChanges(tfSource);
			}
			if (rand(4) === 0 && tainted) outputText(player.modFem(50, 2));
			if (rand(4) === 0 && tainted) outputText(player.modThickness(30, 2));
			player.refillHunger(10);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;

			return false;
		}
		
	}

}