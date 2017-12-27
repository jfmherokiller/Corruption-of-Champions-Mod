﻿

		// Lookup dictionary for converting any single argument brackets into it's corresponding string
		// basically [armor] results in the "[armor]" segment of the string being replaced with the
		// results of the corresponding anonymous function, in this case: function():* {return player.armorName;}
		// tags not present in the singleArgConverters object return an error message.
		//
		//Calls are now made through kGAMECLASS rather than thisPtr. This allows the compiler to detect if/when a function is inaccessible.
		import classes.GlobalFlags.kFLAGS;
		import classes.GlobalFlags.kGAMECLASS;
		import classes.internals.Utils;
		
		public var singleArgConverters:Object =
		{
				// all the errors related to trying to parse stuff if not present are
				// already handled in the various *Descript() functions.
				// no need to duplicate them.

				// Note: all key strings MUST be ENTIRELY lowercase.

				"agility"					: function():* { return "[Agility]"; },
				"allbreasts"				: function():* { return kGAMECLASS.player.allBreastsDescript(); },
				"alltits"				    : function():* { return kGAMECLASS.player.allBreastsDescript(); },
				"armor"						: function():* { return kGAMECLASS.player.armorName;},
				"armorname"					: function():* { return kGAMECLASS.player.armorName;},
				"ass"						: function():* { return kGAMECLASS.player.buttDescript();},
				"asshole"					: function():* { return kGAMECLASS.player.assholeDescript(); },
				"balls"						: function():* { return kGAMECLASS.player.ballsDescriptLight(); },
				"bodytype"					: function():* { return kGAMECLASS.player.bodyType(); },
				"boyfriend"					: function():* { return kGAMECLASS.player.mf("boyfriend", "girlfriend"); },
				"breasts"					: function():* { return kGAMECLASS.player.breastDescript(0); },
				"lastbreasts"				: function():* { return kGAMECLASS.player.breastDescript(-1); },
				"butt"						: function():* { return kGAMECLASS.player.buttDescript();},
				"butthole"					: function():* { return kGAMECLASS.player.assholeDescript();},
				"chest"						: function():* { return kGAMECLASS.player.chestDesc(); },
				"claws"						: function():* { return kGAMECLASS.player.clawsDescript(); },
				"clit"						: function():* { return kGAMECLASS.player.clitDescript(); },
				"cock"						: function():* { return kGAMECLASS.player.cockDescript(0);},
				"cockhead"					: function():* { return kGAMECLASS.player.cockHead(0);},
				"cocks"						: function():* { return kGAMECLASS.player.multiCockDescriptLight(); },
				"cunt"						: function():* { return kGAMECLASS.player.vaginaDescript(); },
				"eachcock"					: function():* { return kGAMECLASS.player.sMultiCockDesc();},
				"evade"						: function():* { return "[Evade]"; },
				"extraeyes"					: function():* { return kGAMECLASS.player.extraEyesDescript();},
				"extraeyesshort"			: function():* { return kGAMECLASS.player.extraEyesDescriptShort();},
				"eyes"						: function():* { return kGAMECLASS.player.eyesDescript();},
				"eyecount"					: function():* { return kGAMECLASS.player.eyes.count;},
				"face"						: function():* { return kGAMECLASS.player.faceDescript(); },
				"feet"						: function():* { return kGAMECLASS.player.feet(); },
				"foot"						: function():* { return kGAMECLASS.player.foot(); },
				"fullchest"					: function():* { return kGAMECLASS.player.allChestDesc(); },
				"furcolor"					: function():* { return kGAMECLASS.player.skin.furColor; },
				"hair"						: function():* { return kGAMECLASS.player.hairDescript(); },
				"haircolor"					: function():* { return kGAMECLASS.player.hair.color; },
				"hairorfur"					: function():* { return kGAMECLASS.player.hairOrFur(); },
				"hairorfurcolors"			: function():* { return kGAMECLASS.player.hairOrFurColors; },
				"he"						: function():* { return kGAMECLASS.player.mf("he", "she"); },
				"he2"						: function():* { return kGAMECLASS.player2.mf("he", "she"); },
				"him"						: function():* { return kGAMECLASS.player.mf("him", "her"); },
				"him2"						: function():* { return kGAMECLASS.player2.mf("him", "her"); },
				"himself"					: function():* { return kGAMECLASS.player.mf("himself", "herself"); },
				"herself"					: function():* { return kGAMECLASS.player.mf("himself", "herself"); },
				"hips"						: function():* { return kGAMECLASS.player.hipDescript();},
				"his"						: function():* { return kGAMECLASS.player.mf("his", "her"); },
				"his2"						: function():* { return kGAMECLASS.player2.mf("his", "her"); },
				"horns"						: function():* { return kGAMECLASS.player.hornDescript(); },
				"leg"						: function():* { return kGAMECLASS.player.leg(); },
				"legcounttext"				: function():* { return Utils.num2Text(kGAMECLASS.player.lowerBody.legCount); },
				"legcounttextuc"			: function():* { return Utils.Num2Text(kGAMECLASS.player.lowerBody.legCount); },
				"legs"						: function():* { return kGAMECLASS.player.legs(); },
				"lowergarment"				: function():* { return kGAMECLASS.player.lowerGarmentName; },
				"man"						: function():* { return kGAMECLASS.player.mf("man", "woman"); },
				"men"						: function():* { return kGAMECLASS.player.mf("men", "women"); },
				"malefemaleherm"			: function():* { return kGAMECLASS.player.maleFemaleHerm(); },
				"master"					: function():* { return kGAMECLASS.player.mf("master","mistress"); },
				"misdirection"				: function():* { return "[Misdirection]"; },
				"multicock"					: function():* { return kGAMECLASS.player.multiCockDescriptLight(); },
				"multicockdescriptlight"	: function():* { return kGAMECLASS.player.multiCockDescriptLight(); },
				"name"						: function():* { return kGAMECLASS.player.short;},
				"neck"						: function():* { return kGAMECLASS.player.neckDescript(); },
				"neckcolor"					: function():* { return kGAMECLASS.player.neck.color;},
				"nipple"					: function():* { return kGAMECLASS.player.nippleDescript(0);},
				"nipples"					: function():* { return kGAMECLASS.player.nippleDescript(0) + "s";},
				"lastnipple"				: function():* { return kGAMECLASS.player.nippleDescript(-1);},
				"lastnipples"				: function():* { return kGAMECLASS.player.nippleDescript(-1) + "s";},
				"onecock"					: function():* { return kGAMECLASS.player.oMultiCockDesc();},
				"pg"						: function():* { return "\n\n";},
				"pussy"						: function():* { return kGAMECLASS.player.vaginaDescript(); },
				"race"						: function():* { return kGAMECLASS.player.race(); },
				"rearbody"					: function():* { return kGAMECLASS.player.rearBodyDescript(); },
				"rearbodycolor"				: function():* { return kGAMECLASS.player.rearBody.color; },
				"sack"						: function():* { return kGAMECLASS.player.sackDescript(); },
				"sheath"					: function():* { return kGAMECLASS.player.sheathDescript(); },
				"shield"					: function():* { return kGAMECLASS.player.shieldName; },
				"skin"						: function():* { return kGAMECLASS.player.skinDescript(); },
				"skin.noadj"				: function():* { return kGAMECLASS.player.skinDescript(true); },
				"skindesc"					: function():* { return kGAMECLASS.player.skin.desc; },
				"skinfurscales"				: function():* { return kGAMECLASS.player.skinFurScales(); },
				"skintone"					: function():* { return kGAMECLASS.player.skin.tone; },
				"tallness"					: function():* { return kGAMECLASS.measurements.footInchOrMetres(kGAMECLASS.player.tallness); },
				"tits"						: function():* { return kGAMECLASS.player.breastDescript(0); },
				"lasttits"					: function():* { return kGAMECLASS.player.breastDescript(-1); },
				"breastcup"					: function():* { return kGAMECLASS.player.breastCup(0); },
				"lastbreastcup"				: function():* { return kGAMECLASS.player.breastCup(-1); },
				"tongue"					: function():* { return kGAMECLASS.player.tongueDescript(); },
				"underbody.skinfurscales"	: function():* { return kGAMECLASS.player.underBody.skinFurScales(); },
				"underbody.skintone"		: function():* { return kGAMECLASS.player.underBody.skin.tone; },
				"underbody.furcolor"		: function():* { return kGAMECLASS.player.underBody.skin.furColor; },
				"uppergarment"				: function():* { return kGAMECLASS.player.upperGarmentName; },
				"vag"						: function():* { return kGAMECLASS.player.vaginaDescript(); },
				"vagina"					: function():* { return kGAMECLASS.player.vaginaDescript(); },
				"vagorass"					: function():* { return (kGAMECLASS.player.hasVagina() ? kGAMECLASS.player.vaginaDescript() : kGAMECLASS.player.assholeDescript()); },
				"weapon"					: function():* { return kGAMECLASS.player.weaponName;},
				"weaponname"				: function():* { return kGAMECLASS.player.weaponName; },
				"latexyname"				: function():* { return kGAMECLASS.flags[kFLAGS.GOO_NAME]; },
				"bathgirlname"				: function():* { return kGAMECLASS.flags[kFLAGS.MILK_NAME]; },
				"cockplural"				: function():* { return (kGAMECLASS.player.cocks.length == 1) ? "cock" : "cocks"; },
				"dickplural"				: function():* { return (kGAMECLASS.player.cocks.length == 1) ? "dick" : "dicks"; },
				"headplural"				: function():* { return (kGAMECLASS.player.cocks.length == 1) ? "head" : "heads"; },
				"prickplural"				: function():* { return (kGAMECLASS.player.cocks.length == 1) ? "prick" : "pricks"; },
				"boy"						: function():* { return kGAMECLASS.player.mf("boy", "girl"); },
				"guy"						: function():* { return kGAMECLASS.player.mf("guy", "girl"); },
				"wings"						: function():* { return kGAMECLASS.player.wingsDescript(); },
				"wingcolor"					: function():* { return kGAMECLASS.player.wings.color; },
				"tail"						: function():* { return kGAMECLASS.player.tailDescript(); },
				"onetail"					: function():* { return kGAMECLASS.player.oneTailDescript(); },

				//Monster strings
				"monster.short"				: function():* { return kGAMECLASS.monster.short; },
				"monster.a"					: function():* { return kGAMECLASS.monster.a; },
				"monster.capitala"			: function():* { return kGAMECLASS.monster.capitalA; },
				"monster.pronoun1"			: function():* { return kGAMECLASS.monster.pronoun1; },
				"monster.pronoun1caps"		: function():* { return kGAMECLASS.monster.Pronoun1; },
				"monster.pronoun2"			: function():* { return kGAMECLASS.monster.pronoun2; },
				"monster.pronoun2caps"		: function():* { return kGAMECLASS.monster.Pronoun2; },
				"monster.pronoun3"			: function():* { return kGAMECLASS.monster.pronoun3; },
				"monster.pronoun3caps"		: function():* { return kGAMECLASS.monster.Pronoun3; },

				//Prisoner
				"captortitle"				: function():* { return kGAMECLASS.prison.prisonCaptor.captorTitle; },
				"captorname"				: function():* { return kGAMECLASS.prison.prisonCaptor.captorName; },
				"captorhe"					: function():* { return kGAMECLASS.prison.prisonCaptor.captorPronoun1; },
				"captorhim"					: function():* { return kGAMECLASS.prison.prisonCaptor.captorPronoun2; },
				"captorhis"					: function():* { return kGAMECLASS.prison.prisonCaptor.captorPronoun3; }
				
		}
