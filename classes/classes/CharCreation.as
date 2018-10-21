﻿package classes 
{
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Butt;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Gills;
import classes.BodyParts.Hair;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kCOUNTERS;
import classes.GlobalFlags.kFLAGS;
import classes.Items.*;
import classes.Scenes.Areas.Desert.SandWitchScene;
import classes.Scenes.Dungeons.DungeonAbstractContent;
import classes.Scenes.NPCs.JojoScene;
import classes.Scenes.NPCs.XXCNPC;
import classes.Scenes.SceneLib;
import classes.internals.CountersStorage;
import classes.internals.RootCounters;
import classes.lists.BreastCup;
import classes.lists.Gender;

import coc.view.MainView;

//import flash.events.MouseEvent;

	public class CharCreation extends BaseContent {
		
		public const MAX_TOLERANCE_LEVEL:int = 10;				//40 AP
		public const MAX_MORALSHIFTER_LEVEL:int = 10;			//40 AP
		public const MAX_DESIRES_LEVEL:int = 25;				//90 AP
		public const MAX_ENDURANCE_LEVEL:int = 25;				//90 AP
		public const MAX_HARDINESS_LEVEL:int = 25;				//90 AP
		public const MAX_SOULPURITY_LEVEL:int = 25;				//90 AP
		public const MAX_INNERPOWER_LEVEL:int = 25;				//90 AP
		public const MAX_FURY_LEVEL:int = 25;					//90 AP
		public const MAX_MYSTICALITY_LEVEL:int = 20;			//90 AP
		public const MAX_SPIRITUALENLIGHTENMENT_LEVEL:int = 20;	//90 AP
		public const MAX_WISDOM_LEVEL:int = 5;					//15 AP
		public const MAX_TRANSHUMANISM_LEVEL:int = 25;			//90 AP
		public const MAX_FORTUNE_LEVEL:int = -1;				//No maximum level.(845)
		public const MAX_VIRILITY_LEVEL:int = 10;				//40 AP
		public const MAX_FERTILITY_LEVEL:int = 10;				//40 AP
		
		private var specialCharacters:CharSpecial = new CharSpecial();
		private var customPlayerProfile:Function;
		
//		private var boxNames:ComboBox;
		
		public function CharCreation() {}
		
		public function newGameFromScratch():void {
			flags[kFLAGS.NEW_GAME_PLUS_LEVEL] = 0;
			newGameGo();
		}
		
		public function newGamePlus():void {
			flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] = player.XP;
			if (flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] == 0) flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] = 1;
			while (player.level > 1) {
				flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] += player.level * 100;
				player.level--;
			}
			flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_ITEMS] = player.gems;
			newGameGo();
		}
		
		public function newGameGo():void {
			XXCNPC.unloadSavedNPCs();
			mainView.eventTestInput.x = -10207.5;
			mainView.eventTestInput.y = -1055.1;
			hideStats();
			hideUpDown();
			mainView.nameBox.visible = true;
			mainView.nameBox.width = 165;
			mainView.hideMenuButton( MainView.MENU_NEW_MAIN );
			mainView.hideMenuButton( MainView.MENU_DATA );
			mainView.hideMenuButton( MainView.MENU_LEVEL );
			mainView.hideMenuButton( MainView.MENU_PERKS );
			//Hide perk boxes
			mainView.hideComboBox();
			//If first PC, track status of EZ mode and other such nonsense.
			var silly:Boolean = flags[kFLAGS.SILLY_MODE_ENABLE_FLAG];
			var easy:Boolean = flags[kFLAGS.EASY_MODE_ENABLE_FLAG];
			var sprite:Boolean = flags[kFLAGS.SHOW_SPRITES_FLAG];
			mainView.setButtonText(0, "Newgame"); // b1Text.text = "Newgame";
			//flags[kFLAGS.CUSTOM_PC_ENABLED] = 0;
			
			var showSpecialNames:Boolean = true; // achievements[kACHIEVEMENTS.STORY_FINALBOSS] > 0;			
			
			clearOutput();
			outputText("You grew up in the small village of Ingnam, a remote village with rich traditions, buried deep in the wilds.  Every year for as long as you can remember, your village has chosen a champion to send to the cursed Demon Realm.  Legend has it that in years Ingnam has failed to produce a champion, chaos has reigned over the countryside.  Children disappear, crops wilt, and disease spreads like wildfire.  This year, <b>you</b> have been selected to be the champion.\n\n");
			//if (showSpecialNames) outputText("\n\n\n\n");			
			outputText("What is your name?");
		
			/*CODE FROM CMACLOAD HERE
			Multiple line case. A text field GeneralTextField, positioning a movieclip AskQuestions below it
			GeneralTextField.wordWrap = true;
			GeneralTextField.autoSize = true;
			GeneralTextField.htmlText = &quot;whatevevr.......&quot;;
			AskQuestions._x = GeneralTextField._x;
			AskQuestions._y = GeneralTextField._y + 3 + GeneralTextField._height;
			again replace _x, _y, _width with x, y, width*/
			//mainView.mainText.autoSize = true;
		
			//mainView.mainText.autoSize = TextFieldAutoSize.LEFT;
			menu();
			addButton(0, "OK", chooseName);
		//	simpleChoices("OK",10034,"",0,"",0,"",0,"",0);
			mainView.nameBox.x = mainView.mainText.x + 5;
			mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
		
			//OLD
			//mainView.nameBox.x = 510;
			//mainView.nameBox.y = 265;
			mainView.nameBox.text = "";
			mainView.nameBox.maxChars = 16;
			mainView.nameBox.restrict = null;
			
			var preList:Array = [];
			//function _add(element:Array):void{preList.push({label: element[0], data:element});}
			//if (CoC_Settings.debugBuild) preList.push( { label: "TestChar", data: [ "TestChar", customTestChar, true, "For debug." ]} );			
			for (var t:int = 0; t < specialCharacters.customs.length; t++) preList.push( { label: specialCharacters.customs[t][0], data:specialCharacters.customs[t] } );

			if (showSpecialNames) {
				CoC.instance.showComboBox(preList,"Pre-defined characters",selectName);
				mainView.placeComboBox(mainView.nameBox.x + mainView.nameBox.width + 10,mainView.nameBox.y);
			}

			//RESET DUNGEON
			DungeonAbstractContent.inDungeon = false;
			DungeonAbstractContent.dungeonLoc = 0;
			DungeonAbstractContent.inRoomedDungeon = false;
			DungeonAbstractContent.inRoomedDungeonResume = null;
			//Hold onto old data for NG+
			var oldPlayer:Player = player;
			//Reset all standard stats
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) player = new Player();

            //Reset autosave
            if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
                player.slotName = "VOID";
                player.autoSave = false;
            }

			model.player = player;
			player.str = 15;
			player.tou = 15;
			player.spe = 15;
			player.inte = 15;
			player.wis = 15;
			player.sens = 15;
			player.lib = 15;
			player.cor = 15;
			player.soulforce = 50;
			player.wrath = 0;
			player.mana = 100;
			player.hunger = 80;
			player.obey = 10;
			player.esteem = 50;
			player.will = 80;
			player.lust = 15;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
				player.XP = flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP];
				player.level = 0;				
				player.gems = flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_ITEMS];
			}
			player.hairLength = 5;
			player.skin.restore();
			player.faceType = Face.HUMAN;
			player.tailType = Tail.NONE;
			player.tongue.type = Tongue.HUMAN;
			player.femininity = 50;
			player.beardLength = 0;
			player.beardStyle = 0;
			player.tone = 50;
			player.thickness = 50;
			player.skinDesc = "skin";
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
				player.balls = 0;
				player.ballSize = 0;
				player.clitLength = 0;
			}
			player.hoursSinceCum = 0;
			player.cumMultiplier = 1;
			player.ass.analLooseness = 0;
			player.ass.analWetness = 0;
			player.ass.fullness = 0;
			player.fertility = 5;
			player.fatigue = 0;
			player.horns.count = 0;
			player.tallness = 60;
			player.tailCount = 0;
			player.tailVenom = 0;
			player.tailRecharge = 0;
			player.gills.type = Gills.NONE;
			player.rearBody.type = RearBody.NONE;
			player.wings.type = Wings.NONE;
			player.wings.desc = "non-existant";
			//Default
			player.skinTone = "light";
			player.hairColor = "brown";
			player.hairType = Hair.NORMAL;
			player.beardLength = 0;
			player.beardStyle = 0;
			//Exploration
			player.explored = 0;
			player.exploredForest = 0;
			player.exploredDesert = 0;
			player.exploredMountain = 0;
			player.exploredLake = 0;
			//Inventory clear
			player.itemSlot1.unlocked = true;
			player.itemSlot1.emptySlot();
			player.itemSlot2.unlocked = true;
			player.itemSlot2.emptySlot();
			player.itemSlot3.unlocked = true;
			player.itemSlot3.emptySlot();
			player.itemSlot4.unlocked = false;
			player.itemSlot4.emptySlot();
			player.itemSlot5.unlocked = false;
			player.itemSlot5.emptySlot();
			player.itemSlot6.unlocked = false;
			player.itemSlot6.emptySlot();
			player.itemSlot7.unlocked = false;
			player.itemSlot7.emptySlot();
			player.itemSlot8.unlocked = false;
			player.itemSlot8.emptySlot();
			player.itemSlot9.unlocked = false;
			player.itemSlot9.emptySlot();
			player.itemSlot10.unlocked = false;
			player.itemSlot10.emptySlot();
            //PIERCINGS
            player.nipplesPierced = 0;
            player.nipplesPShort = "";
            player.nipplesPLong = "";
            player.lipPierced = 0;
            player.lipPShort = "";
            player.lipPLong = "";
            player.tonguePierced = 0;
            player.tonguePShort = "";
            player.tonguePLong = "";
            player.eyebrowPierced = 0;
            player.eyebrowPShort = "";
            player.eyebrowPLong = "";
            player.earsPierced = 0;
            player.earsPShort = "";
            player.earsPLong = "";
            player.nosePierced = 0;
            player.nosePShort = "";
            player.nosePLong = "";
            for each(var cock:Cock in player.cocks){
				cock.pierced = 0;
				cock.pShortDesc = "";
				cock.pLongDesc = "";
			}
			for each(var vagina:VaginaClass in player.vaginas){
				vagina.labiaPierced = 0;
                vagina.labiaPShort = "";
				vagina.labiaPLong = "";
				vagina.clitPierced = 0;
                vagina.clitPShort = "";
				vagina.clitPLong = "";
			}


			//PLOTZ
			JojoScene.monk                               = 0;
			SandWitchScene.rapedBefore = false;
		//Replaced by flag	CoC.instance.beeProgress = 0;
			SceneLib.isabellaScene.isabellaOffspringData = []; //CLEAR!
			//Lets get this bitch started
			CoC.instance.inCombat = false;
			DungeonAbstractContent.inDungeon = false;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
				//Clothes clear
				player.setArmor(armors.C_CLOTH);
				player.setWeapon(WeaponLib.FISTS);
				player.setWeaponRange(WeaponRangeLib.NOTHING);
				//Clear camp slots
				inventory.clearStorage();
				inventory.clearGearStorage();
				inventory.clearPearlStorage();
				//Initialize gearStorage
				inventory.initializeGearStorage();
				inventory.initializePearlStorage();
				//Clear cocks
				while(player.cocks.length > 0)
				{
					player.removeCock(0,1);
					trace("1 cock purged.");
				}
				//Clear vaginas
				while(player.vaginas.length > 0)
				{
					player.removeVagina(0,1);
					trace("1 vagina purged.");
				}
				//Clear breasts
				player.breastRows = [];
			}
			else {
				var hadOldCock:Boolean = player.hasCock();
				var hadOldVagina:Boolean = player.hasVagina();
				//Clear cocks
				while(player.cocks.length > 0)
				{
					player.removeCock(0,1);
					trace("1 cock purged.");
				}
				//Clear vaginas
				while(player.vaginas.length > 0)
				{
					player.removeVagina(0,1);
					trace("1 vagina purged.");
				}
				//Keep gender and normalize genitals.
				if (hadOldCock) player.createCock(5.5, 1, CockTypesEnum.HUMAN);
				if (hadOldVagina) player.createVagina(true);
				if (player.balls > 2) player.balls = 2;
				if (player.ballSize > 2) player.ballSize = 2;
				if (player.clitLength > 1.5) player.clitLength = 1.5;
				while (player.breastRows.length > 1)
				{
					player.removeBreastRow(1, 1);
				}
				if (player.nippleLength > 0.25) player.nippleLength = 0.25;
				while (player.biggestTitSize() > 14) player.shrinkTits(true);
				//Sorry but you can't come, Valeria!
			//	if (!(oldPlayer.armor is GooArmor))
			//	player.setArmor(armors.C_CLOTH);
			}
			
			//Clear Statuses
			var statusTemp:Array = [];
			for (var i:int = 0; i < player.statusEffects.length; i++) {
				if (isSpecialStatus(player.statusEffects[i])) statusTemp.push(player.statusEffects[i]);
			}
			player.removeStatuses();
			if (statusTemp.length > 0) {
				for (i = 0; i < statusTemp.length; i++) {
					player.createStatusEffect(statusTemp[i].stype, statusTemp[i].value1, statusTemp[i].value2, statusTemp[i].value3, statusTemp[i].value4);
				}
			}
			//Clear perks
			var ascendPerkTemp:Array = [];
			for (i = 0; i < player.perks.length; i++) {
				if (isAscensionPerk(player.perks[i])) ascendPerkTemp.push(player.perks[i]);
			}
			player.removePerks();
			if (ascendPerkTemp.length > 0) {
				for (i = 0; i < ascendPerkTemp.length; i++) {
					player.createPerk(ascendPerkTemp[i].ptype, ascendPerkTemp[i].value1, ascendPerkTemp[i].value2, ascendPerkTemp[i].value3, ascendPerkTemp[i].value4);
				}
			}
			//Clear key items
			var keyItemTemp:Array = [];
			for (i = 0; i < player.keyItems.length; i++) {
				if (isSpecialKeyItem(player.keyItems[i].keyName)) keyItemTemp.push(player.keyItems[i]);
			}
			player.removeKeyItems();
			if (keyItemTemp.length > 0) {
				for (i = 0; i < keyItemTemp.length; i++) {
					player.createKeyItem(keyItemTemp[i].keyName, keyItemTemp[i].value1, keyItemTemp[i].value2, keyItemTemp[i].value3, keyItemTemp[i].value4);
				}
			}
			//player.perkPoints = player.level - 1;
			var newFlags:DefaultDict = new DefaultDict();
			if (player.hasKeyItem("Ascension") >= 0) {
				for each(var flag:int in [kFLAGS.NEW_GAME_PLUS_LEVEL, kFLAGS.HUNGER_ENABLED, kFLAGS.HARDCORE_MODE, kFLAGS.GAME_DIFFICULTY, kFLAGS.EASY_MODE_ENABLE_FLAG, kFLAGS.SFW_MODE, kFLAGS.WATERSPORTS_ENABLED, kFLAGS.SILLY_MODE_ENABLE_FLAG, kFLAGS.LOW_STANDARDS_FOR_ALL, kFLAGS.HYPER_HAPPY, kFLAGS.STAT_GAIN_MODE]) {
					newFlags[flag] = flags[flag];
				}
			}
			//Clear plot storage array!
			CoC.instance.flags = new DefaultDict();
			var countersStorage:CountersStorage = kCOUNTERS.create();
			kCOUNTERS.initialize(countersStorage);
			CoC.instance.counters = new RootCounters(countersStorage);
			CoC.instance.saves.loadPermObject();
			//Carry over data if new game plus.
			if (player.hasKeyItem("Ascension") >= 0) CoC.instance.flags = newFlags;
			//Set that jojo debug doesn't need to run
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_02999] = 3;
			//Time reset
			model.time.days = 0;
			model.time.hours = 0;
			model.time.minutes = 0;

		}
		
		private function chooseName():void {
			if (CoC.instance.testingBlockExiting) {
				// We're running under the testing script.
				// Stuff a name in the box and go go go
				mainView.nameBox.text = "Derpy";
				return;
			}
			if (mainView.nameBox.text == "") {
				//If part of newgame+, don't fully wipe.
				if (player.XP > 0 && player.explored == 0) {
					flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] = player.XP;
					if (flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] == 0) flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] = 1;
					while (player.level > 1) {
						flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] += player.level * 100;
						player.level--;
					}
					flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_ITEMS] = player.gems;
				}
				if (flags[kFLAGS.LETHICE_DEFEATED] > 0) renamePrompt();
				else newGameGo();
				outputText("\n\n\n<b>You must select a name.</b>");
				return;
			}
			clearOutput();
			mainView.hideComboBox();
			mainView.nameBox.visible = false;
			player.short = mainView.nameBox.text;
			if (flags[kFLAGS.LETHICE_DEFEATED] > 0) { //Dirty checking as the NG+ flag is incremented after reincarnating.
				clearOutput();
				outputText("You shall be known as [name] now.");
				ascensionMenu();
				return;
			}
			customPlayerProfile = customName(mainView.nameBox.text);
			menu();
			if (customPlayerProfile != null) {
				outputText("This name, like you, is special.  Do you live up to your name or continue on, assuming it to be coincidence?");
				addButton(0, "SpecialName", useCustomProfile);
				addButton(1, "Continue On", noCustomProfile);
			}
			else { //Proceed with normal character creation
				genericGenderChoice();
			}
		}
		
		private function genericGenderChoice():void {
			outputText("Are you a man or a woman?");
			menu();
			addButton(0, "Man", isAMan);
			addButton(1, "Woman", isAWoman);
			if (flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM] > 0) {
				outputText("\n\nOr a hermaphrodite as you've unlocked hermaphrodite option!");
				addButton(2, "Herm", isAHerm);
			}
		}
		
		private function useCustomProfile():void {
			clearOutput();
			if (specialName(player.short) != null) {
				outputText("Your name defines everything about you, and as such, it is time to wake...\n\n");
				flags[kFLAGS.HISTORY_PERK_SELECTED] = 1;
				completeCharacterCreation(); //Skip character creation, customPlayerProfile will be called in completeCharacterCreation
			}
			else {
				//After character creation the fact that customPlayerProfile is not null will activate a custom player setup 
				outputText("There is something different about you, but first, what is your basic gender?  An individual such as you may later overcome this, of course...\n\n");
				genericGenderChoice();
			}
		}
		
		private function noCustomProfile():void {
			clearOutput();
			customPlayerProfile = null;
			outputText("Your name carries little significance beyond it being your name.  What is your gender?");
			menu();
			addButton(0, "Man", isAMan);
			addButton(1, "Woman", isAWoman);
			if (flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM] > 0) {
				addButton(2, "Herm", isAHerm);
			}
		}
		
		private function selectName(selectedItem:*):void {
			if (selectedItem.data[0].length > 16) // not a name
				return;
			
			clearOutput();
			
			outputText("<b>" + selectedItem.data[0] + ":</b> " + selectedItem.data[3]);
			if(selectedItem.data[2])
				outputText("\n\nThis character have pre-defined history.");
			else
				outputText("\n\nThis character have no pre-defined history.");
				
			flushOutputTextToGUI();	
			mainView.nameBox.text = selectedItem.data[0];
		}
		
		//Determines if has character creation bonuses
		internal function customName(arg:String):Function {
			for (var i:int = 0; i < specialCharacters.customs.length; i++)
				if (specialCharacters.customs[i][0] == arg && !specialCharacters.customs[i][2])
					return specialCharacters.customs[i][1];
			return specialName(arg); //Must check against the special name list as well
		}
		
		//Does PC skip creation?
		private function specialName(arg:String):Function {
			for (var i:int = 0; i < specialCharacters.customs.length; i++)
				if (specialCharacters.customs[i][0] == arg && specialCharacters.customs[i][2])
					return specialCharacters.customs[i][1];
			return null;
		}
		
		private function isAMan():void {
			//Attributes
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
				player.str += 3;
				player.tou += 2;
			}
			//Body attributes
			player.fertility = 5;
			player.hairLength = 1;
			player.tallness = 71;
			player.tone = 60;
			
			//Genetalia
			player.balls = 2;
			player.ballSize = 1;
			player.clitLength = 0;
			player.createCock();
			player.cocks[0].cockLength = 5.5;
			player.cocks[0].cockThickness = 1;
			player.cocks[0].cockType = CockTypesEnum.HUMAN;
			player.cocks[0].knotMultiplier = 1;
			
			//Breasts
			player.createBreastRow();
			
			//Choices
			clearOutput();
			outputText("You are a man.  Your upbringing has provided you an advantage in strength and toughness.\n\nWhat type of build do you have?");
			simpleChoices("Lean", buildLeanMale, "Average", buildAverageMale, "Thick", buildThickMale, "Girly", buildGirlyMale, "", null);
		}

		private function isAWoman():void {
			//Attributes
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
				player.spe += 3;
				player.inte += 2;
			}
			//Body attributes
			player.fertility = 10;
			player.hairLength = 10;
			player.tallness = 67;
			player.tone = 30;
			
			//Genetalia
			player.balls = 0;
			player.ballSize = 0;
			player.createVagina();
			player.clitLength = 0.5;
			
			//Breasts
			player.createBreastRow();
			
			//Choices
			clearOutput();
			outputText("You are a woman.  Your upbringing has provided you an advantage in speed and intellect.\n\nWhat type of build do you have?");
			simpleChoices("Slender", buildSlenderFemale, "Average", buildAverageFemale, "Curvy", buildCurvyFemale, "Tomboyish", buildTomboyishFemale, "", null);
		}

		private function isAHerm():void {
			//Attributes
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
				player.str+=1;
				player.tou+=1;
				player.spe+=1;
				player.inte+= 1;
			}
			//Body attributes
			player.fertility = 10;
			player.hairLength = 10;
			player.tallness = 69;
			player.tone = 45;
			
			//Genetalia
			player.createVagina();
			player.clitLength = .5;
			player.createCock();
			player.cocks[0].cockLength = 5.5;
			player.cocks[0].cockThickness = 1;
			player.cocks[0].cockType = CockTypesEnum.HUMAN;
			player.cocks[0].knotMultiplier = 1;
			
			//Breasts
			player.createBreastRow();
			
			//Choices
			clearOutput();
			outputText("\n\nYou are a hermaphrodite.  Your upbringing has provided you an average in stats.\n\nWhat type of build do you have?");
			menu();
			addButton(0, "Fem. Slender", buildSlenderFemale).hint("Feminine build. \n\nWill make you a futanari.", "Feminine, Slender");
			addButton(1, "Fem. Average", buildAverageFemale).hint("Feminine build. \n\nWill make you a futanari.", "Feminine, Average");
			addButton(2, "Fem. Curvy", buildCurvyFemale).hint("Feminine build. \n\nWill make you a futanari.", "Feminine, Curvy");
			//addButton(4, "Androgynous", chooseBodyTypeAndrogynous);
			addButton(5, "Mas. Lean", buildLeanMale).hint("Masculine build. \n\nWill make you a maleherm.", "Masculine, Lean");
			addButton(6, "Mas. Average", buildAverageMale).hint("Masculine build. \n\nWill make you a maleherm.", "Masculine, Average");
			addButton(7, "Mas. Thick", buildThickMale).hint("Masculine build. \n\nWill make you a maleherm.", "Masculine, Thick");
		}
		
		
		private function buildLeanMale():void {
			player.str -= 1;
			player.spe += 1;
			
			player.femininity = 34;
			player.thickness = 30;
			player.tone += 5;
			
			player.breastRows[0].breastRating = BreastCup.FLAT;
			player.butt.type = Butt.RATING_TIGHT;
			player.hips.type = Hips.RATING_SLENDER;
			chooseComplexion();
		}

		private function buildSlenderFemale():void {
			player.str -= 1;
			player.spe += 1;
			
			player.femininity = 66;
			player.thickness = 30;
			player.tone += 5;
			
			player.breastRows[0].breastRating = BreastCup.B;
			player.butt.type = Butt.RATING_TIGHT;
			player.hips.type = Hips.RATING_AMPLE;
			chooseComplexion();
		}

		private function buildAverageMale():void {
			player.femininity = 30;
			player.thickness = 50;
			
			player.breastRows[0].breastRating = BreastCup.FLAT;
			player.butt.type = Butt.RATING_AVERAGE;
			player.hips.type = Hips.RATING_AVERAGE;
			chooseComplexion();
		}

		private function buildAverageFemale():void {
			player.femininity = 70;
			player.thickness = 50;
			
			player.breastRows[0].breastRating = BreastCup.C;
			player.butt.type = Butt.RATING_NOTICEABLE;
			player.hips.type = Hips.RATING_AMPLE;
			chooseComplexion();
		}

		private function buildThickMale():void {
			player.spe -= 4;
			player.str += 2;
			player.tou += 2;
			
			player.femininity = 29;
			player.thickness = 70;
			player.tone -= 5;
			
			player.breastRows[0].breastRating = BreastCup.FLAT;
			player.butt.type = Butt.RATING_NOTICEABLE;
			player.hips.type = Hips.RATING_AVERAGE;
			chooseComplexion();
		}

		private function buildCurvyFemale():void {
			player.spe -= 2;
			player.str += 1;
			player.tou += 1;
			
			player.femininity = 71;
			player.thickness = 70;
			
			player.breastRows[0].breastRating = BreastCup.D;
			player.butt.type = Butt.RATING_LARGE;
			player.hips.type = Hips.RATING_CURVY;
			chooseComplexion();
		}

		private function buildGirlyMale():void {
			player.str -= 2;
			player.spe += 2;
			
			player.femininity = 50;
			player.thickness = 50;
			player.tone = 26;
			
			player.breastRows[0].breastRating = BreastCup.A;
			player.butt.type = Butt.RATING_NOTICEABLE;
			player.hips.type = Hips.RATING_SLENDER;
			chooseComplexion();
		}

		private function buildTomboyishFemale():void {
			player.str += 1;
			player.spe -= 1;
			
			player.femininity = 56;
			player.thickness = 50;
			player.tone = 50;
			
			player.breastRows[0].breastRating = BreastCup.A;
			player.butt.type = Butt.RATING_TIGHT;
			player.hips.type = Hips.RATING_SLENDER;
			chooseComplexion();
		}

		private function chooseComplexion():void {
			clearOutput();
			outputText("What is your complexion?");
			menu();
			addButton(0, "Light", setComplexion, "light");
			addButton(1, "Fair", setComplexion, "fair");
			addButton(2, "Olive", setComplexion, "olive");
			addButton(3, "Dark", setComplexion, "dark");
			addButton(4, "Ebony", setComplexion, "ebony");
			addButton(5, "Mahogany", setComplexion, "mahogany");
			addButton(6, "Russet", setComplexion, "russet");
		}

		private function setComplexion(choice:String):void { //And choose hair
			player.skinTone = choice;
			clearOutput();
			outputText("You selected a " + choice + " complexion.\n\nWhat color is your hair?");
			menu();
			addButton(0, "Blonde", setHair, "blonde");
			addButton(1, "Brown", setHair, "brown");
			addButton(2, "Black", setHair, "black");
			addButton(3, "Red", setHair, "red");
			addButton(4, "Gray", setHair, "gray");
			addButton(5, "White", setHair, "white");
			addButton(6, "Auburn", setHair, "auburn");
		}

		private function setHair(choice:String):void {
			player.hairColor = choice;
			clearOutput();
			outputText("You have " + hairDescript() + ".\n\nYou will proceed to customization.");
			//chooseEndowment(false);
			chooseEyesColor();
		}
		
		private function chooseEyesColor():void {
			clearOutput();
			outputText("What is your eyes color?");
			menu();
			addButton(0, "Black", setEyesColor, "black");
			addButton(1, "Green", setEyesColor, "green");
			addButton(2, "Blue", setEyesColor, "blue");
			addButton(3, "Red", setEyesColor, "red");
			addButton(4, "White", setEyesColor, "white");
			addButton(5, "Brown", setEyesColor, "brown");
			addButton(6, "Yellow", setEyesColor, "yellow");
			addButton(7, "Grey", setEyesColor, "grey");
			addButton(8, "Purple", setEyesColor, "purple");
			addButton(10, "Silver", setEyesColor, "silver");
			addButton(11, "Golden", setEyesColor, "golden");
		}

		private function setEyesColor(choice:String):void { //And choose hair
			player.eyes.colour = choice;
			clearOutput();
			outputText("You selected a " + choice + " eyes color.\n\nYou will proceed to customization.");
			//chooseEndowment(false);
			genericStyleCustomizeMenu();
		}

		//-----------------
		//-- GENERAL STYLE
		//-----------------
		private function genericStyleCustomizeMenu():void {
			clearOutput();
			mainView.nameBox.visible = false;
			mainView.nameBox.maxChars = 16;
			mainView.nameBox.restrict = null;
			
			outputText("You can finalize your appearance customization before you proceed to perk selection. You will be able to alter your appearance through the usage of certain items.\n\n");
			outputText("Height: " + Math.floor(player.tallness / 12) + "'" + player.tallness % 12 + "\"\n");
			outputText("Skin tone: " + player.skinTone + "\n");
			outputText("Hair color: [haircolor]\n");
			outputText("Eyes color: [eyecolor]\n");
			if (player.hasCock()) {
				outputText("Cock size: " + player.cocks[0].cockLength + "\" long, " + player.cocks[0].cockThickness + "\" thick\n");
			}
			outputText("Breast size: " + player.breastCup(0) + "\n");
			menu();
			addButton(0, "Complexion", menuSkinComplexion);
			addButton(1, "Hair Color", menuHairColor);
			if (player.mf("m", "f") == "m") {
				if (player.hasBeard()) {
					outputText("Beard: " + player.beardDescript() + "\n");
				}
				addButton(2, "Beard Style", menuBeardSettings);
			}
			addButton(3, "Eyes Color", menuEyesColor);
			addButton(4, "Set Height", setHeight);
			if (player.hasCock()) addButton(5, "Cock Size", menuCockLength);
			addButton(6, "Breast Size", menuBreastSize);
			addButton(9, "Done", chooseEndowment, true);
		}

		//-----------------
		//-- SKIN COLOURS
		//-----------------
		private function menuSkinComplexion():void {
			clearOutput();
			outputText("What is your complexion?");
			menu();
			addButton(0, "Light", confirmComplexion, "light");
			addButton(1, "Fair", confirmComplexion, "fair");
			addButton(2, "Olive", confirmComplexion, "olive");
			addButton(3, "Dark", confirmComplexion, "dark");
			addButton(4, "Ebony", confirmComplexion, "ebony");
			addButton(5, "Mahogany", confirmComplexion, "mahogany");
			addButton(6, "Russet", confirmComplexion, "russet");
			addButton(14, "Back", genericStyleCustomizeMenu);
		}	
		private function confirmComplexion(complexion:String):void {
			player.skinTone = complexion;
			genericStyleCustomizeMenu();
		}

		//-----------------
		//-- HAIR COLOURS
		//-----------------
		private function menuHairColor():void {
			clearOutput();
			outputText("What is your hair color?");
			menu();
			addButton(0, "Blonde", chooseHairColor, "blonde");
			addButton(1, "Brown", chooseHairColor, "brown");
			addButton(2, "Black", chooseHairColor, "black");
			addButton(3, "Red", chooseHairColor, "red");
			addButton(4, "Gray", chooseHairColor, "gray");
			addButton(5, "White", chooseHairColor, "white");
			addButton(6, "Auburn", chooseHairColor, "auburn");
			addButton(14, "Back", genericStyleCustomizeMenu);
		}

		private function chooseHairColor(color:String = ""):void {
			player.hairColor = color;
			genericStyleCustomizeMenu();
		}

		//-----------------
		//-- BEARD STYLE
		//-----------------
		private function menuBeardSettings():void {
			clearOutput();
			outputText("You can choose your beard length and style.\n\n");
			outputText("Beard: " + player.beardDescript());
			menu();
			addButton(0, "Style", menuBeardStyle);
			addButton(1, "Length", menuBeardLength);
			addButton(14, "Back", genericStyleCustomizeMenu);
		}
		private function menuBeardStyle():void {
			clearOutput();
			outputText("What beard style would you like?");
			menu();
			addButton(0, "Normal", chooseBeardStyle, 0);
			addButton(1, "Goatee", chooseBeardStyle, 1);
			addButton(2, "Clean-cut", chooseBeardStyle, 2);
			addButton(3, "Mountainman", chooseBeardStyle, 3);
			addButton(14, "Back", menuBeardSettings);
		}
		private function chooseBeardStyle(choiceStyle:int = 0):void {
			player.beardStyle = choiceStyle;
			menuBeardSettings();
		}
		private function menuBeardLength():void {
			clearOutput();
			outputText("How long would you like your beard be? \n\nNote: Beard will slowly grow over time, just like in the real world. Unless you have no beard. You can change your beard style later in the game.");
			menu();
			addButton(0, "No Beard", chooseBeardLength, 0);
			addButton(1, "Trim", chooseBeardLength, 0.1);
			addButton(2, "Short", chooseBeardLength, 0.2);
			addButton(3, "Medium", chooseBeardLength, 0.5);
			addButton(4, "Mod. Long", chooseBeardLength, 1.5);
			addButton(5, "Long", chooseBeardLength, 3);
			addButton(6, "Very Long", chooseBeardLength, 6);
			addButton(14, "Back", chooseBeardLength);
		}
		private function chooseBeardLength(choiceLength:Number = 0):void {
			player.beardLength = choiceLength;
			menuBeardSettings();
		}
		
		//-----------------
		//-- EYES COLOURS
		//-----------------
		private function menuEyesColor():void {
			clearOutput();
			outputText("What is your eyes color?");
			menu();
			addButton(0, "Black", pickEyesColor, "black");
			addButton(1, "Green", pickEyesColor, "green");
			addButton(2, "Blue", pickEyesColor, "blue");
			addButton(3, "Red", pickEyesColor, "red");
			addButton(4, "White", pickEyesColor, "white");
			addButton(5, "Brown", pickEyesColor, "brown");
			addButton(6, "Yellow", pickEyesColor, "yellow");
			addButton(7, "Grey", pickEyesColor, "grey");
			addButton(8, "Purple", pickEyesColor, "purple");
			addButton(10, "Golden", pickEyesColor, "golden");
			addButton(11, "Silver", pickEyesColor, "silver");
			addButton(14, "Back", genericStyleCustomizeMenu);
		}

		private function pickEyesColor(color:String = ""):void {
			player.eyes.colour = color;
			genericStyleCustomizeMenu();
		}

		//-----------------
		//-- HEIGHT
		//-----------------
		private function setHeight():void {
			clearOutput();
			if (CoC.instance.testingBlockExiting)
			{
				// We're running under the testing script.
				// Stuff a number in the box and go go go
				mainView.nameBox.text = "69";
			}
			outputText("Set your height in inches.");
			outputText("\nYou can choose any height between 4 feet (48 inches) and 8 feet (96 inches).");
			mainView.nameBox.visible = true;
			mainView.nameBox.maxChars = 2;
			mainView.nameBox.restrict = "0-9";
			if (player.gender == 0)
			{
				mainView.nameBox.text = "69";
			}
			if (player.gender == 1)
			{
				mainView.nameBox.text = "71";
			}
			if (player.gender == 2)
			{
				mainView.nameBox.text = "67";
			}	
			if (player.gender == 3)
			{
				mainView.nameBox.text = "69";
			}
			menu();
			addButton(0, "OK", confirmHeight);
			addButton(4, "Back", genericStyleCustomizeMenu);
			mainView.nameBox.x = mainView.mainText.x + 5;
			mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
		}
		private function confirmHeight():void {
			mainView.nameBox.visible = false;
			if (int(mainView.nameBox.text) < 48)
			{
				clearOutput();
				outputText("That is below your minimum height choices!");
				//Off to the height selection!
				doNext(setHeight);
				return;
			}
			if (int(mainView.nameBox.text) > 96)
			{
				clearOutput();
				outputText("That is above your maximum height choices!");
				//Off to the height selection!
				doNext(setHeight);
				return;
			}
			if (mainView.nameBox.text == "")
			{
				clearOutput();
				outputText("Please input your height. Off you go to the height selection!");
				//Off to the height selection!
				doNext(setHeight);
				return;
			}
			player.tallness = int(mainView.nameBox.text);
			mainView.nameBox.maxChars = 16;
			mainView.nameBox.restrict = null;
			clearOutput();
			outputText("You'll be " + Math.floor(player.tallness / 12) + " feet and " + player.tallness % 12 + " inches tall. Is this okay with you?");
			doYesNo(genericStyleCustomizeMenu, setHeight);
		}

		//-----------------
		//-- COCK LENGTH
		//-----------------
		private function menuCockLength():void {
			clearOutput();
			outputText("You can choose a cock length between 4 and 8 inches. Your starting cock length will also affect starting cock thickness. \n\nCock type and size can be altered later in the game through certain items.");
			menu();
			addButton(0, "4\"", chooseCockLength, 4);
			addButton(1, "4.5\"", chooseCockLength, 4.5);
			addButton(2, "5\"", chooseCockLength, 5);
			addButton(3, "5.5\"", chooseCockLength, 5.5);
			addButton(4, "6\"", chooseCockLength, 6);
			addButton(5, "6.5\"", chooseCockLength, 6.5);
			addButton(6, "7\"", chooseCockLength, 7);
			addButton(7, "7.5\"", chooseCockLength, 7.5);
			addButton(8, "8\"", chooseCockLength, 8);
			addButton(14, "Back", genericStyleCustomizeMenu);
		}
		private function chooseCockLength(length:Number):void {
			player.cocks[0].cockLength = length;
			player.cocks[0].cockThickness = Math.floor(((length / 5) - 0.1) * 10) / 10;
			genericStyleCustomizeMenu();
		}

		//-----------------
		//-- BREAST SIZE
		//-----------------
		private function menuBreastSize():void {
			clearOutput();
			outputText("You can choose a breast size. Breast size may be altered later in the game.");
			menu();
			if (player.femininity < 50) addButton(0, "Flat", chooseBreastSize, 0);
			if (player.femininity < 60) addButton(1, "A-cup", chooseBreastSize, 1);
			if (player.femininity >= 40) addButton(2, "B-cup", chooseBreastSize, 2);
			if (player.femininity >= 50) addButton(3, "C-cup", chooseBreastSize, 3);
			if (player.femininity >= 60) addButton(4, "D-cup", chooseBreastSize, 4);
			if (player.femininity >= 70) addButton(5, "DD-cup", chooseBreastSize, 5);
			addButton(14, "Back", genericStyleCustomizeMenu);
		}
		private function chooseBreastSize(size:int):void {
			player.breastRows[0].breastRating = size;
			genericStyleCustomizeMenu();
		}

		//-----------------
		//-- STARTER PERKS
		//-----------------
		private function chooseEndowment(clear:Boolean):void {
			if (clear) clearOutput();
			outputText("Every person is born with a gift.  What's yours?");
			menu();
			addButton(0, "Strength", confirmEndowmentStrength);
			addButton(1, "Toughness", confirmEndowmentThoughness);
			addButton(2, "Speed", confirmEndowmentSpeed);
			addButton(3, "Smarts", confirmEndowmentSmarts);
			addButton(4, "Wise", confirmEndowmentWise);
			addButton(5, "Libido", confirmEndowmentLibido);
			addButton(6, "Touch", confirmEndowmentTouch);
			addButton(7, "Perversion", confirmEndowmentPerversion);
			if (player.hasCock()) {
				addButton(8, "Big Cock", confirmEndowmentBigCock);
				addButton(9, "Lots of Jizz", confirmEndowmentMessyOrgasms);
			}
			else {
				addButton(8, "Big Breasts", confirmEndowmentBigBreasts);
				addButton(9, "Big Clit", confirmEndowmentBigClit);
				addButton(10, "Fertile", confirmEndowmentFertile);
				addButton(11, "Wet Vagina", confirmEndowmentWetVagina);
			}
			if (player.gender == Gender.GENDER_HERM)
			{
				addButton(8, "Big Cock", confirmEndowmentBigCock);
				addButton(9, "Lots of Jizz", confirmEndowmentMessyOrgasms);
				addButton(10, "Big Breasts", confirmEndowmentBigBreasts);
				addButton(11, "Big Clit", confirmEndowmentBigClit);
				addButton(12, "Fertile", confirmEndowmentFertile);
				addButton(13, "Wet Vagina", confirmEndowmentWetVagina);
			}
		}

		private function confirmEndowmentStrength():void {
			clearOutput();
			outputText("Are you stronger than normal? (+5 Strength)\n\nStrength increases your combat damage, and your ability to hold on to an enemy or pull yourself away.");
			menu();
			addButton(0, "Yes", setEndowmentStrength);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentThoughness():void {
			clearOutput();
			outputText("Are you unusually tough? (+5 Toughness)\n\nToughness gives you more HP and increases the chances an attack against you will fail to wound you.");
			menu();
			addButton(0, "Yes", setEndowmentToughness);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentSpeed():void {
			clearOutput();
			outputText("Are you very quick?  (+5 Speed)\n\nSpeed makes it easier to escape combat and grapples.  It also boosts your chances of evading an enemy attack and successfully catching up to enemies who try to run.");
			menu();
			addButton(0, "Yes", setEndowmentSpeed);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentSmarts():void {
			clearOutput();
			outputText("Are you a quick learner?  (+5 Intellect)\n\nIntellect can help you avoid dangerous monsters or work with machinery.  It will also boost the power of any spells you may learn in your travels.");
			menu();
			addButton(0, "Yes", setEndowmentSmarts);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentWise():void {
			clearOutput();
			outputText("Are you a wise person?  (+5 Wisdom)\n\nWisdom can help you understand mysteries objects or work with soulforce.  It will also boost the power of any soulskills you may learn in your travels.");
			menu();
			addButton(0, "Yes", setEndowmentWise);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentLibido():void {
			clearOutput();
			outputText("Do you have an unusually high sex-drive?  (+5 Libido)\n\nLibido affects how quickly your lust builds over time.  You may find a high libido to be more trouble than it's worth...");
			menu();
			addButton(0, "Yes", setEndowmentLibido);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentTouch():void {
			clearOutput();
			outputText("Is your skin unusually sensitive?  (+5 Sensitivity)\n\nSensitivity affects how easily touches and certain magics will raise your lust.  Very low sensitivity will make it difficult to orgasm.");
			menu();
			addButton(0, "Yes", setEndowmentTouch);
			addButton(1, "No", chooseEndowment, true);
		}
		
		private function confirmEndowmentPerversion():void {
			clearOutput();
			clearOutput();
			outputText("Are you unusually perverted?  (+5 Corruption)\n\Corruption affects certain scenes and having a higher corruption makes you more prone to Bad Ends.\n");
			menu();
			addButton(0, "Yes", setEndowmentPerversion);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentBigCock():void {
			clearOutput();
			outputText("Do you have a big cock?  (+2\" Cock Length)\n\nA bigger cock will make it easier to get off any sexual partners, but only if they can take your size.");
			menu();
			addButton(0, "Yes", setEndowmentBigCock);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentMessyOrgasms():void {
			clearOutput();
			outputText("Are your orgasms particularly messy?  (+50% Cum Multiplier)\n\nA higher cum multiplier will cause your orgasms to be messier.");
			menu();
			addButton(0, "Yes", setEndowmentMessyOrgasms);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentBigBreasts():void {
			clearOutput();
			outputText("Are your breasts bigger than average? (DD cups)\n\nLarger breasts will allow you to lactate greater amounts, tit-fuck larger cocks, and generally be a sexy bitch.");
			menu();
			addButton(0, "Yes", setEndowmentBigBreasts);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentBigClit():void {
			clearOutput();
			outputText("Do you have a big clit?  (1\" Long)\n\nA large enough clit may eventually become as large as a cock.  It also makes you gain lust much faster during oral or manual stimulation.");
			menu();
			addButton(0, "Yes", setEndowmentBigClit);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentFertile():void {
			clearOutput();
			outputText("Is your family particularly fertile?  (+15% Fertility)\n\nA high fertility will cause you to become pregnant much more easily.  Pregnancy may result in: Strange children, larger bust, larger hips, a bigger ass, and other weirdness.");
			menu();
			addButton(0, "Yes", setEndowmentFertile);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentWetVagina():void {
			clearOutput();
			outputText("Does your pussy get particularly wet?  (+1 Vaginal Wetness)\n\nVaginal wetness will make it easier to take larger cocks, in turn helping you bring the well-endowed to orgasm quicker.");
			menu();
			addButton(0, "Yes", setEndowmentWetVagina);
			addButton(1, "No", chooseEndowment, true);
		}

		private function setEndowmentStrength():void {
			player.str += 5;
			player.tone += 7;
			player.thickness += 3;
			//Add bonus +25% strength gain
			if (player.findPerk(PerkLib.Strong) < 0) player.createPerk(PerkLib.Strong, 0.25, 0, 0, 0);
			chooseHistory();
		}
		
		private function setEndowmentToughness():void {
			player.tou += 5;
			player.tone += 5;
			player.thickness += 5;
			if (player.findPerk(PerkLib.Tough) < 0) player.createPerk(PerkLib.Tough, 0.25, 0, 0, 0);
			player.HP = EngineCore.maxHP();
			chooseHistory();
		}
		
		private function setEndowmentSpeed():void {
			player.spe += 5;
			player.tone += 10;
			if (player.findPerk(PerkLib.Fast) < 0) player.createPerk(PerkLib.Fast, 0.25, 0, 0, 0);
			chooseHistory();
		}
		
		private function setEndowmentSmarts():void {
			player.inte += 5;
			player.thickness -= 5;
			if (player.findPerk(PerkLib.Smart) < 0) player.createPerk(PerkLib.Smart, 0.25, 0, 0, 0);
			chooseHistory();
		}
		
		private function setEndowmentWise():void {
			player.wis += 5;
			if (player.findPerk(PerkLib.Wise) < 0) player.createPerk(PerkLib.Wise, 0.25, 0, 0, 0);
			chooseHistory();
		}
		
		private function setEndowmentLibido():void {
			player.lib += 5;
			if (player.findPerk(PerkLib.Lusty) < 0) player.createPerk(PerkLib.Lusty, 0.25, 0, 0, 0);
			chooseHistory();
		}
		
		private function setEndowmentTouch():void {
			player.sens += 5;
			if (player.findPerk(PerkLib.Sensitive) < 0) player.createPerk(PerkLib.Sensitive, 0.25, 0, 0, 0);
			chooseHistory();
		}
		
		private function setEndowmentPerversion():void {
			player.cor += 5;
			if (player.findPerk(PerkLib.Pervert) < 0) player.createPerk(PerkLib.Pervert, 0.25, 0, 0, 0);
			chooseHistory();
		}
		
		private function setEndowmentBigCock():void {
			player.femininity -= 5;
			player.cocks[0].cockLength = 8;
			player.cocks[0].cockThickness = 1.5;
			trace("Creation - cock modded to 8inches");
			if (player.findPerk(PerkLib.BigCock) < 0) player.createPerk(PerkLib.BigCock, 1.25, 0, 0, 0);
			chooseHistory();
		}
		
		private function setEndowmentMessyOrgasms():void {
			player.femininity -= 2;
			player.cumMultiplier = 1.5;
			if (player.findPerk(PerkLib.MessyOrgasms) < 0) player.createPerk(PerkLib.MessyOrgasms, 1.25, 0, 0, 0);
			chooseHistory();
		}
		
		private function setEndowmentBigBreasts():void {
			player.femininity += 5;
			player.breastRows[0].breastRating += 2;
			if (player.findPerk(PerkLib.BigTits) < 0) player.createPerk(PerkLib.BigTits, 1.5, 0, 0, 0);
			chooseHistory();
		}
		
		private function setEndowmentBigClit():void {
			player.femininity -= 5;
			player.clitLength = 1;
			if (player.findPerk(PerkLib.BigClit) < 0) player.createPerk(PerkLib.BigClit, 1.25, 0, 0, 0);
			chooseHistory();
		}
		
		private function setEndowmentFertile():void {
			player.femininity += 5;
			player.fertility += 25;
			player.hips.type += 2;
			if (player.findPerk(PerkLib.Fertile) < 0) player.createPerk(PerkLib.Fertile, 1.5, 0, 0, 0);
			chooseHistory();
		}
		
		private function setEndowmentWetVagina():void {
			player.femininity += 7;
			player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_WET;
			if (player.findPerk(PerkLib.WetPussy) < 0) player.createPerk(PerkLib.WetPussy, 2, 0, 0, 0);
			chooseHistory();
		}
		
		//-----------------
		//-- HISTORY PERKS
		//-----------------
		public function chooseHistory():void {
			clearOutput();
			if (flags[kFLAGS.HISTORY_PERK_SELECTED] != 0) { //This flag can only be non-zero if chooseHistory is called from camp.as
				outputText("<b>New history perks are available during creation.  Since this character was created before they were available, you may choose one now!</b>\n\n");
			}
			outputText("Before you became a champion, you had other plans for your life.  What were you doing before?");
			menu();
			if (player.findPerk(PerkLib.PastLifeAlchemist) < 0) addButton(0, "Alchemy", confirmHistory, PerkLib.HistoryAlchemist);
			else addButtonDisabled(0, "Alchemy", "You already have this History as one of Past Lives!");
			if (player.findPerk(PerkLib.PastLifeCultivator) < 0) addButton(1, "Cultivator", confirmHistory, PerkLib.HistoryCultivator);
			else addButtonDisabled(1, "Cultivator", "You already have this History as one of Past Lives!");
			if (player.findPerk(PerkLib.PastLifeFighter) < 0) addButton(2, "Fighting", confirmHistory, PerkLib.HistoryFighter);
			else addButtonDisabled(2, "Fighting", "You already have this History as one of Past Lives!");
			if (player.findPerk(PerkLib.PastLifeFortune) < 0) addButton(3, "Fortune", confirmHistory, PerkLib.HistoryFortune);
			else addButtonDisabled(3, "Fortune", "You already have this History as one of Past Lives!");
			if (player.findPerk(PerkLib.PastLifeHealer) < 0) addButton(4, "Healing", confirmHistory, PerkLib.HistoryHealer);
			else addButtonDisabled(4, "Healing", "You already have this History as one of Past Lives!");
			if (player.findPerk(PerkLib.PastLifeReligious) < 0) addButton(5, "Religion", confirmHistory, PerkLib.HistoryReligious);
			else addButtonDisabled(5, "Religion", "You already have this History as one of Past Lives!");
			if (player.findPerk(PerkLib.PastLifeScholar) < 0) addButton(6, "Schooling", confirmHistory, PerkLib.HistoryScholar);
			else addButtonDisabled(6, "Schooling", "You already have this History as one of Past Lives!");
			if (player.findPerk(PerkLib.PastLifeScout) < 0) addButton(7, "Scout", confirmHistory, PerkLib.HistoryScout);
			else addButtonDisabled(7, "Scout", "You already have this History as one of Past Lives!");
			if (player.findPerk(PerkLib.PastLifeSlacker) < 0) addButton(8, "Slacking", confirmHistory, PerkLib.HistorySlacker);
			else addButtonDisabled(8, "Slacking", "You already have this History as one of Past Lives!");
			if (player.findPerk(PerkLib.PastLifeSlut) < 0) addButton(9, "Slutting", confirmHistory, PerkLib.HistorySlut);
			else addButtonDisabled(9, "Slutting", "You already have this History as one of Past Lives!");
			if (player.findPerk(PerkLib.PastLifeSmith) < 0) addButton(10, "Smithing", confirmHistory, PerkLib.HistorySmith);
			else addButtonDisabled(10, "Smithing", "You already have this History as one of Past Lives!");
			if (player.findPerk(PerkLib.PastLifeWhore) < 0) addButton(11, "Whoring", confirmHistory, PerkLib.HistoryWhore);
			else addButtonDisabled(11, "Whoring", "You already have this History as one of Past Lives!");
			addButton(14, "None", noHistoryAtAllCuzYouAscendedTooManyTimesAlready).hint("You either never been doing anything before or you have memories of so many past lives you spend all your current live trying to not go postal from those memories. (Yes you not gonna get any History perk only just a few perk points so maybe not use this option till you get all others History perks, ya?)");
			
		}
		
		private function confirmHistory(choice:PerkType):void {
			clearOutput();
			switch (choice) {
				case PerkLib.HistoryAlchemist:
					outputText("You spent some time as an alchemist's assistant, and alchemical items always seem to be more reactive in your hands.  Is this your history?");
					break;
				case PerkLib.HistoryCultivator:
					outputText("You spent much of your time cultivating your soul, reaching the point where you succesfully took the first step towards spiritual enlightment as well as attaining an uncanny purity of soulforce. You will start with Job: Soul Cultivator perk. Your max soulforce will be roughly 10% higher. Is this your history?");
					break;
				case PerkLib.HistoryFighter:
					outputText("You spent much of your time fighting other children, and you had plans to find work as a guard when you grew up.  You do 10% more damage with physical melee attacks.  You will also start out with 50 gems and Job: Warrior perk.  Is this your history?");
					break;
				case PerkLib.HistoryFortune:
					outputText("You always feel lucky when it comes to fortune.  Because of that, you have always managed to save up gems until whatever's needed and how to make the most out it (+15% gems on victory).  You will also start out with 250 gems.  Is this your history?");
					break;
				case PerkLib.HistoryHealer:
					outputText("You often spent your free time with the village healer, learning how to tend to wounds.  Healing items and effects are 20% more effective.  Is this your history?");
					break;
				case PerkLib.HistoryReligious:
					outputText("You spent a lot of time at the village temple, and learned how to meditate.  The 'masturbation' option is replaced with 'meditate' when corruption is at or below 66.  Is this your history?");
					break;
				case PerkLib.HistoryScholar:
					outputText("You spent much of your time in school, and even begged the richest man in town, Mr. " + (silly() ? "Savin" : "Sellet") + ", to let you read some of his books.  You are much better at focusing, spellcasting uses 20% less mana and will start with Job: Sorcerer perk.  Is this your history?");
					break;
				case PerkLib.HistoryScout:
					outputText("You spent much of your time learning use range weapons, and you had plans to find work as a hunter when you grew up.  You do 10% more damage with physical range attacks and +20% accuracy.  You will also start out with 50 gems and Job: Ranger perk.  Is this your history?");
					break;
				case PerkLib.HistorySlacker:
					outputText("You spent a lot of time slacking, avoiding work, and otherwise making a nuisance of yourself.  Your efforts at slacking have made you quite adept at resting, and your fatigue comes back 20% faster.  Is this your history?");
					break;
				case PerkLib.HistorySlut:
					outputText("You managed to spend most of your time having sex.  Quite simply, when it came to sex, you were the village bicycle - everyone got a ride.  Because of this, your body is a bit more resistant to penetrative stretching, and has a higher upper limit on what exactly can be inserted.  Is this your history?");
					break;
				case PerkLib.HistorySmith:
					outputText("You managed to get an apprenticeship with the local blacksmith.  Because of your time spent at the blacksmith's side, you've learned how to fit armor for maximum protection.  You will start with Job: Guardian perk.  Is this your history?");
					break;
				default:
					outputText("You managed to find work as a whore.  Because of your time spent trading seduction for profit, you're more effective at teasing (+15% tease damage).  You will start with Job: Seducer perk.  Is this your history?");
			}
			menu();
			addButton(0, "Yes", setHistory, choice);
			addButton(1, "No", chooseHistory);
		}

		private function setHistory(choice:PerkType):void {
			player.createPerk(choice, 0, 0, 0, 0);
			if (choice == PerkLib.HistorySlut || choice == PerkLib.HistoryWhore) {
				if (player.hasVagina()) {
					player.vaginas[0].virgin = false;
					player.vaginas[0].vaginalLooseness = VaginaClass.LOOSENESS_LOOSE;
				}
				player.ass.analLooseness = 1;
			}
			if (choice == PerkLib.HistoryFighter || choice == PerkLib.HistoryWhore || choice == PerkLib.HistoryScout) {
				player.gems += 50;
			}
			if (choice == PerkLib.HistoryFortune) {
				player.gems += 250;
			}
			if (flags[kFLAGS.HISTORY_PERK_SELECTED] == 0) {
				flags[kFLAGS.HISTORY_PERK_SELECTED] = 1;
				completeCharacterCreation();
			}
			else { //Special escape clause for very old saves that do not have a history perk. This is used to allow them the chance to select a perk at camp on load.
				flags[kFLAGS.HISTORY_PERK_SELECTED] = 1;
				playerMenu();
			}
			
		}
		private function noHistoryAtAllCuzYouAscendedTooManyTimesAlready():void {
			player.perkPoints += 12;
			flags[kFLAGS.HISTORY_PERK_SELECTED] = 1;
			completeCharacterCreation();
		}
		
		private function completeCharacterCreation():void {
			clearOutput();
			if (customPlayerProfile != null) {
				customPlayerProfile();
				if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) doNext(chooseGameModes);
				else doNext(startTheGame);
				return;
			}
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) chooseGameModes();
			else startTheGame();
		}
			
		public function arrival():void {
			statScreenRefresh();
			model.time.hours = 11;
			clearOutput();
			outputText("You are prepared for what is to come.  Most of the last year has been spent honing your body and mind to prepare for the challenges ahead.  You are the Champion of Ingnam.  The one who will journey to the demon realm and guarantee the safety of your friends and family, even though you'll never see them again.  You wipe away a tear as you enter the courtyard and see Elder Nomur waiting for you.  You are ready.\n\n");
			outputText("The walk to the tainted cave is long and silent.  Elder Nomur does not speak.  There is nothing left to say.  The two of you journey in companionable silence.  Slowly the black rock of Mount Ilgast looms closer and closer, and the temperature of the air drops.   You shiver and glance at the Elder, noticing he doesn't betray any sign of the cold.  Despite his age of nearly 80, he maintains the vigor of a man half his age.  You're glad for his strength, as assisting him across this distance would be draining, and you must save your energy for the trials ahead.\n\n");
			outputText("The entrance of the cave gapes open, sharp stalactites hanging over the entrance, giving it the appearance of a monstrous mouth.  Elder Nomur stops and nods to you, gesturing for you to proceed alone.\n\n");
			outputText("The cave is unusually warm and damp, ");
			if (player.gender == Gender.GENDER_FEMALE)
				outputText("and your body seems to feel the same way, flushing as you feel a warmth and dampness between your thighs.");
			else outputText("and your body reacts with a sense of growing warmth focusing in your groin, your manhood hardening for no apparent reason.");
			outputText(" You were warned of this and press forward, ignoring your body's growing needs.  A glowing purple-pink portal swirls and flares with demonic light along the back wall.  Cringing, you press forward, keenly aware that your body seems to be anticipating coming in contact with the tainted magical construct.  Closing your eyes, you gather your resolve and leap forwards.  Vertigo overwhelms you and you black out...");
			showStats();
			dynStats("lus", 15);
			doNext(arrivalPartTwo);
		}
		
		private function arrivalPartTwo():void {
			clearOutput();
			hideUpDown();
			dynStats("lus", 40, "cor", 2);
			model.time.hours = 18;
			outputText("You wake with a splitting headache and a body full of burning desire.  A shadow darkens your view momentarily and your training kicks in.  You roll to the side across the bare ground and leap to your feet.  A surprised looking imp stands a few feet away, holding an empty vial.  He's completely naked, an improbably sized pulsing red cock hanging between his spindly legs.  You flush with desire as a wave of lust washes over you, your mind reeling as you fight ");
			if (player.gender == Gender.GENDER_FEMALE)
				outputText("the urge to chase down his rod and impale yourself on it.\n\n");
			else
				outputText("the urge to ram your cock down his throat.  The strangeness of the thought surprises you.\n\n");
			outputText("The imp says, \"<i>I'm amazed you aren't already chasing down my cock, human.  The last Champion was an eager whore for me by the time she woke up.  This lust draft made sure of it.</i>\"");
			doNext(arrivalPartThree);
		}
		
		private function arrivalPartThree():void {
			clearOutput();
			hideUpDown();
			dynStats("lus", -30);
			outputText("The imp shakes the empty vial to emphasize his point.  You reel in shock at this revelation - you've just entered the demon realm and you've already been drugged!  You tremble with the aching need in your groin, but resist, righteous anger lending you strength.\n\nIn desperation you leap towards the imp, watching with glee as his cocky smile changes to an expression of sheer terror.  The smaller creature is no match for your brute strength as you pummel him mercilessly.  You pick up the diminutive demon and punt him into the air, frowning grimly as he spreads his wings and begins speeding into the distance.\n\n");
			outputText("The imp says, \"<i>FOOL!  You could have had pleasure unending... but should we ever cross paths again you will regret humiliating me!  Remember the name Zetaz, as you'll soon face the wrath of my master!</i>\"\n\n");
			outputText("Your pleasure at defeating the demon ebbs as you consider how you've already been defiled.  You swear to yourself you will find the demon responsible for doing this to you and the other Champions, and destroy him AND his pet imp.");
			doNext(arrivalPartFour);
		}
		
		private function arrivalPartFour():void {
			clearOutput();
			hideUpDown();
			outputText("You look around, surveying the hellish landscape as you plot your next move.  The portal is a few yards away, nestled between a formation of rocks.  It does not seem to exude the arousing influence it had on the other side.  The ground and sky are both tinted different shades of red, though the earth beneath your feet feels as normal as any other lifeless patch of dirt.   You settle on the idea of making a camp here and fortifying this side of the portal.  No demons will ravage your beloved hometown on your watch.\n\nIt does not take long to set up your tent and a few simple traps.  You'll need to explore and gather more supplies to fortify it any further.  Perhaps you will even manage to track down the demons who have been abducting the other champions!");
			awardAchievement("Newcomer", kACHIEVEMENTS.STORY_NEWCOMER, true, true);
			doNext(playerMenu);
		}
		
		//-----------------
		//-- GAME MODES
		//-----------------
		private function chooseModeNormal():void {
			clearOutput();
			outputText("You have chosen Normal Mode. This is a classic gameplay mode. \n\n<b>Difficulty can be adjusted at any time.</b>");
			flags[kFLAGS.HARDCORE_MODE] = 0;
			flags[kFLAGS.HUNGER_ENABLED] = 0;
			flags[kFLAGS.GAME_DIFFICULTY] = 0;
			doNext(startTheGame);
		}	

		private function chooseModeSurvival():void {
			clearOutput();
			outputText("You have chosen Survival Mode. This is similar to the normal mode but with hunger enabled. \n\n<b>Difficulty can be adjusted at any time.</b>");
			flags[kFLAGS.HARDCORE_MODE] = 0;
			flags[kFLAGS.HUNGER_ENABLED] = 0.5;
			flags[kFLAGS.GAME_DIFFICULTY] = 0;
			player.hunger = 80;
			doNext(startTheGame);
		}	

		private function chooseModeRealistic():void {
			clearOutput();
			outputText("You have chosen Realistic Mode. In this mode, hunger is enabled so you have to eat periodically. Also, your cum production is capped and having oversized parts will weigh you down. \n\n<b>Difficulty can be adjusted at any time.</b>");
			flags[kFLAGS.HARDCORE_MODE] = 0;
			flags[kFLAGS.HUNGER_ENABLED] = 1;
			flags[kFLAGS.GAME_DIFFICULTY] = 0;
			player.hunger = 80;
			doNext(startTheGame);
		}	

		private function chooseModeHard():void {
			clearOutput();
			outputText("You have chosen Hard Mode. In this mode, hunger is enabled so you have to eat periodically. In addition, the game forces autosave and if you encounter a Bad End, your save file is <b>DELETED</b>! \n\nDebug Mode and Easy Mode are disabled in this game mode. \n\nPlease choose a slot to save in. You may not make multiple copies of saves. \n\n<b>Difficulty is locked to hard.</b>");
			flags[kFLAGS.HARDCORE_MODE] = 1;
			flags[kFLAGS.HUNGER_ENABLED] = 1;
			flags[kFLAGS.GAME_DIFFICULTY] = 1;
			player.hunger = 80;
			menu();
			for (var i:int = 0; i < 14; i++) {
				addButton(i, "Slot " + (i + 1), chooseSlotHardcore, (i + 1));
			}
			addButton(14, "Back", chooseGameModes);
		}

		private function chooseModeHardcore():void {
			clearOutput();
			outputText("You have chosen Hardcore Mode. This is the HARDEST mode of all. \n\n<b>Difficulty is locked to <i>NIGHTMARE</i>.</b>");
			flags[kFLAGS.HARDCORE_MODE] = 1;
			flags[kFLAGS.HUNGER_ENABLED] = 1;
			flags[kFLAGS.GAME_DIFFICULTY] = 2;
			player.hunger = 80;
			menu();
			for (var i:int = 0; i < 14; i++) {
				addButton(i, "Slot " + (i + 1), chooseSlotHardcore, (i + 1));
			}
			addButton(14, "Back", chooseGameModes);
		}

		private function chooseModeBrutalHardcore():void {
			clearOutput();
			outputText("You have chosen Brutal Hardcore Mode. This is the more than HARDEST mode of all. \n\n<b>Difficulty is locked to <i>EXTREME</i>.</b>");
			flags[kFLAGS.HARDCORE_MODE] = 1;
			flags[kFLAGS.HUNGER_ENABLED] = 1;
			flags[kFLAGS.GAME_DIFFICULTY] = 3;
			player.hunger = 80;
			menu();
			for (var i:int = 0; i < 14; i++) {
				addButton(i, "Slot " + (i + 1), chooseSlotHardcore, (i + 1));
			}
			addButton(14, "Back", chooseGameModes);
		}	

		private function chooseModeXianxia():void {
			clearOutput();
			outputText("You have chosen Xianxia MC Mode. This is the mode to fell like a true XIANXIA MC. \n\n<b>Difficulty is locked to <i>XIANXIA</i>.</b>");
			flags[kFLAGS.HARDCORE_MODE] = 1;
			flags[kFLAGS.HUNGER_ENABLED] = 1;
			flags[kFLAGS.GAME_DIFFICULTY] = 4;
			player.hunger = 80;
			menu();
			for (var i:int = 0; i < 14; i++) {
				addButton(i, "Slot " + (i + 1), chooseSlotHardcore, (i + 1));
			}
			addButton(14, "Back", chooseGameModes);
		}

		//Choose Hardcore slot.
		private function chooseSlotHardcore(num:int):void {
			flags[kFLAGS.HARDCORE_SLOT] = "CoC_" + num;
			startTheGame();
		}	

		//Choose the game mode when called!
		private function chooseGameModes():void {
			clearOutput();
			outputText("Choose a game mode.\n\n");
			outputText("<b>Normal mode:</b> Classic Corruption of Champions gameplay.\n");
			outputText("<b>Survival mode:</b> Like normal but with hunger enabled.\n");
			outputText("<b>Realistic mode:</b> You get hungry from time to time and cum production is capped. In addition, it's a bad idea to have oversized parts. \n");
			outputText("<b>Hard mode:</b> In addition to Realistic mode, the game forces save and if you get a Bad End, your save file is deleted. For not sunday (CoC) players.\n");
			outputText("<b>Hardcore mode:</b> In addition to Realistic mode, the game forces save and if you get a Bad End, your save file is deleted. For the veteran CoC players only.\n");
			outputText("<b>Brutal Hardcore mode:</b> The hardest game mode ever. Like hardcore mode, but the difficulty is locked to extreme! How long can you survive?\n");
			outputText("<b>Xianxia MC mode:</b> The game mode for everyone that want feel like an every Xianxia MC. Hunger waiting behind a corner and enemies are always stronger than you! How long will take to you to reach top dog position?\n");
			menu();
			addButton(0, "Normal", chooseModeNormal);
			addButton(1, "Survival", chooseModeSurvival);
			addButton(2, "Realistic", chooseModeRealistic);
			addButton(3, "Hard", chooseModeHard);
			addButton(4, "Hardcore", chooseModeHardcore);
			addButton(5, "Brutal HC", chooseModeBrutalHardcore);
			addButton(6, "Xianxia MC", chooseModeXianxia);
		}

		private function startTheGame():void {
			player.startingRace = player.race();
			if (flags[kFLAGS.HARDCORE_MODE] > 0) {
				trace("Hardcore save file " + flags[kFLAGS.HARDCORE_SLOT] + " created.");
                CoC.instance.saves.saveGame(flags[kFLAGS.HARDCORE_SLOT])
            }
			CoC.instance.saves.loadPermObject();
			flags[kFLAGS.MOD_SAVE_VERSION] = CoC.instance.modSaveVersion;
			statScreenRefresh();
			chooseToPlay();
			return;
		}

		public function chooseToPlay():void {
			if (player.femininity >= 55) player.setUndergarment(undergarments.C_PANTY);
			else player.setUndergarment(undergarments.C_LOIN);
			if (player.biggestTitSize() >= 2) player.setUndergarment(undergarments.C_BRA);
			else player.setUndergarment(undergarments.C_SHIRT);
			if (player.findPerk(PerkLib.HistoryCultivator) >= 0 || player.findPerk(PerkLib.PastLifeCultivator) >= 0) player.createPerk(PerkLib.JobSoulCultivator, 0, 0, 0, 0);
			if (player.findPerk(PerkLib.HistoryFighter) >= 0 || player.findPerk(PerkLib.PastLifeFighter) >= 0) player.createPerk(PerkLib.JobWarrior, 0, 0, 0, 0);
			if (player.findPerk(PerkLib.HistoryScout) >= 0 || player.findPerk(PerkLib.PastLifeScout) >= 0) player.createPerk(PerkLib.JobRanger, 0, 0, 0, 0);
			if (player.findPerk(PerkLib.HistoryScholar) >= 0 || player.findPerk(PerkLib.PastLifeScholar) >= 0) player.createPerk(PerkLib.JobSorcerer, 0, 0, 0, 0);
			if (player.findPerk(PerkLib.HistorySmith) >= 0 || player.findPerk(PerkLib.PastLifeSmith) >= 0) player.createPerk(PerkLib.JobGuardian, 0, 0, 0, 0);
			if (player.findPerk(PerkLib.HistoryWhore) >= 0 || player.findPerk(PerkLib.PastLifeWhore) >= 0) player.createPerk(PerkLib.JobSeducer, 0, 0, 0, 0);
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0 || player.findPerk(PerkLib.HistoryFortune) >= 0 || player.findPerk(PerkLib.HistoryHealer) >= 0 || player.findPerk(PerkLib.HistoryReligious) >= 0 || player.findPerk(PerkLib.HistorySlacker) >= 0 || player.findPerk(PerkLib.HistorySlut) >= 0) player.perkPoints += 1;
			if (player.findPerk(PerkLib.PastLifeAlchemist) >= 0) player.perkPoints += 1;
			if (player.findPerk(PerkLib.PastLifeFortune) >= 0) player.perkPoints += 1;
			if (player.findPerk(PerkLib.PastLifeHealer) >= 0) player.perkPoints += 1;
			if (player.findPerk(PerkLib.PastLifeReligious) >= 0) player.perkPoints += 1;
			if (player.findPerk(PerkLib.PastLifeSlacker) >= 0) player.perkPoints += 1;
			if (player.findPerk(PerkLib.PastLifeSlut) >= 0) player.perkPoints += 1;
			if (player.findPerk(PerkLib.AscensionHerosHeritage) >= 0) {
				player.perkPoints += 3 * player.newGamePlusMod();
				player.statPoints += 15 * player.newGamePlusMod();
			}
			if (player.findPerk(PerkLib.AscensionHerosLineage) >= 0) {
				player.perkPoints += 2 * player.newGamePlusMod();
				player.statPoints += 10 * player.newGamePlusMod();
			}
			if (player.findPerk(PerkLib.AscensionNaturalMetamorph) >= 0) {
				player.createPerk(PerkLib.GeneticMemory, 0, 0, 0, 0);
				player.createPerk(PerkLib.Metamorph, 0, 0, 0, 0);
			}
			player.perkPoints += 1;
			clearOutput();
			statScreenRefresh();
			outputText("Would you like to play through the " + (1 * (1 + player.newGamePlusMod())) + "-day");
			if (player.newGamePlusMod() > 0) outputText("s");
			outputText(" prologue in Ingnam or just skip?");
			player.HP = player.maxHP();
			doYesNo(goToIngnam, arrival);
		}

		public function goToIngnam():void {
			model.time.days = -(1 * (1 + player.newGamePlusMod()));
			model.time.hours = 8;
			flags[kFLAGS.IN_INGNAM] = 1;
			SceneLib.ingnam.menuIngnam();
		}

		//-----------------
		//-- ASCENSION
		//-----------------
		public function ascensionMenu():void {
			hideStats();
			clearOutput();
			hideMenus();
			mainView.nameBox.visible = false;
			EngineCore.displayHeader("Ascension");
			outputText("The world you have departed is irrelevant and you are in an endless black void dotted with tens of thousands of stars. You encompass everything and everything encompasses you.");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			outputText("\n\n(When you're done, select Reincarnate.)");
			menu();
			addButton(0, "Perk Select(1)", ascensionPerkMenu).hint("Spend Ascension Perk Points on special perks!", "Perk Selection");
			addButton(1, "Perk Select(2)", ascensionPerkMenu2).hint("Spend Ascension Perk Points on special perks!", "Perk Selection");
			addButton(2, "Rare Perks(1)", rarePerks1).hint("Spend Ascension Points on rare special perks!", "Perk Selection");
			addButton(3, "Rare Perks(2)", rarePerks2).hint("Spend Ascension Points on rare special perks!", "Perk Selection");
			addButton(5, "Perm Perks", ascensionPermeryMenu).hint("Spend Ascension Perk Points to make certain perks permanent (5 per perk).", "Perk Selection");
			if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage1)) {
				if (player.statusEffectv2(StatusEffects.TranscendentalGeneticMemory) < player.statusEffectv1(StatusEffects.TranscendentalGeneticMemory)) addButton(6, "Perm G.M.(1)", ascensionMetamorphPermeryMenu).hint("Spend Ascension Perk Points to make unlocked Metamorph options permanent. (5 per perk)", "Perk Selection");
				else addButtonDisabled(6, "Perm G.M.", "You already reached your current limit on permable Metamorph options.");
			}
			else addButtonDisabled(6, "Perm G.M.", "You not have Ascension: Transcendental Genetic Memory (Stage 1) perk to use this option.");
			if (player.ascensionPerkPoints >= 5) addButton(7, "Past Life", historyTopastlife).hint("Spend Ascension Points to change current possesed History perk into Past Life perk (5 per perk).", "Perk Selection");
			else addButtonDisabled(7, "Past Life", "You not have enough Ascension Perk Points to use this option.");
			addButton(10, "Rename", renamePrompt).hint("Change your name at no charge?");
			addButton(11, "Reincarnate", reincarnatePrompt).hint("Reincarnate and start an entirely new adventure?");
		}
		private function ascensionPerkMenu():void {
			clearOutput();
			outputText("You can spend your Ascension Perk Points on special perks not available at level-up!");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			menu();
			addButton(0, "Mysticality", ascensionPerkSelection, PerkLib.AscensionMysticality, MAX_MYSTICALITY_LEVEL, null, PerkLib.AscensionMysticality.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionMysticality) + " / " + MAX_MYSTICALITY_LEVEL);
			addButton(1, "S.Enlight.", ascensionPerkSelection, PerkLib.AscensionSpiritualEnlightenment, MAX_SPIRITUALENLIGHTENMENT_LEVEL, null, PerkLib.AscensionSpiritualEnlightenment.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionSpiritualEnlightenment) + " / " + MAX_SPIRITUALENLIGHTENMENT_LEVEL);
			addButton(2, "Fortune", ascensionPerkSelection, PerkLib.AscensionFortune, MAX_FORTUNE_LEVEL, null, PerkLib.AscensionFortune.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionFortune) + " (No maximum level)");
			addButton(3, "Moral Shifter", ascensionPerkSelection, PerkLib.AscensionMoralShifter, MAX_MORALSHIFTER_LEVEL, null, PerkLib.AscensionMoralShifter.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionMoralShifter) + " / " + MAX_MORALSHIFTER_LEVEL);
			addButton(4, "Tolerance", ascensionPerkSelection, PerkLib.AscensionTolerance, MAX_TOLERANCE_LEVEL, null, PerkLib.AscensionTolerance.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionTolerance) + " / " + MAX_TOLERANCE_LEVEL);
			addButton(5, "Fertility", ascensionPerkSelection, PerkLib.AscensionFertility, MAX_FERTILITY_LEVEL, null, PerkLib.AscensionFertility.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionFertility) + " / " + MAX_FERTILITY_LEVEL);
			addButton(6, "Virility", ascensionPerkSelection, PerkLib.AscensionVirility, MAX_VIRILITY_LEVEL, null, PerkLib.AscensionVirility.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionVirility) + " / " + MAX_VIRILITY_LEVEL);
			addButton(7, "Wisdom", ascensionPerkSelection, PerkLib.AscensionWisdom, MAX_WISDOM_LEVEL, null, PerkLib.AscensionWisdom.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionWisdom) + " / " + MAX_WISDOM_LEVEL);
			addButton(14, "Back", ascensionMenu);
		}
		private function ascensionPerkMenu2():void {
			clearOutput();
			outputText("You can spend your Ascension Perk Points on special perks not available at level-up!");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			menu();
			addButton(0, "Desires", ascensionPerkSelection2, PerkLib.AscensionDesires, MAX_DESIRES_LEVEL, null, PerkLib.AscensionDesires.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionDesires) + " / " + MAX_DESIRES_LEVEL);
			addButton(1, "Endurance", ascensionPerkSelection2, PerkLib.AscensionEndurance, MAX_ENDURANCE_LEVEL, null, PerkLib.AscensionEndurance.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionEndurance) + " / " + MAX_ENDURANCE_LEVEL);
			addButton(2, "Hardiness", ascensionPerkSelection2, PerkLib.AscensionHardiness, MAX_HARDINESS_LEVEL, null, PerkLib.AscensionHardiness.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionHardiness) + " / " + MAX_HARDINESS_LEVEL);
			addButton(3, "Soul Purity", ascensionPerkSelection2, PerkLib.AscensionSoulPurity, MAX_SOULPURITY_LEVEL, null, PerkLib.AscensionSoulPurity.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionSoulPurity) + " / " + MAX_SOULPURITY_LEVEL);
			addButton(4, "Inner Power", ascensionPerkSelection2, PerkLib.AscensionInnerPower, MAX_INNERPOWER_LEVEL, null, PerkLib.AscensionInnerPower.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionInnerPower) + " / " + MAX_INNERPOWER_LEVEL);
			addButton(5, "Fury", ascensionPerkSelection2, PerkLib.AscensionFury, MAX_FURY_LEVEL, null, PerkLib.AscensionFury.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionFury) + " / " + MAX_FURY_LEVEL);
			addButton(6, "Transhuman.", ascensionPerkSelection2, PerkLib.AscensionTranshumanism, MAX_TRANSHUMANISM_LEVEL, null, PerkLib.AscensionTranshumanism.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionTranshumanism) + " / " + MAX_TRANSHUMANISM_LEVEL);
			addButton(14, "Back", ascensionMenu);
		}
		
		private function ascensionPerkSelection(perk:* = null, maxLevel:int = 10):void {
			clearOutput();
			outputText("Perk Effect: " + perk.longDesc);
			outputText("\nCurrent level: " + player.perkv1(perk) + (maxLevel > 0 ? " / " + maxLevel : " (No maximum level)") + "");
			if (player.perkv1(perk) >= maxLevel && maxLevel > 0) outputText(" <b>(Maximum)</b>");
			var cost:int = player.perkv1(perk) + 1;
			if (cost > 5) cost = 5;
			if (player.perkv1(perk) < maxLevel || maxLevel < 0) outputText("\nCost for next level: " + cost);
			else outputText("\nCost for next level: <b>N/A</b>");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			menu();
			if (player.ascensionPerkPoints >= cost && (player.perkv1(perk) < maxLevel || maxLevel < 0)) addButton(0, "Add 1 level", addAscensionPerk, perk, maxLevel);
			addButton(4, "Back", ascensionPerkMenu);
		}
		private function addAscensionPerk(perk:* = null, maxLevel:int = 10):void {
			var cost:int = player.perkv1(perk) + 1;
			if (cost > 5) cost = 5;
			player.ascensionPerkPoints -= cost;
			if (player.findPerk(perk) >= 0) player.addPerkValue(perk, 1, 1);
			else player.createPerk(perk, 1, 0, 0, 0);
			ascensionPerkSelection(perk, maxLevel);
		}
		private function ascensionPerkSelection2(perk:* = null, maxRank:int = 10):void {
			clearOutput();
			var maxRank:int = 5;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1) maxRank += 5;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 2) maxRank += 5;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 3) maxRank += 5;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 4) maxRank += 5;
			//if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 5) maxRank += 5;
			//if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 6) maxRank += 5;
			//if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 7) maxRank += 5;
			//if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 8) maxRank += 5;
			outputText("Perk Effect: " + perk.longDesc);
			outputText("\nCurrent level: " + player.perkv1(perk) + " / " + maxRank + "");
			if (player.perkv1(perk) >= 25) outputText(" <b>(Maximum)</b>");
			var cost:int = player.perkv1(perk) + 1;
			if (cost > 5) cost = 5;
			if (player.perkv1(perk) < 25) outputText("\nCost for next level: " + cost);
			else outputText("\nCost for next level: <b>N/A</b>");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			menu();
			if (player.ascensionPerkPoints >= cost && player.perkv1(perk) < maxRank) addButton(0, "Add 1 level", addAscensionPerk2, perk, maxRank);
			if (player.ascensionPerkPoints >= cost && player.perkv1(perk) == maxRank && player.perkv1(perk) < 20) addButtonDisabled(0, "Add 1 level", "You've reached max rank for this perk at current tier of ascension. To unlock higher ranks you need to ascend again.");
			addButton(4, "Back", ascensionPerkMenu2);
		}
		private function addAscensionPerk2(perk:* = null, maxRank:int = 10):void {
			var cost:int = player.perkv1(perk) + 1;
			if (cost > 5) cost = 5;
			player.ascensionPerkPoints -= cost;
			if (player.findPerk(perk) >= 0) player.addPerkValue(perk, 1, 1);
			else player.createPerk(perk, 1, 0, 0, 0);
			ascensionPerkSelection2(perk, maxRank);
		}
		
		private function rarePerks1():void {
			clearOutput();
			outputText("You can spend your Ascension Perk Points on rare special perks not available at level-up!");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			menu();
			var btn:int = 0;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1 && player.internalChimeraScore() >= 10) {
				if (player.ascensionPerkPoints >= 20 && player.findPerk(PerkLib.AscensionAdditionalOrganMutation01) < 0) addButton(btn, "A.O.M.(1st)", perkAdditionalOrganMutation01).hint("Perk allowing to get one more slot for the same iternal organ mutations. (2 slots instead 1 for heart related mutations)\n\nCost: 20 points");
				else if (player.ascensionPerkPoints < 20) addButtonDisabled(btn, "A.O.M.(1st)", "You not have enough ascension perk points!");
				else addButtonDisabled(btn, "A.O.M.(1st)", "You already bought Additional Organ Mutation (1st Stage) perk.");
			}
			else if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1 && player.findPerk(PerkLib.AscensionAdditionalOrganMutation01) >= 0) addButtonDisabled(btn, "A.O.M.(1st)", "You already bought Additional Organ Mutation (1st Stage) perk.");
			else addButtonDisabled(btn, "A.O.M.(1st)", "You need ascend more times and have 10+ in internal mutation score to buy this perk.");
			btn++;
			if (player.ascensionPerkPoints >= 5 && player.findPerk(PerkLib.AscensionBuildingPrestige01) < 0) addButton(btn, "B.Prestige(1st)", perkBuildingPrestige01).hint("Perk allowing to get one more slot for prestige job perks.\n\nCost: 5 points");
			else if (player.ascensionPerkPoints < 5) addButtonDisabled(btn, "B.Prestige(1st)", "You not have enough ascension perk points!");
			else addButtonDisabled(btn, "B.Prestige(1st)", "You already bought Building Prestige (1st Stage) perk.");
			btn++;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1 && player.findPerk(PerkLib.AscensionBuildingPrestige01) >= 0) {
				if (player.ascensionPerkPoints >= 10 && player.findPerk(PerkLib.AscensionBuildingPrestige02) < 0) addButton(btn, "B.Prestige(2nd)", perkBuildingPrestige02).hint("Perk allowing to get one more slot for prestige job perks.\n\nCost: 10 points");
				else if (player.ascensionPerkPoints < 10) addButtonDisabled(btn, "B.Prestige(2nd)", "You not have enough ascension perk points!");
				else addButtonDisabled(btn, "B.Prestige(2nd)", "You already bought Building Prestige (2nd Stage) perk.");
			}
			else if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1 && player.findPerk(PerkLib.AscensionBuildingPrestige01) < 0) addButtonDisabled(btn, "B.Prestige(2nd)", "You need to buy Building Prestige (1st Stage) perk first.");
			else addButtonDisabled(btn, "B.Prestige(2nd)", "You need ascend more times to buy this perk.");
			btn++;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 2 && player.findPerk(PerkLib.AscensionBuildingPrestige02) >= 0) {
				if (player.ascensionPerkPoints >= 15 && player.findPerk(PerkLib.AscensionBuildingPrestige03) < 0) addButton(btn, "B.Prestige(3rd)", perkBuildingPrestige03).hint("Perk allowing to get one more slot for prestige job perks.\n\nCost: 15 points");
				else if (player.ascensionPerkPoints < 15) addButtonDisabled(btn, "B.Prestige(3rd)", "You not have enough ascension perk points!");
				else addButtonDisabled(btn, "B.Prestige(3rd)", "You already bought Building Prestige (3rd Stage) perk.");
			}
			else if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 2 && player.findPerk(PerkLib.AscensionBuildingPrestige02) < 0) addButtonDisabled(btn, "B.Prestige(3rd)", "You need to buy Building Prestige (2nd Stage) perk first.");
			else addButtonDisabled(btn, "B.Prestige(3rd)", "You need ascend more times to buy this perk.");
			btn++;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 3 && player.findPerk(PerkLib.AscensionBuildingPrestige03) >= 0) {
				if (player.ascensionPerkPoints >= 20 && player.findPerk(PerkLib.AscensionBuildingPrestige04) < 0) addButton(btn, "B.Prestige(4th)", perkBuildingPrestige04).hint("Perk allowing to get one more slot for prestige job perks.\n\nCost: 20 points");
				else if (player.ascensionPerkPoints < 20) addButtonDisabled(btn, "B.Prestige(4th)", "You not have enough ascension perk points!");
				else addButtonDisabled(btn, "B.Prestige(4th)", "You already bought Building Prestige (4th Stage) perk.");
			}
			else if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 3 && player.findPerk(PerkLib.AscensionBuildingPrestige03) < 0) addButtonDisabled(btn, "B.Prestige(4th)", "You need to buy Building Prestige (3rd Stage) perk first.");
			else addButtonDisabled(btn, "B.Prestige(4th)", "You need ascend more times to buy this perk.");
			btn++;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 2 && player.findPerk(PerkLib.AscensionHybridTheory) >= 0) {
				if (player.ascensionPerkPoints >= 20 && player.findPerk(PerkLib.AscensionCruelChimerasThesis) < 0) addButton(btn, "C Chimera's T", perkCruelChimerasThesis).hint("Perk allowing reduce by one req. race points to recive race bonuses (still req. min 8 race points to work).\n\nCost: 20 points");
				else if (player.ascensionPerkPoints < 20) addButtonDisabled(btn, "C Chimera's T", "You not have enough ascension perk points!");
				else addButtonDisabled(btn, "C Chimera's T", "You already bought Cruel Chimera's Thesis perk.");
			}
			else if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 2 && player.findPerk(PerkLib.AscensionHybridTheory) < 0) addButtonDisabled(btn, "C Chimera's T", "You need to buy Hybrid Theory perk first.");
			else addButtonDisabled(btn, "C Chimera's T", "You need ascend more times to buy this perk.");
			btn++;
			if (player.ascensionPerkPoints >= 5 && player.findPerk(PerkLib.AscensionHerosHeritage) < 0) addButton(btn, "HeroHeritage", perkHerosHeritage).hint("Perk giving additional 3 perk points and 15 stat points at the start of the game (scalling with current NG tier).\n\nCost: 5 points");
			else if (player.ascensionPerkPoints < 5 && player.findPerk(PerkLib.AscensionHerosHeritage) < 0) addButtonDisabled(btn, "HeroHeritage", "You not have enough ascension perk points!");
			else addButtonDisabled(btn, "HeroHeritage", "You already bought Hero's Heritage perk.");
			btn++;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1 && player.findPerk(PerkLib.AscensionHerosHeritage) >= 0) {
				if (player.ascensionPerkPoints >= 5 && player.findPerk(PerkLib.AscensionHerosLineage) < 0) addButton(btn, "HeroLineage", perkHerosLineage).hint("Perk giving additional 2 perk points and 10 stat points at the start of the game (scalling with current NG tier).\n\nCost: 5 points");
				else if (player.ascensionPerkPoints < 5) button(btn).disable("You not have enough ascension perk points!");
				else addButtonDisabled(btn, "HeroLineage", "You already bought Hero's Lineage perk.");
			}
			else if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1 && player.findPerk(PerkLib.AscensionHerosHeritage) < 0) addButtonDisabled(btn, "HeroLineage", "You need to buy Hero's Heritage perk first.");
			else addButtonDisabled(btn, "HeroLineage", "You need ascend more times to buy this perk.");
			btn++;
			if (player.ascensionPerkPoints >= 10 && player.findPerk(PerkLib.AscensionHybridTheory) < 0) addButton(btn, "HybridTheory", perkHybridTheory).hint("Perk allowing reduce by one req. race points to recive race bonuses (still req. min 4 race points to work).\n\nCost: 10 points");
			else if (player.ascensionPerkPoints < 10 && player.findPerk(PerkLib.AscensionHybridTheory) < 0) addButtonDisabled(btn, "HybridTheory", "You not have enough ascension perk points!");
			else addButtonDisabled(btn, "HybridTheory", "You already bought Hybrid Theory perk.");
			btn++;
			if (player.ascensionPerkPoints >= 30 && player.findPerk(PerkLib.AscensionNaturalMetamorph) < 0) addButton(btn, "N.Metamorph", perkNaturalMetamorph).hint("Perk allowing to start with perks Genetic Memory and Metamorph.\n\nCost: 30 points");
			else if (player.ascensionPerkPoints < 30 && player.findPerk(PerkLib.AscensionNaturalMetamorph) < 0) addButtonDisabled(btn, "N.Metamorph", "You not have enough ascension perk points!");
			else addButtonDisabled(btn, "N.Metamorph", "You already bought Natural Metamorph perk.");
			addButton(14, "Back", ascensionMenu);
		}
		private function perkAdditionalOrganMutation01():void {
			player.ascensionPerkPoints -= 20;
			player.createPerk(PerkLib.AscensionAdditionalOrganMutation01,0,0,0,1);
			clearOutput();
			outputText("Your gained Additional Organ Mutation (1st Stage) perk.");
			doNext(rarePerks1);
		}
		private function perkBuildingPrestige01():void {
			player.ascensionPerkPoints -= 5;
			player.createPerk(PerkLib.AscensionBuildingPrestige01,0,0,0,1);
			clearOutput();
			outputText("Your gained Building Prestige (1st Stage) perk.");
			doNext(rarePerks1);
		}
		private function perkBuildingPrestige02():void {
			player.ascensionPerkPoints -= 10;
			player.createPerk(PerkLib.AscensionBuildingPrestige02,0,0,0,1);
			clearOutput();
			outputText("Your gained Building Prestige (2nd Stage) perk.");
			doNext(rarePerks1);
		}
		private function perkBuildingPrestige03():void {
			player.ascensionPerkPoints -= 15;
			player.createPerk(PerkLib.AscensionBuildingPrestige03,0,0,0,1);
			clearOutput();
			outputText("Your gained Building Prestige (3rd Stage) perk.");
			doNext(rarePerks1);
		}
		private function perkBuildingPrestige04():void {
			player.ascensionPerkPoints -= 20;
			player.createPerk(PerkLib.AscensionBuildingPrestige04,0,0,0,1);
			clearOutput();
			outputText("Your gained Building Prestige (4th Stage) perk.");
			doNext(rarePerks1);
		}
		private function perkCruelChimerasThesis():void {
			player.ascensionPerkPoints -= 20;
			player.createPerk(PerkLib.AscensionCruelChimerasThesis,0,0,0,1);
			clearOutput();
			outputText("Your gained Cruel Chimera's Thesis perk.");
			doNext(rarePerks1);
		}
		private function perkHerosHeritage():void {
			player.ascensionPerkPoints -= 5;
			player.createPerk(PerkLib.AscensionHerosHeritage,0,0,0,1);
			clearOutput();
			outputText("Your gained Hero's Heritage perk.");
			doNext(rarePerks1);
		}
		private function perkHerosLineage():void {
			player.ascensionPerkPoints -= 5;
			player.createPerk(PerkLib.AscensionHerosLineage,0,0,0,1);
			clearOutput();
			outputText("Your gained Hero's Lineage perk.");
			doNext(rarePerks1);
		}
		private function perkHybridTheory():void {
			player.ascensionPerkPoints -= 10;
			player.createPerk(PerkLib.AscensionHybridTheory,0,0,0,1);
			clearOutput();
			outputText("Your gained Hybrid Theory perk.");
			doNext(rarePerks1);
		}
		private function perkNaturalMetamorph():void {
			player.ascensionPerkPoints -= 30;
			player.createPerk(PerkLib.AscensionNaturalMetamorph,0,0,0,1);
			clearOutput();
			outputText("Your gained Natural Metamorph perk.");
			doNext(rarePerks1);
		}
		
		private function rarePerks2():void {
			clearOutput();
			outputText("You can spend your Ascension Perk Points on rare special perks not available at level-up!");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			menu();
			var btn:int = 0;
			if (player.findPerk(PerkLib.AscensionNaturalMetamorph) >= 0) {
				if (player.ascensionPerkPoints >= 10 && player.findPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage1) < 0) addButton(btn, "T.G.M.(S1)", perkTranscendentalGeneticMemoryStage1).hint("Perk allowing to retain up to 10 unlocked options from Metamorph menu.\n\nCost: 10 points");
				else if (player.ascensionPerkPoints < 10 && player.findPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage1) < 0) addButtonDisabled(btn, "T.G.M.(S1)", "You not have enough ascension perk points!");
				else addButtonDisabled(btn, "T.G.M.(S1)", "You already bought Transcendental Genetic Memory (Stage 1) perk.");
			}
			else addButtonDisabled(btn, "T.G.M.(S1)", "You need to buy Natural Metamorph perk first.");
			btn++;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1 && player.findPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage1) >= 0) {
				if (player.ascensionPerkPoints >= 20 && player.findPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage2) < 0) addButton(btn, "T.G.M.(S2)", perkTranscendentalGeneticMemoryStage2).hint("Perk allowing to retain up to 20 unlocked options from Metamorph menu.\n\nCost: 20 points");
				else if (player.ascensionPerkPoints < 20) addButtonDisabled(btn, "T.G.M.(S2)", "You not have enough ascension perk points!");
				else addButtonDisabled(btn, "T.G.M.(S2)", "You already bought Transcendental Genetic Memory (Stage 2) perk.");
			}
			else if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1 && player.findPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage1) < 0) addButtonDisabled(btn, "T.G.M.(S2)", "You need to buy Transcendental Genetic Memory (Stage 1) perk first.");
			else addButtonDisabled(btn, "T.G.M.(S2)", "You need ascend more times to buy this perk.");
			btn++;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 2 && player.findPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage2) >= 0) {
				if (player.ascensionPerkPoints >= 30 && player.findPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage3) < 0) addButton(btn, "T.G.M.(S3)", perkTranscendentalGeneticMemoryStage3).hint("Perk allowing to retain up to 30 unlocked options from Metamorph menu.\n\nCost: 30 points");
				else if (player.ascensionPerkPoints < 30) addButtonDisabled(btn, "T.G.M.(S3)", "You not have enough ascension perk points!");
				else addButtonDisabled(btn, "T.G.M.(S3)", "You already bought Transcendental Genetic Memory (Stage 3) perk.");
			}
			else if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 2 && player.findPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage2) < 0) addButtonDisabled(btn, "T.G.M.(S3)", "You need to buy Transcendental Genetic Memory (Stage 2) perk first.");
			else addButtonDisabled(btn, "T.G.M.(S3)", "You need ascend more times to buy this perk.");
			btn++;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 3 && player.findPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage3) >= 0) {
				if (player.ascensionPerkPoints >= 40 && player.findPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage4) < 0) addButton(btn, "T.G.M.(S4)", perkTranscendentalGeneticMemoryStage4).hint("Perk allowing to retain up to 40 unlocked options from Metamorph menu.\n\nCost: 40 points");
				else if (player.ascensionPerkPoints < 40) addButtonDisabled(btn, "T.G.M.(S4)", "You not have enough ascension perk points!");
				else addButtonDisabled(btn, "T.G.M.(S4)", "You already bought Transcendental Genetic Memory (Stage 4) perk.");
			}
			else if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 3 && player.findPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage3) < 0) addButtonDisabled(btn, "T.G.M.(S4)", "You need to buy Transcendental Genetic Memory (Stage 3) perk first.");
			else addButtonDisabled(btn, "T.G.M.(S4)", "You need ascend more times to buy this perk.");
			btn++;
			if (player.ascensionPerkPoints >= 5 && player.findPerk(PerkLib.AscensionUnderdog) < 0) addButton(btn, "Underdog", perkUnderdog).hint("Perk allowing to double increase to base exp gains for fighting enemies above PC level, increasing max lvl diff when bonus still increase from 20 to 40 above current PC lvl.\n\nCost: 5 points");// And... to live up to underdog role PC will 'accidentally' find few places to further power-up.
			else if (player.ascensionPerkPoints < 5 && player.findPerk(PerkLib.AscensionUnderdog) < 0) addButtonDisabled(btn, "Underdog", "You not have enough ascension perk points!");
			else addButtonDisabled(btn, "Underdog", "You already bought Underdog perk.");
			btn++;
			if (player.ascensionPerkPoints >= 5 && player.findPerk(PerkLib.AscensionUnlockedPotential) < 0) addButton(btn, "UnlockPotent", perkUnlockedPotential).hint("Perk allowing to have increase passive gains of max hp, lust and fatigue at each lvl-up.\n\nCost: 5 point");
			else if (player.ascensionPerkPoints < 5 && player.findPerk(PerkLib.AscensionUnlockedPotential) < 0) addButtonDisabled(btn, "UnlockPotent", "You not have enough ascension perk points!");
			else addButtonDisabled(btn, "UnlockPotent", "You already bought Unlocked Potential perk.");
			btn++;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1 && player.findPerk(PerkLib.AscensionUnlockedPotential) >= 0) {
				if (player.ascensionPerkPoints >= 5 && player.findPerk(PerkLib.AscensionUnlockedPotential2ndStage) < 0) addButton(btn, "U.Potent2nd", perkUnlockedPotential2ndStage).hint("Perk allowing to have increase passive gains of max wrath, mana and soulforce at each lvl-up.\n\nCost: 5 point");
				else if (player.ascensionPerkPoints < 5) addButtonDisabled(btn, "U.Potent2nd", "You not have enough ascension perk points!");
				else addButtonDisabled(btn, "U.Potent2nd", "You already bought Unlocked Potential (2nd Stage) perk.");
			}
			else if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1 && player.findPerk(PerkLib.AscensionUnlockedPotential) < 0) addButtonDisabled(btn, "U.Potent2nd", "You need to buy Unlocked Potential perk first.");
			else addButtonDisabled(btn, "U.Potent2nd", "You need ascend more times to buy this perk.");
			btn++;
			btn++;
		//	if (player.ascensionPerkPoints >= 10 && player.findPerk(PerkLib.AscensionHybridTheory) < 0) addButton(btn, "HybridTheory", perkHybridTheory).hint("Perk allowing reduce by one req. race points to recive race bonuses (still req. min 3 race points to work).\n\nCost: 10 points");
		//	else if (player.ascensionPerkPoints < 10) addButtonDisabled(btn, "HybridTheory", "You not have enough ascension perk points!");
		//	else addButtonDisabled(btn, "HybridTheory", "You already bought this perk.");
		//	btn++;
		//	if (player.ascensionPerkPoints >= 10 && player.findPerk(PerkLib.AscensionHybridTheory) < 0) addButton(btn, "HybridTheory", perkHybridTheory).hint("Perk allowing reduce by one req. race points to recive race bonuses (still req. min 3 race points to work).\n\nCost: 10 points");
		//	else if (player.ascensionPerkPoints < 10) addButtonDisabled(btn, "HybridTheory", "You not have enough ascension perk points!");
		//	else addButtonDisabled(btn, "HybridTheory", "You already bought this perk.");
		//	btn++;
		//	if (player.ascensionPerkPoints >= 10 && player.findPerk(PerkLib.AscensionHybridTheory) < 0) addButton(btn, "HybridTheory", perkHybridTheory).hint("Perk allowing reduce by one req. race points to recive race bonuses (still req. min 3 race points to work).\n\nCost: 10 points");
		//	else if (player.ascensionPerkPoints < 10) addButtonDisabled(btn, "HybridTheory", "You not have enough ascension perk points!");
		//	else addButtonDisabled(btn, "HybridTheory", "You already bought this perk.");
		//	btn++;
			addButton(14, "Back", ascensionMenu);
		}
		private function perkTranscendentalGeneticMemoryStage1():void {
			player.ascensionPerkPoints -= 10;
			player.createPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage1, 0, 0, 0, 1);
			player.createStatusEffect(StatusEffects.TranscendentalGeneticMemory, 10, 0, 0, 9000);
			clearOutput();
			outputText("Your gained Transcendental Genetic Memory (Stage 1) perk.");
			doNext(rarePerks2);
		}
		private function perkTranscendentalGeneticMemoryStage2():void {
			player.ascensionPerkPoints -= 20;
			player.createPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage2, 0, 0, 0, 1);
			player.addStatusValue(StatusEffects.TranscendentalGeneticMemory, 1, 20);
			clearOutput();
			outputText("Your gained Transcendental Genetic Memory (Stage 2) perk.");
			doNext(rarePerks2);
		}
		private function perkTranscendentalGeneticMemoryStage3():void {
			player.ascensionPerkPoints -= 30;
			player.createPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage3, 0, 0, 0, 1);
			player.addStatusValue(StatusEffects.TranscendentalGeneticMemory, 1, 30);
			clearOutput();
			outputText("Your gained Transcendental Genetic Memory (Stage 3) perk.");
			doNext(rarePerks2);
		}
		private function perkTranscendentalGeneticMemoryStage4():void {
			player.ascensionPerkPoints -= 40;
			player.createPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage4, 0, 0, 0, 1);
			player.addStatusValue(StatusEffects.TranscendentalGeneticMemory, 1, 40);
			clearOutput();
			outputText("Your gained Transcendental Genetic Memory (Stage 4) perk.");
			doNext(rarePerks2);
		}
		private function perkUnderdog():void {
			player.ascensionPerkPoints -= 5;
			player.createPerk(PerkLib.AscensionUnderdog,0,0,0,1);
			clearOutput();
			outputText("Your gained Underdog perk.");
			doNext(rarePerks2);
		}
		private function perkUnlockedPotential():void {
			player.ascensionPerkPoints -= 5;
			player.createPerk(PerkLib.AscensionUnlockedPotential,0,0,0,1);
			clearOutput();
			outputText("Your gained Unlocked Potential perk.");
			doNext(rarePerks2);
		}
		private function perkUnlockedPotential2ndStage():void {
			player.ascensionPerkPoints -= 5;
			player.createPerk(PerkLib.AscensionUnlockedPotential2ndStage,0,0,0,1);
			clearOutput();
			outputText("Your gained Unlocked Potential (2nd Stage) perk.");
			doNext(rarePerks2);
		}

		private function historyTopastlife():void {
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) {
				player.removePerk(PerkLib.HistoryAlchemist);
				player.createPerk(PerkLib.PastLifeAlchemist,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.findPerk(PerkLib.HistoryCultivator) >= 0) {
				player.removePerk(PerkLib.HistoryCultivator);
				player.createPerk(PerkLib.PastLifeCultivator,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.findPerk(PerkLib.HistoryFighter) >= 0) {
				player.removePerk(PerkLib.HistoryFighter);
				player.createPerk(PerkLib.PastLifeFighter,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.findPerk(PerkLib.HistoryFortune) >= 0) {
				player.removePerk(PerkLib.HistoryFortune);
				player.createPerk(PerkLib.PastLifeFortune,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.findPerk(PerkLib.HistoryHealer) >= 0) {
				player.removePerk(PerkLib.HistoryHealer);
				player.createPerk(PerkLib.PastLifeHealer,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.findPerk(PerkLib.HistoryReligious) >= 0) {
				player.removePerk(PerkLib.HistoryReligious);
				player.createPerk(PerkLib.PastLifeReligious,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.findPerk(PerkLib.HistoryScholar) >= 0) {
				player.removePerk(PerkLib.HistoryScholar);
				player.createPerk(PerkLib.PastLifeScholar,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.findPerk(PerkLib.HistoryScout) >= 0) {
				player.removePerk(PerkLib.HistoryScout);
				player.createPerk(PerkLib.PastLifeScout,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.findPerk(PerkLib.HistorySlacker) >= 0) {
				player.removePerk(PerkLib.HistorySlacker);
				player.createPerk(PerkLib.PastLifeSlacker,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.findPerk(PerkLib.HistorySlut) >= 0) {
				player.removePerk(PerkLib.HistorySlut);
				player.createPerk(PerkLib.PastLifeSlut,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.findPerk(PerkLib.HistorySmith) >= 0) {
				player.removePerk(PerkLib.HistorySmith);
				player.createPerk(PerkLib.PastLifeSmith,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.findPerk(PerkLib.HistoryWhore) >= 0) {
				player.removePerk(PerkLib.HistoryWhore);
				player.createPerk(PerkLib.PastLifeWhore,0,0,0,1);
				historyTopastlife2();
			}
			else {
				clearOutput();
				outputText("You not have any History perk to change into Past Life perk.");
			}
			doNext(ascensionMenu);
		}
		
		private function historyTopastlife2():void {
			player.ascensionPerkPoints -= 5;
			clearOutput();
			outputText("Your History perk became your Past Life perk.");
		}
		
		private function ascensionPermeryMenu(page:int = 1):void {
			clearOutput();
			outputText("For the price of five points, you can make certain perks permanent and they will carry over in future ascensions. In addition, if the perks come from transformations, they will stay even if you no longer meet the requirements.");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			menu();
			if (page == 1) {
				if (player.findPerk(PerkLib.CorruptedKitsune) > 0 && player.perkv4(PerkLib.CorruptedKitsune) < 1) addButton(0, "CorruptedK", permanentizePerk1, PerkLib.CorruptedKitsune);
				else if (player.findPerk(PerkLib.CorruptedKitsune) > 0 && player.perkv4(PerkLib.CorruptedKitsune) > 0) addButtonDisabled(0, "CorruptedK", "Corrupted Kitsune perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(0, "CorruptedK", "Corrupted Kitsune");
				if (player.findPerk(PerkLib.CorruptedNinetails) > 0 && player.perkv4(PerkLib.CorruptedNinetails) < 1) addButton(1, "CorruptedN", permanentizePerk1, PerkLib.CorruptedNinetails);
				else if (player.findPerk(PerkLib.CorruptedNinetails) > 0 && player.perkv4(PerkLib.CorruptedNinetails) > 0) addButtonDisabled(1, "CorruptedN", "Corrupted Ninetails perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(1, "CorruptedN", "Corrupted Ninetails");
				if (player.findPerk(PerkLib.DarkCharm) > 0 && player.perkv4(PerkLib.DarkCharm) < 1) addButton(2, "DarkCharm", permanentizePerk1, PerkLib.DarkCharm);
				else if (player.findPerk(PerkLib.DarkCharm) > 0 && player.perkv4(PerkLib.DarkCharm) > 0) addButtonDisabled(2, "DarkCharm", "Dark Charm perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(2, "DarkCharm", "Dark Charm");
				if (player.findPerk(PerkLib.DragonDarknessBreath) > 0 && player.perkv4(PerkLib.DragonDarknessBreath) < 1) addButton(3, "D.DarknessB.", permanentizePerk1, PerkLib.DragonDarknessBreath);
				else if (player.findPerk(PerkLib.DragonDarknessBreath) > 0 && player.perkv4(PerkLib.DragonDarknessBreath) > 0) addButtonDisabled(3, "D.DarknessB.", "Dragon Darkness Breath perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(3, "D.DarknessB.", "Dragon Darkness Breath");
				addButton(4, "Next", ascensionPermeryMenu, page + 1);
				if (player.findPerk(PerkLib.DragonFireBreath) > 0 && player.perkv4(PerkLib.DragonFireBreath) < 1) addButton(5, "D.FireB.", permanentizePerk1, PerkLib.DragonFireBreath);
				else if (player.findPerk(PerkLib.DragonFireBreath) > 0 && player.perkv4(PerkLib.DragonFireBreath) > 0) addButtonDisabled(5, "D.FireB.", "Dragon Fire Breath perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(5, "D.FireB.", "Dragon Fire Breath");
				if (player.findPerk(PerkLib.DragonIceBreath) > 0 && player.perkv4(PerkLib.DragonIceBreath) < 1) addButton(6, "D.IceB.", permanentizePerk1, PerkLib.DragonIceBreath);
				else if (player.findPerk(PerkLib.DragonIceBreath) > 0 && player.perkv4(PerkLib.DragonIceBreath) > 0) addButtonDisabled(6, "D.IceB.", "Dragon Ice Breath perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(6, "D.IceB.", "Dragon Ice Breath");
				if (player.findPerk(PerkLib.DragonLightningBreath) > 0 && player.perkv4(PerkLib.DragonLightningBreath) < 1) addButton(7, "D.LightningB.", permanentizePerk1, PerkLib.DragonLightningBreath);
				else if (player.findPerk(PerkLib.DragonLightningBreath) > 0 && player.perkv4(PerkLib.DragonLightningBreath) > 0) addButtonDisabled(7, "D.LightningB.", "Dragon Lightning Breath perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(7, "D.LightningB.", "Dragon Lightning Breath");
				if (player.findPerk(PerkLib.EnlightenedKitsune) > 0 && player.perkv4(PerkLib.EnlightenedKitsune) < 1) addButton(8, "EnlightenedK", permanentizePerk1, PerkLib.EnlightenedKitsune);
				else if (player.findPerk(PerkLib.EnlightenedKitsune) > 0 && player.perkv4(PerkLib.EnlightenedKitsune) > 0) addButtonDisabled(8, "EnlightenedK", "Enlightened Kitsune perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(8, "EnlightenedK", "Enlightened Kitsune");
				if (player.findPerk(PerkLib.EnlightenedNinetails) > 0 && player.perkv4(PerkLib.EnlightenedNinetails) < 1) addButton(10, "EnlightenedN", permanentizePerk1, PerkLib.EnlightenedNinetails);
				else if (player.findPerk(PerkLib.EnlightenedNinetails) > 0 && player.perkv4(PerkLib.EnlightenedNinetails) > 0) addButtonDisabled(10, "EnlightenedN", "Enlightened Ninetails perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(10, "EnlightenedN", "Enlightened Ninetails");
				if (player.findPerk(PerkLib.FerasBoonAlpha) > 0 && player.perkv4(PerkLib.FerasBoonAlpha) < 1) addButton(11, "FerasB.A.", permanentizePerk1, PerkLib.FerasBoonAlpha);
				else if (player.findPerk(PerkLib.FerasBoonAlpha) > 0 && player.perkv4(PerkLib.FerasBoonAlpha) > 0) addButtonDisabled(11, "FerasB.A.", "Feras Boon Alpha perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(11, "FerasB.A.", "Feras Boon Alpha");
				if (player.findPerk(PerkLib.FerasBoonBreedingBitch) > 0 && player.perkv4(PerkLib.FerasBoonBreedingBitch) < 1) addButton(12, "FerasB.B.B.", permanentizePerk1, PerkLib.FerasBoonBreedingBitch);
				else if (player.findPerk(PerkLib.FerasBoonBreedingBitch) > 0 && player.perkv4(PerkLib.FerasBoonBreedingBitch) > 0) addButtonDisabled(12, "FerasB.B.B.", "Feras Boon Breeding Bitch perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(12, "FerasB.B.B.", "Feras Boon Breeding Bitch");
				if (player.findPerk(PerkLib.FerasBoonMilkingTwat) > 0 && player.perkv4(PerkLib.FerasBoonMilkingTwat) < 1) addButton(13, "FerasB.M.T.", permanentizePerk1, PerkLib.FerasBoonMilkingTwat);
				else if (player.findPerk(PerkLib.FerasBoonMilkingTwat) > 0 && player.perkv4(PerkLib.FerasBoonMilkingTwat) > 0) addButtonDisabled(13, "FerasB.M.T.", "Feras Boon Milking Twat perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(13, "FerasB.M.T.", "Feras Boon Milking Twat");
			}
			if (page == 2) {
				if (player.findPerk(PerkLib.FerasBoonSeeder) > 0 && player.perkv4(PerkLib.FerasBoonSeeder) < 1) addButton(0, "FerasB.S.", permanentizePerk2, PerkLib.FerasBoonSeeder);
				else if (player.findPerk(PerkLib.FerasBoonSeeder) > 0 && player.perkv4(PerkLib.FerasBoonSeeder) > 0) addButtonDisabled(0, "FerasB.S.", "Feras Boon Seeder perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(0, "FerasB.S.", "Feras Boon Seeder");
				if (player.findPerk(PerkLib.FireLord) > 0 && player.perkv4(PerkLib.FireLord) < 1) addButton(1, "FireLord", permanentizePerk2, PerkLib.FireLord);
				else if (player.findPerk(PerkLib.FireLord) > 0 && player.perkv4(PerkLib.FireLord) > 0) addButtonDisabled(1, "FireLord", "FireLord perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(1, "FireLord", "FireLord");
				if (player.findPerk(PerkLib.Flexibility) > 0 && player.perkv4(PerkLib.Flexibility) < 1) addButton(2, "Flexibility", permanentizePerk2, PerkLib.Flexibility);
				else if (player.findPerk(PerkLib.Flexibility) > 0 && player.perkv4(PerkLib.Flexibility) > 0) addButtonDisabled(2, "Flexibility", "Flexibility perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(2, "Flexibility", "Flexibility");
				if (player.findPerk(PerkLib.Hellfire) > 0 && player.perkv4(PerkLib.Hellfire) < 1) addButton(3, "Hellfire", permanentizePerk2, PerkLib.Hellfire);
				else if (player.findPerk(PerkLib.Hellfire) > 0 && player.perkv4(PerkLib.Hellfire) > 0) addButtonDisabled(3, "Hellfire", "Hellfire perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(3, "Hellfire", "Hellfire");
				addButton(4, "Next", ascensionPermeryMenu, page + 1);
				if (player.findPerk(PerkLib.InkSpray) > 0 && player.perkv4(PerkLib.InkSpray) < 1) addButton(5, "InkSpray", permanentizePerk2, PerkLib.InkSpray);
				else if (player.findPerk(PerkLib.InkSpray) > 0 && player.perkv4(PerkLib.InkSpray) > 0) addButtonDisabled(5, "InkSpray", "Ink Spray perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(5, "InkSpray", "Ink Spray");
				if (player.findPerk(PerkLib.LizanRegeneration) > 0 && player.perkv4(PerkLib.LizanRegeneration) < 1) addButton(6, "LizanRegen", permanentizePerk2, PerkLib.LizanRegeneration);
				else if (player.findPerk(PerkLib.LizanRegeneration) > 0 && player.perkv4(PerkLib.LizanRegeneration) > 0) addButtonDisabled(6, "LizanRegen", "Lizan Regeneration perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(6, "LizanRegen", "Lizan Regeneration");
				if (player.findPerk(PerkLib.Lustzerker) > 0 && player.perkv4(PerkLib.Lustzerker) < 1) addButton(7, "Lustzerker", permanentizePerk2, PerkLib.Lustzerker);
				else if (player.findPerk(PerkLib.Lustzerker) > 0 && player.perkv4(PerkLib.Lustzerker) > 0) addButtonDisabled(7, "Lustzerker", "Lustzerker perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(7, "Lustzerker", "Lustzerker");
				if (player.findPerk(PerkLib.MagicalFertility) > 0 && player.perkv4(PerkLib.MagicalFertility) < 1) addButton(8, "MagicalF.", permanentizePerk2, PerkLib.MagicalFertility);
				else if (player.findPerk(PerkLib.MagicalFertility) > 0 && player.perkv4(PerkLib.MagicalFertility) > 0) addButtonDisabled(8, "MagicalF.", "Magical Fertility perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(8, "MagicalF.", "Magical Fertility");
				addButton(9, "Previous", ascensionPermeryMenu, page - 1);
				if (player.findPerk(PerkLib.MagicalVirility) > 0 && player.perkv4(PerkLib.MagicalVirility) < 1) addButton(10, "MagicalV.", permanentizePerk2, PerkLib.MagicalVirility);
				else if (player.findPerk(PerkLib.MagicalVirility) > 0 && player.perkv4(PerkLib.MagicalVirility) > 0) addButtonDisabled(10, "MagicalV.", "Magical Virility perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(10, "MagicalV.", "Magical Virility");
				if (player.findPerk(PerkLib.MaraesGiftButtslut) > 0 && player.perkv4(PerkLib.MaraesGiftButtslut) < 1) addButton(11, "MaraesGiftB.", permanentizePerk2, PerkLib.MaraesGiftButtslut);
				else if (player.findPerk(PerkLib.MaraesGiftButtslut) > 0 && player.perkv4(PerkLib.MaraesGiftButtslut) > 0) addButtonDisabled(11, "MaraesGiftB.", "Maraes Gift Buttslut perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(11, "MaraesGiftB.", "Maraes Gift Buttslut");
				if (player.findPerk(PerkLib.MaraesGiftFertility) > 0 && player.perkv4(PerkLib.MaraesGiftFertility) < 1) addButton(12, "MaraesGiftF.", permanentizePerk2, PerkLib.MaraesGiftFertility);
				else if (player.findPerk(PerkLib.MaraesGiftFertility) > 0 && player.perkv4(PerkLib.MaraesGiftFertility) > 0) addButtonDisabled(12, "MaraesGiftF.", "Maraes Gift Fertility perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(12, "MaraesGiftF.", "Maraes Gift Fertility");
				if (player.findPerk(PerkLib.MaraesGiftProfractory) > 0 && player.perkv4(PerkLib.MaraesGiftProfractory) < 1) addButton(13, "MaraesGiftP.", permanentizePerk2, PerkLib.MaraesGiftProfractory);
				else if (player.findPerk(PerkLib.MaraesGiftProfractory) > 0 && player.perkv4(PerkLib.MaraesGiftProfractory) > 0) addButtonDisabled(13, "MaraesGiftP.", "Maraes Gift Profractory perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(13, "MaraesGiftP.", "Maraes Gift Profractory");
			}
			if (page == 3) {
				if (player.findPerk(PerkLib.MaraesGiftStud) > 0 && player.perkv4(PerkLib.MaraesGiftStud) < 1) addButton(0, "MaraesGiftS.", permanentizePerk3, PerkLib.MaraesGiftStud);
				else if (player.findPerk(PerkLib.MaraesGiftStud) > 0 && player.perkv4(PerkLib.MaraesGiftStud) > 0) addButtonDisabled(0, "MaraesGiftS.", "Maraes Gift Stud perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(0, "MaraesGiftS.", "Maraes Gift Stud");
				if (player.findPerk(PerkLib.MilkMaid) > 0 && player.perkv4(PerkLib.MilkMaid) < 1) addButton(1, "MilkMaid", permanentizePerk3, PerkLib.MilkMaid);
				else if (player.findPerk(PerkLib.MilkMaid) > 0 && player.perkv4(PerkLib.MilkMaid) > 0) addButtonDisabled(1, "MilkMaid", "MilkMaid perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(1, "MilkMaid", "MilkMaid");
				if (player.findPerk(PerkLib.NinetailsKitsuneOfBalance) > 0 && player.perkv4(PerkLib.NinetailsKitsuneOfBalance) < 1) addButton(2, "9TKitsOfB", permanentizePerk3, PerkLib.NinetailsKitsuneOfBalance);
				else if (player.findPerk(PerkLib.NinetailsKitsuneOfBalance) > 0 && player.perkv4(PerkLib.NinetailsKitsuneOfBalance) > 0) addButtonDisabled(2, "9TKitsOfB", "9T Kitsune Of Balance perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(2, "9TKitsOfB", "9T Kitsune Of Balance");
				if (player.findPerk(PerkLib.OneTrackMind) > 0 && player.perkv4(PerkLib.OneTrackMind) < 1) addButton(3, "OneTrackMind", permanentizePerk3, PerkLib.OneTrackMind);
				else if (player.findPerk(PerkLib.OneTrackMind) > 0 && player.perkv4(PerkLib.OneTrackMind) > 0) addButtonDisabled(3, "OneTrackMind", "One Track Mind perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(3, "OneTrackMind", "One Track Mind");
				//addButton(4, "Next", ascensionPermeryMenu, page + 1);
				if (player.findPerk(PerkLib.PureAndLoving) > 0 && player.perkv4(PerkLib.PureAndLoving) < 1) addButton(5, "Pure&Loving", permanentizePerk3, PerkLib.PureAndLoving);
				else if (player.findPerk(PerkLib.PureAndLoving) > 0 && player.perkv4(PerkLib.PureAndLoving) > 0) addButtonDisabled(5, "Pure&Loving", "Pure And Loving perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(5, "Pure&Loving", "Pure And Loving");
				if (player.findPerk(PerkLib.PurityBlessing) > 0 && player.perkv4(PerkLib.PurityBlessing) < 1) addButton(6, "PurityBlessing", permanentizePerk3, PerkLib.PurityBlessing);
				else if (player.findPerk(PerkLib.PurityBlessing) > 0 && player.perkv4(PerkLib.PurityBlessing) > 0) addButtonDisabled(6, "PurityBlessing", "Purity Blessing perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(6, "PurityBlessing", "Purity Blessing");
				if (player.findPerk(PerkLib.SensualLover) > 0 && player.perkv4(PerkLib.SensualLover) < 1) addButton(7, "SensualLover", permanentizePerk3, PerkLib.SensualLover);
				else if (player.findPerk(PerkLib.SensualLover) > 0 && player.perkv4(PerkLib.SensualLover) > 0) addButtonDisabled(7, "SensualLover", "Sensual Lover perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(7, "SensualLover", "Sensual Lover");
				addButton(9, "Previous", ascensionPermeryMenu, page - 1);
			}
			addButton(14, "Back", ascensionMenu);
		}

		private function permanentizePerk1(perk:PerkType):void {
			//Not enough points or perk already permed? Cancel.
			if (player.ascensionPerkPoints < 5) return;
			if (player.perkv4(perk) > 0) return;
			//Deduct points
			player.ascensionPerkPoints -= 5;
			//Permanentize a perk
			player.addPerkValue(perk, 4, 1);
			ascensionPermeryMenu(1);
		}
		private function permanentizePerk2(perk:PerkType):void {
			//Not enough points or perk already permed? Cancel.
			if (player.ascensionPerkPoints < 5) return;
			if (player.perkv4(perk) > 0) return;
			//Deduct points
			player.ascensionPerkPoints -= 5;
			//Permanentize a perk
			player.addPerkValue(perk, 4, 1);
			ascensionPermeryMenu(2);
		}
		private function permanentizePerk3(perk:PerkType):void {
			//Not enough points or perk already permed? Cancel.
			if (player.ascensionPerkPoints < 5) return;
			if (player.perkv4(perk) > 0) return;
			//Deduct points
			player.ascensionPerkPoints -= 5;
			//Permanentize a perk
			player.addPerkValue(perk, 4, 1);
			ascensionPermeryMenu(3);
		}
		
		private function ascensionMetamorphPermeryMenu(page:int = 1):void {
			clearOutput();
			outputText("For the price of five points, you can make unlocked Metamorph options permanent (up to current limit) and they will carry over in future ascensions.");
			outputText("\n\nCurent amount of pernament options / Max cap for pernament options: " + player.statusEffectv2(StatusEffects.TranscendentalGeneticMemory) + " / " + player.statusEffectv1(StatusEffects.TranscendentalGeneticMemory) + "");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			menu();
			if (page == 1) {
				if (player.hasStatusEffect(StatusEffects.UnlockedFur) && player.statusEffectv4(StatusEffects.UnlockedFur) < 9000) addButton(0, "Fur", permanentizeStatusEffect1, StatusEffects.UnlockedFur);
				else if (player.hasStatusEffect(StatusEffects.UnlockedFur) && player.statusEffectv4(StatusEffects.UnlockedFur) == 9000) addButtonDisabled(0, "Fur", "Fur option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(0, "Fur", "Fur");
				if (player.hasStatusEffect(StatusEffects.UnlockedScales) && player.statusEffectv4(StatusEffects.UnlockedScales) < 9000) addButton(1, "Scales", permanentizeStatusEffect1, StatusEffects.UnlockedScales);
				else if (player.hasStatusEffect(StatusEffects.UnlockedScales) && player.statusEffectv4(StatusEffects.UnlockedScales) == 9000) addButtonDisabled(1, "Scales", "Scales option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(1, "Scales", "Scales");
				if (player.hasStatusEffect(StatusEffects.UnlockedChitin) && player.statusEffectv4(StatusEffects.UnlockedChitin) < 9000) addButton(2, "Chitin", permanentizeStatusEffect1, StatusEffects.UnlockedChitin);
				else if (player.hasStatusEffect(StatusEffects.UnlockedChitin) && player.statusEffectv4(StatusEffects.UnlockedChitin) == 9000) addButtonDisabled(2, "Chitin", "Chitin option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(2, "Chitin", "Chitin");
				if (player.hasStatusEffect(StatusEffects.UnlockedDragonScales) && player.statusEffectv4(StatusEffects.UnlockedDragonScales) < 9000) addButton(3, "D.Scales", permanentizeStatusEffect1, StatusEffects.UnlockedDragonScales);
				else if (player.hasStatusEffect(StatusEffects.UnlockedDragonScales) && player.statusEffectv4(StatusEffects.UnlockedDragonScales) == 9000) addButtonDisabled(3, "D.Scales", "Dragon Scales option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(3, "D.Scales", "Dragon Scales");
				addButton(4, "Next", ascensionMetamorphPermeryMenu, page + 1);
				if (player.hasStatusEffect(StatusEffects.UnlockedFoxLowerBody) && player.statusEffectv4(StatusEffects.UnlockedFoxLowerBody) < 9000) addButton(5, "Fox Legs", permanentizeStatusEffect1, StatusEffects.UnlockedFoxLowerBody);
				else if (player.hasStatusEffect(StatusEffects.UnlockedFoxLowerBody) && player.statusEffectv4(StatusEffects.UnlockedFoxLowerBody) == 9000) addButtonDisabled(5, "Fox Legs", "Fox Legs option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(5, "Fox Legs", "Fox Legs");
				if (player.hasStatusEffect(StatusEffects.UnlockedFoxArms) && player.statusEffectv4(StatusEffects.UnlockedFoxArms) < 9000) addButton(6, "Fox Arms", permanentizeStatusEffect1, StatusEffects.UnlockedFoxArms);
				else if (player.hasStatusEffect(StatusEffects.UnlockedFoxArms) && player.statusEffectv4(StatusEffects.UnlockedFoxArms) == 9000) addButtonDisabled(6, "Fox Arms", "Fox Arms option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(6, "Fox Arms", "Fox Arms");
				if (player.hasStatusEffect(StatusEffects.UnlockedFoxEars) && player.statusEffectv4(StatusEffects.UnlockedFoxEars) < 9000) addButton(7, "Fox Ears", permanentizeStatusEffect1, StatusEffects.UnlockedFoxEars);
				else if (player.hasStatusEffect(StatusEffects.UnlockedFoxEars) && player.statusEffectv4(StatusEffects.UnlockedFoxEars) == 9000) addButtonDisabled(7, "Fox Ears", "Fox Ears option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(7, "Fox Ears", "Fox Ears");
				if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail) && player.statusEffectv4(StatusEffects.UnlockedFoxTail) < 9000) addButton(8, "Fox Tail", permanentizeStatusEffect1, StatusEffects.UnlockedFoxTail);
				else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail) && player.statusEffectv4(StatusEffects.UnlockedFoxTail) == 9000) addButtonDisabled(8, "Fox Tail", "Fox Tail option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(8, "Fox Tail", "Fox Tail");
				if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail2nd) && player.statusEffectv4(StatusEffects.UnlockedFoxTail2nd) < 9000) addButton(10, "Fox Tail 2", permanentizeStatusEffect1, StatusEffects.UnlockedFoxTail2nd);
				else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail2nd) && player.statusEffectv4(StatusEffects.UnlockedFoxTail2nd) == 9000) addButtonDisabled(10, "Fox Tail 2", "Fox Tail 2nd option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(10, "Fox Tail 2", "Fox Tail 2nd");
				if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail3rd) && player.statusEffectv4(StatusEffects.UnlockedFoxTail3rd) < 9000) addButton(11, "Fox Tail 3", permanentizeStatusEffect1, StatusEffects.UnlockedFoxTail3rd);
				else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail3rd) && player.statusEffectv4(StatusEffects.UnlockedFoxTail3rd) == 9000) addButtonDisabled(11, "Fox Tail 3", "Fox Tail 3rd option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(11, "Fox Tail 3", "Fox Tail 3rd");
				if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail4th) && player.statusEffectv4(StatusEffects.UnlockedFoxTail4th) < 9000) addButton(12, "Fox Tail 4", permanentizeStatusEffect1, StatusEffects.UnlockedFoxTail4th);
				else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail4th) && player.statusEffectv4(StatusEffects.UnlockedFoxTail4th) == 9000) addButtonDisabled(12, "Fox Tail 4", "Fox Tail 4th option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(12, "Fox Tail 4", "Fox Tail 4th");
				if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail5th) && player.statusEffectv4(StatusEffects.UnlockedFoxTail5th) < 9000) addButton(13, "Fox Tail 5", permanentizeStatusEffect1, StatusEffects.UnlockedFoxTail5th);
				else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail5th) && player.statusEffectv4(StatusEffects.UnlockedFoxTail5th) == 9000) addButtonDisabled(13, "Fox Tail 5", "Fox Tail 5th option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(13, "Fox Tail 5", "Fox Tail 5th");
			}
			if (page == 2) {
				if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail6th) && player.statusEffectv4(StatusEffects.UnlockedFoxTail6th) < 9000) addButton(0, "Fox Tail 6", permanentizeStatusEffect2, StatusEffects.UnlockedFoxTail6th);
				else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail6th) && player.statusEffectv4(StatusEffects.UnlockedFoxTail6th) == 9000) addButtonDisabled(0, "Fox Tail 6", "Fox Tail 6th option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(0, "Fox Tail 6", "Fox Tail 6th");
				if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail7th) && player.statusEffectv4(StatusEffects.UnlockedFoxTail7th) < 9000) addButton(1, "Fox Tail 7", permanentizeStatusEffect2, StatusEffects.UnlockedFoxTail7th);
				else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail7th) && player.statusEffectv4(StatusEffects.UnlockedFoxTail7th) == 9000) addButtonDisabled(1, "Fox Tail 7", "Fox Tail 7th option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(1, "Fox Tail 7", "Fox Tail 7th");
				if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail8th) && player.statusEffectv4(StatusEffects.UnlockedFoxTail8th) < 9000) addButton(2, "Fox Tail 8", permanentizeStatusEffect2, StatusEffects.UnlockedFoxTail8th);
				else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail8th) && player.statusEffectv4(StatusEffects.UnlockedFoxTail8th) == 9000) addButtonDisabled(2, "Fox Tail 8", "Fox Tail 8th option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(2, "Fox Tail 8", "Fox Tail 8th");
				if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail9th) && player.statusEffectv4(StatusEffects.UnlockedFoxTail9th) < 9000) addButton(3, "Fox Tail 9", permanentizeStatusEffect2, StatusEffects.UnlockedFoxTail9th);
				else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail9th) && player.statusEffectv4(StatusEffects.UnlockedFoxTail9th) == 9000) addButtonDisabled(3, "Fox Tail 9", "Fox Tail 9th option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(3, "Fox Tail 9", "Fox Tail 9th");
				addButton(4, "Next", ascensionMetamorphPermeryMenu, page + 1);
				if (player.hasStatusEffect(StatusEffects.UnlockedFoxFace) && player.statusEffectv4(StatusEffects.UnlockedFoxFace) < 9000) addButton(5, "Fox Face", permanentizeStatusEffect2, StatusEffects.UnlockedFoxFace);
				else if (player.hasStatusEffect(StatusEffects.UnlockedFoxFace) && player.statusEffectv4(StatusEffects.UnlockedFoxFace) == 9000) addButtonDisabled(5, "Fox Face", "Fox Face option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(5, "Fox Face", "Fox Face");
				if (player.hasStatusEffect(StatusEffects.UnlockedFoxEyes) && player.statusEffectv4(StatusEffects.UnlockedFoxEyes) < 9000) addButton(6, "Fox Eyes", permanentizeStatusEffect2, StatusEffects.UnlockedFoxEyes);
				else if (player.hasStatusEffect(StatusEffects.UnlockedFoxEyes) && player.statusEffectv4(StatusEffects.UnlockedFoxEyes) == 9000) addButtonDisabled(6, "Fox Eyes", "Fox Eyes option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(6, "Fox Eyes", "Fox Eyes");
				if (player.hasStatusEffect(StatusEffects.UnlockedKitsuneArms) && player.statusEffectv4(StatusEffects.UnlockedKitsuneArms) < 9000) addButton(7, "Kitsune Arms", permanentizeStatusEffect2, StatusEffects.UnlockedKitsuneArms);
				else if (player.hasStatusEffect(StatusEffects.UnlockedKitsuneArms) && player.statusEffectv4(StatusEffects.UnlockedKitsuneArms) == 9000) addButtonDisabled(7, "Kitsune Arms", "Kitsune Arms option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(7, "Kitsune Arms", "Kitsune Arms");
				if (player.hasStatusEffect(StatusEffects.UnlockedDemonTail) && player.statusEffectv4(StatusEffects.UnlockedDemonTail) < 9000) addButton(8, "Demon Tail", permanentizeStatusEffect2, StatusEffects.UnlockedDemonTail);
				else if (player.hasStatusEffect(StatusEffects.UnlockedDemonTail) && player.statusEffectv4(StatusEffects.UnlockedDemonTail) == 9000) addButtonDisabled(8, "Demon Tail", "Demon Tail option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(8, "Demon Tail", "Demon Tail");
				addButton(9, "Previous", ascensionMetamorphPermeryMenu, page - 1);
				if (player.hasStatusEffect(StatusEffects.UnlockedDemonHorns) && player.statusEffectv4(StatusEffects.UnlockedDemonHorns) < 9000) addButton(10, "Demon Horns", permanentizeStatusEffect2, StatusEffects.UnlockedDemonHorns);
				else if (player.hasStatusEffect(StatusEffects.UnlockedDemonHorns) && player.statusEffectv4(StatusEffects.UnlockedDemonHorns) == 9000) addButtonDisabled(10, "Demon Horns", "Demon Horns option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(10, "Demon Horns", "Demon Horns");
				if (player.hasStatusEffect(StatusEffects.UnlockedDemonTonuge) && player.statusEffectv4(StatusEffects.UnlockedDemonTonuge) < 9000) addButton(11, "Demon Tonuge", permanentizeStatusEffect2, StatusEffects.UnlockedDemonTonuge);
				else if (player.hasStatusEffect(StatusEffects.UnlockedDemonTonuge) && player.statusEffectv4(StatusEffects.UnlockedDemonTonuge) == 9000) addButtonDisabled(11, "Demon Tonuge", "Demon Tonuge option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(11, "Demon Tonuge", "Demon Tonuge");
				if (player.hasStatusEffect(StatusEffects.UnlockedDemonHighHeels) && player.statusEffectv4(StatusEffects.UnlockedDemonHighHeels) < 9000) addButton(12, "D. High Heels", permanentizeStatusEffect2, StatusEffects.UnlockedDemonHighHeels);
				else if (player.hasStatusEffect(StatusEffects.UnlockedDemonHighHeels) && player.statusEffectv4(StatusEffects.UnlockedDemonHighHeels) == 9000) addButtonDisabled(12, "D. High Heels", "Demon High Heels option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(12, "D. High Heels", "Demon High Heels");
				if (player.hasStatusEffect(StatusEffects.UnlockedDemonClawedLegs) && player.statusEffectv4(StatusEffects.UnlockedDemonClawedLegs) < 9000) addButton(13, "D. Clawed Legs", permanentizeStatusEffect2, StatusEffects.UnlockedDemonClawedLegs);
				else if (player.hasStatusEffect(StatusEffects.UnlockedDemonClawedLegs) && player.statusEffectv4(StatusEffects.UnlockedDemonClawedLegs) == 9000) addButtonDisabled(13, "D. Clawed Legs", "Demon Clawed Legs option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(13, "D. Clawed Legs", "Demon Clawed Legs");
			}
			if (page == 3) {
				if (player.hasStatusEffect(StatusEffects.UnlockedDemonTinyBatWings) && player.statusEffectv4(StatusEffects.UnlockedDemonTinyBatWings) < 9000) addButton(0, "T. Bat Wings", permanentizeStatusEffect3, StatusEffects.UnlockedDemonTinyBatWings);
				else if (player.hasStatusEffect(StatusEffects.UnlockedDemonTinyBatWings) && player.statusEffectv4(StatusEffects.UnlockedDemonTinyBatWings) == 9000) addButtonDisabled(0, "T. Bat Wings", "Tiny Bat Wings option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(0, "T. Bat Wings", "Tiny Bat Wings");
				if (player.hasStatusEffect(StatusEffects.UnlockedDemonLargeBatWings) && player.statusEffectv4(StatusEffects.UnlockedDemonLargeBatWings) < 9000) addButton(1, "L. Bat Wings", permanentizeStatusEffect3, StatusEffects.UnlockedDemonLargeBatWings);
				else if (player.hasStatusEffect(StatusEffects.UnlockedDemonLargeBatWings) && player.statusEffectv4(StatusEffects.UnlockedDemonLargeBatWings) == 9000) addButtonDisabled(1, "L. Bat Wings", "Large Bat Wings option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(1, "L. Bat Wings", "Large Bat Wings");
				if (player.hasStatusEffect(StatusEffects.UnlockedDemonLargeBatWings2) && player.statusEffectv4(StatusEffects.UnlockedDemonLargeBatWings2) < 9000) addButton(2, "L. Bat Wings(2)", permanentizeStatusEffect3, StatusEffects.UnlockedDemonLargeBatWings2);
				else if (player.hasStatusEffect(StatusEffects.UnlockedDemonLargeBatWings2) && player.statusEffectv4(StatusEffects.UnlockedDemonLargeBatWings2) == 9000) addButtonDisabled(2, "L. Bat Wings(2)", "Large Bat Wings (2nd pair) option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(2, "L. Bat Wings(2)", "Large Bat Wings (2nd pair)");
				if (player.hasStatusEffect(StatusEffects.UnlockedLizardLegs) && player.statusEffectv4(StatusEffects.UnlockedLizardLegs) < 9000) addButton(3, "Lizard Legs", permanentizeStatusEffect3, StatusEffects.UnlockedLizardLegs);
				else if (player.hasStatusEffect(StatusEffects.UnlockedLizardLegs) && player.statusEffectv4(StatusEffects.UnlockedLizardLegs) == 9000) addButtonDisabled(3, "Lizard Legs", "Lizard Legs option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(3, "Lizard Legs", "Lizard Legs");
				addButton(4, "Next", ascensionMetamorphPermeryMenu, page + 1);
				if (player.hasStatusEffect(StatusEffects.UnlockedLizardArms) && player.statusEffectv4(StatusEffects.UnlockedLizardArms) < 9000) addButton(5, "Lizard Arms", permanentizeStatusEffect3, StatusEffects.UnlockedLizardArms);
				else if (player.hasStatusEffect(StatusEffects.UnlockedLizardArms) && player.statusEffectv4(StatusEffects.UnlockedLizardArms) == 9000) addButtonDisabled(5, "Lizard Arms", "Lizard Arms option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(5, "Lizard Arms", "Lizard Arms");
				if (player.hasStatusEffect(StatusEffects.UnlockedLizardTail) && player.statusEffectv4(StatusEffects.UnlockedLizardTail) < 9000) addButton(6, "Lizard Tail", permanentizeStatusEffect3, StatusEffects.UnlockedLizardTail);
				else if (player.hasStatusEffect(StatusEffects.UnlockedLizardTail) && player.statusEffectv4(StatusEffects.UnlockedLizardTail) == 9000) addButtonDisabled(6, "Lizard Tail", "Lizard Tail option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(6, "Lizard Tail", "Lizard Tail");
				if (player.hasStatusEffect(StatusEffects.UnlockedLizardEyes) && player.statusEffectv4(StatusEffects.UnlockedLizardEyes) < 9000) addButton(7, "Lizard Eyes", permanentizeStatusEffect3, StatusEffects.UnlockedLizardEyes);
				else if (player.hasStatusEffect(StatusEffects.UnlockedLizardEyes) && player.statusEffectv4(StatusEffects.UnlockedLizardEyes) == 9000) addButtonDisabled(7, "Lizard Eyes", "Lizard Eyes option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(7, "Lizard Eyes", "Lizard Eyes");
				if (player.hasStatusEffect(StatusEffects.UnlockedLizardEars) && player.statusEffectv4(StatusEffects.UnlockedLizardEars) < 9000) addButton(8, "Lizard Ears", permanentizeStatusEffect3, StatusEffects.UnlockedLizardEars);
				else if (player.hasStatusEffect(StatusEffects.UnlockedLizardEars) && player.statusEffectv4(StatusEffects.UnlockedLizardEars) == 9000) addButtonDisabled(8, "Lizard Ears", "Lizard Ears option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(8, "Lizard Ears", "Lizard Ears");
				addButton(9, "Previous", ascensionMetamorphPermeryMenu, page - 1);
				if (player.hasStatusEffect(StatusEffects.UnlockedLizardFace) && player.statusEffectv4(StatusEffects.UnlockedLizardFace) < 9000) addButton(10, "Lizard Face", permanentizeStatusEffect3, StatusEffects.UnlockedLizardFace);
				else if (player.hasStatusEffect(StatusEffects.UnlockedLizardFace) && player.statusEffectv4(StatusEffects.UnlockedLizardFace) == 9000) addButtonDisabled(10, "Lizard Face", "Lizard Face option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(10, "Lizard Face", "Lizard Face");
				if (player.hasStatusEffect(StatusEffects.UnlockedBeeAntennae) && player.statusEffectv4(StatusEffects.UnlockedBeeAntennae) < 9000) addButton(11, "Bee Antennae", permanentizeStatusEffect3, StatusEffects.UnlockedBeeAntennae);
				else if (player.hasStatusEffect(StatusEffects.UnlockedBeeAntennae) && player.statusEffectv4(StatusEffects.UnlockedBeeAntennae) == 9000) addButtonDisabled(11, "Bee Antennae", "Bee Antennae option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(11, "Bee Antennae", "Bee Antennae");
				if (player.hasStatusEffect(StatusEffects.UnlockedBeeArms) && player.statusEffectv4(StatusEffects.UnlockedBeeArms) < 9000) addButton(12, "Bee Arms", permanentizeStatusEffect3, StatusEffects.UnlockedBeeArms);
				else if (player.hasStatusEffect(StatusEffects.UnlockedBeeArms) && player.statusEffectv4(StatusEffects.UnlockedBeeArms) == 9000) addButtonDisabled(12, "Bee Arms", "Bee Arms option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(12, "Bee Arms", "Bee Arms");
				if (player.hasStatusEffect(StatusEffects.UnlockedBeeLegs) && player.statusEffectv4(StatusEffects.UnlockedBeeLegs) < 9000) addButton(13, "Bee Legs", permanentizeStatusEffect3, StatusEffects.UnlockedBeeLegs);
				else if (player.hasStatusEffect(StatusEffects.UnlockedBeeLegs) && player.statusEffectv4(StatusEffects.UnlockedBeeLegs) == 9000) addButtonDisabled(13, "Bee Legs", "Bee Legs option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(13, "Bee Legs", "Bee Legs");
			}
			if (page == 4) {
				if (player.hasStatusEffect(StatusEffects.UnlockedBeeTail) && player.statusEffectv4(StatusEffects.UnlockedBeeTail) < 9000) addButton(0, "Bee Tail", permanentizeStatusEffect4, StatusEffects.UnlockedBeeTail);
				else if (player.hasStatusEffect(StatusEffects.UnlockedBeeTail) && player.statusEffectv4(StatusEffects.UnlockedBeeTail) == 9000) addButtonDisabled(0, "Bee Tail", "Bee Tail option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(0, "Bee Tail", "Bee Tail");
				if (player.hasStatusEffect(StatusEffects.UnlockedBeeWingsSmall) && player.statusEffectv4(StatusEffects.UnlockedBeeWingsSmall) < 9000) addButton(1, "Bee Wings S.", permanentizeStatusEffect4, StatusEffects.UnlockedBeeWingsSmall);
				else if (player.hasStatusEffect(StatusEffects.UnlockedBeeWingsSmall) && player.statusEffectv4(StatusEffects.UnlockedBeeWingsSmall) == 9000) addButtonDisabled(1, "Bee Wings S.", "Bee Wings Small option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(1, "Bee Wings S.", "Bee Wings Small");
				if (player.hasStatusEffect(StatusEffects.UnlockedBeeWingsLarge) && player.statusEffectv4(StatusEffects.UnlockedBeeWingsLarge) < 9000) addButton(2, "Bee Wings L.", permanentizeStatusEffect4, StatusEffects.UnlockedBeeWingsLarge);
				else if (player.hasStatusEffect(StatusEffects.UnlockedBeeWingsLarge) && player.statusEffectv4(StatusEffects.UnlockedBeeWingsLarge) == 9000) addButtonDisabled(2, "Bee Wings L.", "Bee Wings Large option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(2, "Bee Wings L.", "Bee Wings Large");
				if (player.hasStatusEffect(StatusEffects.UnlockedHarpyLegs) && player.statusEffectv4(StatusEffects.UnlockedHarpyLegs) < 9000) addButton(3, "Harpy Legs", permanentizeStatusEffect4, StatusEffects.UnlockedHarpyLegs);
				else if (player.hasStatusEffect(StatusEffects.UnlockedHarpyLegs) && player.statusEffectv4(StatusEffects.UnlockedHarpyLegs) == 9000) addButtonDisabled(3, "Harpy Legs", "Harpy Legs option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(3, "Harpy Legs", "Harpy Legs");
				addButton(4, "Next", ascensionMetamorphPermeryMenu, page + 1);
				if (player.hasStatusEffect(StatusEffects.UnlockedHarpyTail) && player.statusEffectv4(StatusEffects.UnlockedHarpyTail) < 9000) addButton(5, "Harpy Tail", permanentizeStatusEffect4, StatusEffects.UnlockedHarpyTail);
				else if (player.hasStatusEffect(StatusEffects.UnlockedHarpyTail) && player.statusEffectv4(StatusEffects.UnlockedHarpyTail) == 9000) addButtonDisabled(5, "Harpy Tail", "Harpy Tail option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(5, "Harpy Tail", "Harpy Tail");
				if (player.hasStatusEffect(StatusEffects.UnlockedHarpyArms) && player.statusEffectv4(StatusEffects.UnlockedHarpyArms) < 9000) addButton(6, "Harpy Arms", permanentizeStatusEffect4, StatusEffects.UnlockedHarpyArms);
				else if (player.hasStatusEffect(StatusEffects.UnlockedHarpyArms) && player.statusEffectv4(StatusEffects.UnlockedHarpyArms) == 9000) addButtonDisabled(6, "Harpy Arms", "Harpy Arms option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(6, "Harpy Arms", "Harpy Arms");
				if (player.hasStatusEffect(StatusEffects.UnlockedHarpyHair) && player.statusEffectv4(StatusEffects.UnlockedHarpyHair) < 9000) addButton(7, "Harpy Hair", permanentizeStatusEffect4, StatusEffects.UnlockedHarpyHair);
				else if (player.hasStatusEffect(StatusEffects.UnlockedHarpyHair) && player.statusEffectv4(StatusEffects.UnlockedHarpyHair) == 9000) addButtonDisabled(7, "Harpy Hair", "Harpy Hair option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(7, "Harpy Hair", "Harpy Hair");
				if (player.hasStatusEffect(StatusEffects.UnlockedHarpyWings) && player.statusEffectv4(StatusEffects.UnlockedHarpyWings) < 9000) addButton(8, "Harpy Wings", permanentizeStatusEffect4, StatusEffects.UnlockedHarpyWings);
				else if (player.hasStatusEffect(StatusEffects.UnlockedHarpyWings) && player.statusEffectv4(StatusEffects.UnlockedHarpyWings) == 9000) addButtonDisabled(8, "Harpy Wings", "Harpy Wings option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(8, "Harpy Wings", "Harpy Wings");
				addButton(9, "Previous", ascensionMetamorphPermeryMenu, page - 1);
				if (player.hasStatusEffect(StatusEffects.UnlockedElfinEars) && player.statusEffectv4(StatusEffects.UnlockedElfinEars) < 9000) addButton(10, "Elfin Ears", permanentizeStatusEffect4, StatusEffects.UnlockedElfinEars);
				else if (player.hasStatusEffect(StatusEffects.UnlockedElfinEars) && player.statusEffectv4(StatusEffects.UnlockedElfinEars) == 9000) addButtonDisabled(10, "Elfin Ears", "Elfin Ears option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(10, "Elfin Ears", "Elfin Ears");
				if (player.hasStatusEffect(StatusEffects.UnlockedSpiderFourEyes) && player.statusEffectv4(StatusEffects.UnlockedSpiderFourEyes) < 9000) addButton(11, "Spider Eyes", permanentizeStatusEffect4, StatusEffects.UnlockedSpiderFourEyes);
				else if (player.hasStatusEffect(StatusEffects.UnlockedSpiderFourEyes) && player.statusEffectv4(StatusEffects.UnlockedSpiderFourEyes) == 9000) addButtonDisabled(1, "Spider Eyes", "Spider Eyes option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(11, "Spider Eyes", "Spider Eyes");
				if (player.hasStatusEffect(StatusEffects.UnlockedSpiderFangs) && player.statusEffectv4(StatusEffects.UnlockedSpiderFangs) < 9000) addButton(12, "Spider Fangs", permanentizeStatusEffect4, StatusEffects.UnlockedSpiderFangs);
				else if (player.hasStatusEffect(StatusEffects.UnlockedSpiderFangs) && player.statusEffectv4(StatusEffects.UnlockedSpiderFangs) == 9000) addButtonDisabled(12, "Spider Fangs", "Spider Fangs option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(12, "Spider Fangs", "Spider Fangs");
				if (player.hasStatusEffect(StatusEffects.UnlockedSpiderArms) && player.statusEffectv4(StatusEffects.UnlockedSpiderArms) < 9000) addButton(13, "Spider Arms", permanentizeStatusEffect4, StatusEffects.UnlockedSpiderArms);
				else if (player.hasStatusEffect(StatusEffects.UnlockedSpiderArms) && player.statusEffectv4(StatusEffects.UnlockedSpiderArms) == 9000) addButtonDisabled(13, "Spider Arms", "Spider Arms option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(13, "Spider Arms", "Spider Arms");
			}
			if (page == 5) {
				if (player.hasStatusEffect(StatusEffects.UnlockedSpiderLegs) && player.statusEffectv4(StatusEffects.UnlockedSpiderLegs) < 9000) addButton(0, "Spider Legs", permanentizeStatusEffect5, StatusEffects.UnlockedSpiderLegs);
				else if (player.hasStatusEffect(StatusEffects.UnlockedSpiderLegs) && player.statusEffectv4(StatusEffects.UnlockedSpiderLegs) == 9000) addButtonDisabled(0, "Spider Legs", "Spider Legs option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(0, "Spider Legs", "Spider Legs");
				if (player.hasStatusEffect(StatusEffects.UnlockedSpiderTail) && player.statusEffectv4(StatusEffects.UnlockedSpiderTail) < 9000) addButton(1, "Spider Tail", permanentizeStatusEffect5, StatusEffects.UnlockedSpiderTail);
				else if (player.hasStatusEffect(StatusEffects.UnlockedSpiderTail) && player.statusEffectv4(StatusEffects.UnlockedSpiderTail) == 9000) addButtonDisabled(1, "Spider Tail", "Spider Tail option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(1, "Spider Tail", "Spider Tail");
				if (player.hasStatusEffect(StatusEffects.UnlockedDriderLegs) && player.statusEffectv4(StatusEffects.UnlockedDriderLegs) < 9000) addButton(2, "Drider Legs", permanentizeStatusEffect5, StatusEffects.UnlockedDriderLegs);
				else if (player.hasStatusEffect(StatusEffects.UnlockedDriderLegs) && player.statusEffectv4(StatusEffects.UnlockedDriderLegs) == 9000) addButtonDisabled(2, "Drider Legs", "Drider Legs option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(2, "Drider Legs", "Drider Legs");
				if (player.hasStatusEffect(StatusEffects.UnlockedSharkTeeth) && player.statusEffectv4(StatusEffects.UnlockedSharkTeeth) < 9000) addButton(3, "Shark Teeth", permanentizeStatusEffect5, StatusEffects.UnlockedSharkTeeth);
				else if (player.hasStatusEffect(StatusEffects.UnlockedSharkTeeth) && player.statusEffectv4(StatusEffects.UnlockedSharkTeeth) == 9000) addButtonDisabled(3, "Shark Teeth", "Shark Teeth option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(3, "Shark Teeth", "Shark Teeth");
				addButton(4, "Next", ascensionMetamorphPermeryMenu, page + 1);
				if (player.hasStatusEffect(StatusEffects.UnlockedSharkTail) && player.statusEffectv4(StatusEffects.UnlockedSharkTail) < 9000) addButton(5, "Shark Tail", permanentizeStatusEffect5, StatusEffects.UnlockedSharkTail);
				else if (player.hasStatusEffect(StatusEffects.UnlockedSharkTail) && player.statusEffectv4(StatusEffects.UnlockedSharkTail) == 9000) addButtonDisabled(5, "Shark Tail", "Shark Tail option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(5, "Shark Tail", "Shark Tail");
				if (player.hasStatusEffect(StatusEffects.UnlockedSharkLegs) && player.statusEffectv4(StatusEffects.UnlockedSharkLegs) < 9000) addButton(6, "Shark Legs", permanentizeStatusEffect5, StatusEffects.UnlockedSharkLegs);
				else if (player.hasStatusEffect(StatusEffects.UnlockedSharkLegs) && player.statusEffectv4(StatusEffects.UnlockedSharkLegs) == 9000) addButtonDisabled(6, "Shark Legs", "Shark Legs option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(6, "Shark Legs", "Shark Legs");
				if (player.hasStatusEffect(StatusEffects.UnlockedSharkArms) && player.statusEffectv4(StatusEffects.UnlockedSharkArms) < 9000) addButton(7, "Shark Arms", permanentizeStatusEffect5, StatusEffects.UnlockedSharkArms);
				else if (player.hasStatusEffect(StatusEffects.UnlockedSharkArms) && player.statusEffectv4(StatusEffects.UnlockedSharkArms) == 9000) addButtonDisabled(7, "Shark Arms", "Shark Arms option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(7, "Shark Arms", "Shark Arms");
				if (player.hasStatusEffect(StatusEffects.UnlockedSharkFin) && player.statusEffectv4(StatusEffects.UnlockedSharkFin) < 9000) addButton(8, "Shark Fin", permanentizeStatusEffect5, StatusEffects.UnlockedSharkFin);
				else if (player.hasStatusEffect(StatusEffects.UnlockedSharkFin) && player.statusEffectv4(StatusEffects.UnlockedSharkFin) == 9000) addButtonDisabled(8, "Shark Fin", "Shark Fin option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(8, "Shark Fin", "Shark Fin");
				addButton(9, "Previous", ascensionMetamorphPermeryMenu, page - 1);
				if (player.hasStatusEffect(StatusEffects.UnlockedDraconicX2) && player.statusEffectv4(StatusEffects.UnlockedDraconicX2) < 9000) addButton(10, "Dragon Horns", permanentizeStatusEffect5, StatusEffects.UnlockedDraconicX2);
				else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicX2) && player.statusEffectv4(StatusEffects.UnlockedDraconicX2) == 9000) addButtonDisabled(10, "Dragon Horns", "Draconic Horns option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(10, "Dragon Horns", "Draconic Horns");
				if (player.hasStatusEffect(StatusEffects.UnlockedDraconicX4) && player.statusEffectv4(StatusEffects.UnlockedDraconicX4) < 9000) addButton(11, "Dragon H.(2nd)", permanentizeStatusEffect5, StatusEffects.UnlockedDraconicX4);
				else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicX4) && player.statusEffectv4(StatusEffects.UnlockedDraconicX4) == 9000) addButtonDisabled(11, "Dragon H.(2nd)", "Draconic Horns (2nd pair) option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(11, "Dragon H.(2nd)", "Draconic Horns (2nd pair)");
				if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderTail) && player.statusEffectv4(StatusEffects.UnlockedSalamanderTail) < 9000) addButton(12, "Salaman. T.", permanentizeStatusEffect5, StatusEffects.UnlockedSalamanderTail);
				else if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderTail) && player.statusEffectv4(StatusEffects.UnlockedSalamanderTail) == 9000) addButtonDisabled(12, "Salaman. T.", "Salamander Tail option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(12, "Salaman. T.", "Salamander Tail");
				if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderLegs) && player.statusEffectv4(StatusEffects.UnlockedSalamanderLegs) < 9000) addButton(13, "Salaman. L.", permanentizeStatusEffect5, StatusEffects.UnlockedSalamanderLegs);
				else if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderLegs) && player.statusEffectv4(StatusEffects.UnlockedSalamanderLegs) == 9000) addButtonDisabled(13, "Salaman. L.", "Salamander Legs option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(13, "Salaman. L.", "Salamander Legs");
			}
			if (page == 6) {
				if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderArms) && player.statusEffectv4(StatusEffects.UnlockedSalamanderArms) < 9000) addButton(0, "Salaman. A.", permanentizeStatusEffect6, StatusEffects.UnlockedSalamanderArms);
				else if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderArms) && player.statusEffectv4(StatusEffects.UnlockedSalamanderArms) == 9000) addButtonDisabled(0, "Salaman. A.", "Salamander Arms option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(0, "Salaman. A.", "Salamander Arms");
				if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderFace) && player.statusEffectv4(StatusEffects.UnlockedSalamanderFace) < 9000) addButton(1, "Salaman. F.", permanentizeStatusEffect6, StatusEffects.UnlockedSalamanderFace);
				else if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderFace) && player.statusEffectv4(StatusEffects.UnlockedSalamanderFace) == 9000) addButtonDisabled(1, "Salaman. F.", "Salamander Face option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(1, "Salaman. F.", "Salamander Face");
				if (player.hasStatusEffect(StatusEffects.UnlockedPhoenixArms) && player.statusEffectv4(StatusEffects.UnlockedPhoenixArms) < 9000) addButton(2, "Phoenix A.", permanentizeStatusEffect6, StatusEffects.UnlockedPhoenixArms);
				else if (player.hasStatusEffect(StatusEffects.UnlockedPhoenixArms) && player.statusEffectv4(StatusEffects.UnlockedPhoenixArms) == 9000) addButtonDisabled(2, "Phoenix A.", "Phoenix Arms option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(2, "Phoenix A.", "Phoenix Arms");
				if (player.hasStatusEffect(StatusEffects.UnlockedPhoenixWings) && player.statusEffectv4(StatusEffects.UnlockedPhoenixWings) < 9000) addButton(3, "Phoenix W.", permanentizeStatusEffect6, StatusEffects.UnlockedPhoenixWings);
				else if (player.hasStatusEffect(StatusEffects.UnlockedPhoenixWings) && player.statusEffectv4(StatusEffects.UnlockedPhoenixWings) == 9000) addButtonDisabled(3, "Phoenix W.", "Phoenix Wings option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(3, "Phoenix W.", "Phoenix Wings");
				addButton(4, "Next", ascensionMetamorphPermeryMenu, page + 1);
				if (player.hasStatusEffect(StatusEffects.UnlockedOrcaLegs) && player.statusEffectv4(StatusEffects.UnlockedOrcaLegs) < 9000) addButton(5, "Orca Legs", permanentizeStatusEffect6, StatusEffects.UnlockedOrcaLegs);
				else if (player.hasStatusEffect(StatusEffects.UnlockedOrcaLegs) && player.statusEffectv4(StatusEffects.UnlockedOrcaLegs) == 9000) addButtonDisabled(5, "Orca Legs", "Orca Legs option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(5, "Orca Legs", "Orca Legs");
				if (player.hasStatusEffect(StatusEffects.UnlockedOrcaArms) && player.statusEffectv4(StatusEffects.UnlockedOrcaArms) < 9000) addButton(6, "Orca Arms", permanentizeStatusEffect6, StatusEffects.UnlockedOrcaArms);
				else if (player.hasStatusEffect(StatusEffects.UnlockedOrcaArms) && player.statusEffectv4(StatusEffects.UnlockedOrcaArms) == 9000) addButtonDisabled(6, "Orca Arms", "Orca Arms option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(6, "Orca Arms", "Orca Arms");
				if (player.hasStatusEffect(StatusEffects.UnlockedOrcaTail) && player.statusEffectv4(StatusEffects.UnlockedOrcaTail) < 9000) addButton(7, "Orca Tail", permanentizeStatusEffect6, StatusEffects.UnlockedOrcaTail);
				else if (player.hasStatusEffect(StatusEffects.UnlockedOrcaTail) && player.statusEffectv4(StatusEffects.UnlockedOrcaTail) == 9000) addButtonDisabled(7, "Orca Tail", "Orca Tail option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(7, "Orca Tail", "Orca Tail");
				if (player.hasStatusEffect(StatusEffects.UnlockedOrcaEars) && player.statusEffectv4(StatusEffects.UnlockedOrcaEars) < 9000) addButton(8, "Orca Ears", permanentizeStatusEffect6, StatusEffects.UnlockedOrcaEars);
				else if (player.hasStatusEffect(StatusEffects.UnlockedOrcaEars) && player.statusEffectv4(StatusEffects.UnlockedOrcaEars) == 9000) addButtonDisabled(8, "Orca Ears", "Orca Ears option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(8, "Orca Ears", "Orca Ears");
				addButton(9, "Previous", ascensionMetamorphPermeryMenu, page - 1);
				if (player.hasStatusEffect(StatusEffects.UnlockedOrcaFace) && player.statusEffectv4(StatusEffects.UnlockedOrcaFace) < 9000) addButton(10, "Orca Face", permanentizeStatusEffect6, StatusEffects.UnlockedOrcaFace);
				else if (player.hasStatusEffect(StatusEffects.UnlockedOrcaFace) && player.statusEffectv4(StatusEffects.UnlockedOrcaFace) == 9000) addButtonDisabled(10, "Orca Face", "Orca Face option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(10, "Orca Face", "Orca Face");
				if (player.hasStatusEffect(StatusEffects.UnlockedOrcaBlowhole) && player.statusEffectv4(StatusEffects.UnlockedOrcaBlowhole) < 9000) addButton(11, "Orca Blowhole", permanentizeStatusEffect6, StatusEffects.UnlockedOrcaBlowhole);
				else if (player.hasStatusEffect(StatusEffects.UnlockedOrcaBlowhole) && player.statusEffectv4(StatusEffects.UnlockedOrcaBlowhole) == 9000) addButtonDisabled(11, "Orca Blowhole", "Orca Blowhole option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(11, "Orca Blowhole", "Orca Blowhole");
				if (player.hasStatusEffect(StatusEffects.UnlockedSnakeTongue) && player.statusEffectv4(StatusEffects.UnlockedSnakeTongue) < 9000) addButton(12, "Snake Tongue", permanentizeStatusEffect6, StatusEffects.UnlockedSnakeTongue);
				else if (player.hasStatusEffect(StatusEffects.UnlockedSnakeTongue) && player.statusEffectv4(StatusEffects.UnlockedSnakeTongue) == 9000) addButtonDisabled(12, "Snake Tongue", "Snake Tongue option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(12, "Snake Tongue", "Snake Tongue");
				if (player.hasStatusEffect(StatusEffects.UnlockedSnakeFangs) && player.statusEffectv4(StatusEffects.UnlockedSnakeFangs) < 9000) addButton(13, "Snake Fangs", permanentizeStatusEffect6, StatusEffects.UnlockedSnakeFangs);
				else if (player.hasStatusEffect(StatusEffects.UnlockedSnakeFangs) && player.statusEffectv4(StatusEffects.UnlockedSnakeFangs) == 9000) addButtonDisabled(13, "Snake Fangs", "Snake Fangs option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(13, "Snake Fangs", "Snake Fangs");
			}
			if (page == 7) {
				if (player.hasStatusEffect(StatusEffects.UnlockedSnakeLowerBody) && player.statusEffectv4(StatusEffects.UnlockedSnakeLowerBody) < 9000) addButton(0, "Snake L.Body", permanentizeStatusEffect7, StatusEffects.UnlockedSnakeLowerBody);
				else if (player.hasStatusEffect(StatusEffects.UnlockedSnakeLowerBody) && player.statusEffectv4(StatusEffects.UnlockedSnakeLowerBody) == 9000) addButtonDisabled(0, "Snake L.Body", "Snake Lower Body option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(0, "Snake L.Body", "Snake Lower Body");
				if (player.hasStatusEffect(StatusEffects.UnlockedSnakeEyes) && player.statusEffectv4(StatusEffects.UnlockedSnakeEyes) < 9000) addButton(1, "Snake Eyes", permanentizeStatusEffect7, StatusEffects.UnlockedSnakeEyes);
				else if (player.hasStatusEffect(StatusEffects.UnlockedSnakeEyes) && player.statusEffectv4(StatusEffects.UnlockedSnakeEyes) == 9000) addButtonDisabled(1, "Snake Eyes", "Snake Eyes option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(1, "Snake Eyes", "Snake Eyes");
				if (player.hasStatusEffect(StatusEffects.UnlockedSnakeEars) && player.statusEffectv4(StatusEffects.UnlockedSnakeEars) < 9000) addButton(2, "Snake Ears", permanentizeStatusEffect7, StatusEffects.UnlockedSnakeEars);
				else if (player.hasStatusEffect(StatusEffects.UnlockedSnakeEars) && player.statusEffectv4(StatusEffects.UnlockedSnakeEars) == 9000) addButtonDisabled(2, "Snake Ears", "Snake Ears option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(2, "Snake Ears", "Snake Ears");
				if (player.hasStatusEffect(StatusEffects.UnlockedGorgonHair) && player.statusEffectv4(StatusEffects.UnlockedGorgonHair) < 9000) addButton(3, "Gorgon Hair", permanentizeStatusEffect7, StatusEffects.UnlockedGorgonHair);
				else if (player.hasStatusEffect(StatusEffects.UnlockedGorgonHair) && player.statusEffectv4(StatusEffects.UnlockedGorgonHair) == 9000) addButtonDisabled(3, "Gorgon Hair", "Gorgon Hair option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(3, "Gorgon Hair", "Gorgon Hair");
				addButton(4, "Next", ascensionMetamorphPermeryMenu, page + 1);
				if (player.hasStatusEffect(StatusEffects.UnlockedGorgonEyes) && player.statusEffectv4(StatusEffects.UnlockedGorgonEyes) < 9000) addButton(5, "Gorgon Eyes", permanentizeStatusEffect7, StatusEffects.UnlockedGorgonEyes);
				else if (player.hasStatusEffect(StatusEffects.UnlockedGorgonEyes) && player.statusEffectv4(StatusEffects.UnlockedGorgonEyes) == 9000) addButtonDisabled(5, "Gorgon Eyes", "Gorgon Eyes option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(5, "Gorgon Eyes", "Gorgon Eyes");
				if (player.hasStatusEffect(StatusEffects.UnlockedDraconicEars) && player.statusEffectv4(StatusEffects.UnlockedDraconicEars) < 9000) addButton(6, "Dragon Ears", permanentizeStatusEffect7, StatusEffects.UnlockedDraconicEars);
				else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicEars) && player.statusEffectv4(StatusEffects.UnlockedDraconicEars) == 9000) addButtonDisabled(6, "Dragon Ears", "Draconic Ears option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(6, "Dragon Ears", "Draconic Ears");
				if (player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsSmall) && player.statusEffectv4(StatusEffects.UnlockedDraconicWingsSmall) < 9000) addButton(7, "Dragon W. S.", permanentizeStatusEffect7, StatusEffects.UnlockedDraconicWingsSmall);
				else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsSmall) && player.statusEffectv4(StatusEffects.UnlockedDraconicWingsSmall) == 9000) addButtonDisabled(7, "Dragon W. S.", "Draconic Wings Small option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(7, "Dragon W. S.", "Draconic Wings Small");
				if (player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsLarge) && player.statusEffectv4(StatusEffects.UnlockedDraconicWingsLarge) < 9000) addButton(8, "Dragon W. L.", permanentizeStatusEffect7, StatusEffects.UnlockedDraconicWingsLarge);
				else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsLarge) && player.statusEffectv4(StatusEffects.UnlockedDraconicWingsLarge) == 9000) addButtonDisabled(8, "Dragon W. L.", "Draconic Wings Large option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(8, "Dragon W. L.", "Draconic Wings Large");
				addButton(9, "Previous", ascensionMetamorphPermeryMenu, page - 1);
				if (player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsHuge) && player.statusEffectv4(StatusEffects.UnlockedDraconicWingsHuge) < 9000) addButton(10, "Dragon Wings H.", permanentizeStatusEffect7, StatusEffects.UnlockedDraconicWingsHuge);
				else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsHuge) && player.statusEffectv4(StatusEffects.UnlockedDraconicWingsHuge) == 9000) addButtonDisabled(10, "Dragon W. H.", "Draconic Wings Huge option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(10, "Dragon W. H.", "Draconic Wings Huge");
				if (player.hasStatusEffect(StatusEffects.UnlockedDraconicEyes) && player.statusEffectv4(StatusEffects.UnlockedDraconicEyes) < 9000) addButton(11, "Dragon Eyes", permanentizeStatusEffect7, StatusEffects.UnlockedDraconicEyes);
				else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicEyes) && player.statusEffectv4(StatusEffects.UnlockedDraconicEyes) == 9000) addButtonDisabled(11, "Dragon Eyes", "Draconic Eyes option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(11, "Dragon Eyes", "Draconic Eyes");
				if (player.hasStatusEffect(StatusEffects.UnlockedDraconicTongue) && player.statusEffectv4(StatusEffects.UnlockedDraconicTongue) < 9000) addButton(12, "Dragon Tongue", permanentizeStatusEffect7, StatusEffects.UnlockedDraconicTongue);
				else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicTongue) && player.statusEffectv4(StatusEffects.UnlockedDraconicTongue) == 9000) addButtonDisabled(12, "Dragon Tongue", "Draconic Tongue option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(12, "Dragon Tongue", "Draconic Tongue");
				if (player.hasStatusEffect(StatusEffects.UnlockedDraconicFace) && player.statusEffectv4(StatusEffects.UnlockedDraconicFace) < 9000) addButton(13, "Dragon Face", permanentizeStatusEffect7, StatusEffects.UnlockedDraconicFace);
				else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicFace) && player.statusEffectv4(StatusEffects.UnlockedDraconicFace) == 9000) addButtonDisabled(13, "Dragon Face", "Draconic Face option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(13, "Dragon Face", "Draconic Face");
			}
			if (page == 8) {
				if (player.hasStatusEffect(StatusEffects.UnlockedDraconicFangs) && player.statusEffectv4(StatusEffects.UnlockedDraconicFangs) < 9000) addButton(0, "Dragon Fangs", permanentizeStatusEffect8, StatusEffects.UnlockedDraconicFangs);
				else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicFangs) && player.statusEffectv4(StatusEffects.UnlockedDraconicFangs) == 9000) addButtonDisabled(0, "Dragon Fangs", "Draconic Fangs option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(0, "Dragon Fangs", "Draconic Fangs");
				if (player.hasStatusEffect(StatusEffects.UnlockedDraconicLegs) && player.statusEffectv4(StatusEffects.UnlockedDraconicLegs) < 9000) addButton(1, "Dragon Legs", permanentizeStatusEffect8, StatusEffects.UnlockedDraconicLegs);
				else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicLegs) && player.statusEffectv4(StatusEffects.UnlockedDraconicLegs) == 9000) addButtonDisabled(1, "Dragon Legs", "Draconic Legs option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(1, "Dragon Legs", "Draconic Legs");
				if (player.hasStatusEffect(StatusEffects.UnlockedDraconicArms) && player.statusEffectv4(StatusEffects.UnlockedDraconicArms) < 9000) addButton(2, "Dragon Arms", permanentizeStatusEffect8, StatusEffects.UnlockedDraconicArms);
				else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicArms) && player.statusEffectv4(StatusEffects.UnlockedDraconicArms) == 9000) addButtonDisabled(2, "Dragon Arms", "Draconic Arms option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(2, "Dragon Arms", "Draconic Arms");
				if (player.hasStatusEffect(StatusEffects.UnlockedDraconicTail) && player.statusEffectv4(StatusEffects.UnlockedDraconicTail) < 9000) addButton(3, "Dragon Tail", permanentizeStatusEffect8, StatusEffects.UnlockedDraconicTail);
				else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicTail) && player.statusEffectv4(StatusEffects.UnlockedDraconicTail) == 9000) addButtonDisabled(3, "Dragon Tail", "Draconic Tail option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(3, "Dragon Tail", "Draconic Tail");
				addButton(4, "Next", ascensionMetamorphPermeryMenu, page + 1);
				if (player.hasStatusEffect(StatusEffects.UnlockedHoofedLegs) && player.statusEffectv4(StatusEffects.UnlockedHoofedLegs) < 9000) addButton(5, "Hoofed Legs", permanentizeStatusEffect8, StatusEffects.UnlockedHoofedLegs);
				else if (player.hasStatusEffect(StatusEffects.UnlockedHoofedLegs) && player.statusEffectv4(StatusEffects.UnlockedHoofedLegs) == 9000) addButtonDisabled(5, "Hoofed Legs", "Hoofed Legs option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(5, "Hoofed Legs", "Hoofed Legs");
				if (player.hasStatusEffect(StatusEffects.UnlockedCowTail) && player.statusEffectv4(StatusEffects.UnlockedCowTail) < 9000) addButton(6, "Cow Tail", permanentizeStatusEffect8, StatusEffects.UnlockedCowTail);
				else if (player.hasStatusEffect(StatusEffects.UnlockedCowTail) && player.statusEffectv4(StatusEffects.UnlockedCowTail) == 9000) addButtonDisabled(6, "Cow Tail", "Cow Tail option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(6, "Cow Tail", "Cow Tail");
				if (player.hasStatusEffect(StatusEffects.UnlockedCowEars) && player.statusEffectv4(StatusEffects.UnlockedCowEars) < 9000) addButton(7, "Cow Ears", permanentizeStatusEffect8, StatusEffects.UnlockedCowEars);
				else if (player.hasStatusEffect(StatusEffects.UnlockedCowEars) && player.statusEffectv4(StatusEffects.UnlockedCowEars) == 9000) addButtonDisabled(7, "Cow Ears", "Cow Ears option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(7, "Cow Ears", "Cow Ears");
				if (player.hasStatusEffect(StatusEffects.UnlockedCowMinotaurFace) && player.statusEffectv4(StatusEffects.UnlockedCowMinotaurFace) < 9000) addButton(8, "Bovine Face", permanentizeStatusEffect8, StatusEffects.UnlockedCowMinotaurFace);
				else if (player.hasStatusEffect(StatusEffects.UnlockedCowMinotaurFace) && player.statusEffectv4(StatusEffects.UnlockedCowMinotaurFace) == 9000) addButtonDisabled(8, "Bovine Face", "Cow/Minotaur Face option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(8, "Bovine Face", "Cow/Minotaur Face");
				addButton(9, "Previous", ascensionMetamorphPermeryMenu, page - 1);
				if (player.hasStatusEffect(StatusEffects.UnlockedCowMinotaurHorns) && player.statusEffectv4(StatusEffects.UnlockedCowMinotaurHorns) < 9000) addButton(10, "Bovine Horns", permanentizeStatusEffect8, StatusEffects.UnlockedCowMinotaurHorns);
				else if (player.hasStatusEffect(StatusEffects.UnlockedCowMinotaurHorns) && player.statusEffectv4(StatusEffects.UnlockedCowMinotaurHorns) == 9000) addButtonDisabled(10, "Bovine Horns", "Cow/Minotaur Horns option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(10, "Bovine Horns", "Cow/Minotaur Horns");
				if (player.hasStatusEffect(StatusEffects.UnlockedClovenHoofedLegs) && player.statusEffectv4(StatusEffects.UnlockedClovenHoofedLegs) < 9000) addButton(11, "C. Hoofed Legs", permanentizeStatusEffect8, StatusEffects.UnlockedClovenHoofedLegs);
				else if (player.hasStatusEffect(StatusEffects.UnlockedClovenHoofedLegs) && player.statusEffectv4(StatusEffects.UnlockedClovenHoofedLegs) == 9000) addButtonDisabled(11, "C. Hoofed Legs", "Cloven Hoofed Legs option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(11, "C. Hoofed Legs", "Cloven Hoofed Legs");
				if (player.hasStatusEffect(StatusEffects.UnlockedGoatTail) && player.statusEffectv4(StatusEffects.UnlockedGoatTail) < 9000) addButton(12, "Goat Tail", permanentizeStatusEffect8, StatusEffects.UnlockedGoatTail);
				else if (player.hasStatusEffect(StatusEffects.UnlockedGoatTail) && player.statusEffectv4(StatusEffects.UnlockedGoatTail) == 9000) addButtonDisabled(12, "Goat Tail", "Goat Tail option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(12, "Goat Tail", "Goat Tail");
				if (player.hasStatusEffect(StatusEffects.UnlockedGoatHorns) && player.statusEffectv4(StatusEffects.UnlockedGoatHorns) < 9000) addButton(13, "Goat Horns", permanentizeStatusEffect8, StatusEffects.UnlockedGoatHorns);
				else if (player.hasStatusEffect(StatusEffects.UnlockedGoatHorns) && player.statusEffectv4(StatusEffects.UnlockedGoatHorns) == 9000) addButtonDisabled(13, "Goat Horns", "Goat Horns option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(13, "Goat Horns", "Goat Horns");
			}
			if (page == 9) {
				if (player.hasStatusEffect(StatusEffects.UnlockedGoatEars) && player.statusEffectv4(StatusEffects.UnlockedGoatEars) < 9000) addButton(0, "Goat Ears", permanentizeStatusEffect9, StatusEffects.UnlockedGoatEars);
				else if (player.hasStatusEffect(StatusEffects.UnlockedGoatEars) && player.statusEffectv4(StatusEffects.UnlockedGoatEars) == 9000) addButtonDisabled(0, "Goat Ears", "Goat Ears option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(0, "Goat Ears", "Goat Ears");
				if (player.hasStatusEffect(StatusEffects.UnlockedDevilArms) && player.statusEffectv4(StatusEffects.UnlockedDevilArms) < 9000) addButton(1, "Devil Arms", permanentizeStatusEffect9, StatusEffects.UnlockedDevilArms);
				else if (player.hasStatusEffect(StatusEffects.UnlockedDevilArms) && player.statusEffectv4(StatusEffects.UnlockedDevilArms) == 9000) addButtonDisabled(1, "Devil Arms", "Devil Arms option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(1, "Devil Arms", "Devil Arms");
				if (player.hasStatusEffect(StatusEffects.UnlockedDevilFangs) && player.statusEffectv4(StatusEffects.UnlockedDevilFangs) < 9000) addButton(2, "Devil Fangs", permanentizeStatusEffect9, StatusEffects.UnlockedDevilFangs);
				else if (player.hasStatusEffect(StatusEffects.UnlockedDevilFangs) && player.statusEffectv4(StatusEffects.UnlockedDevilFangs) == 9000) addButtonDisabled(2, "Devil Fangs", "Devil Fangs option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(2, "Devil Fangs", "Devil Fangs");
				if (player.hasStatusEffect(StatusEffects.UnlockedDevilEyes) && player.statusEffectv4(StatusEffects.UnlockedDevilEyes) < 9000) addButton(3, "Devil Eyes", permanentizeStatusEffect9, StatusEffects.UnlockedDevilEyes);
				else if (player.hasStatusEffect(StatusEffects.UnlockedDevilEyes) && player.statusEffectv4(StatusEffects.UnlockedDevilEyes) == 9000) addButtonDisabled(3, "Devil Eyes", "Devil Eyes option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(3, "Devil Eyes", "Devil Eyes");
				addButton(4, "Next", ascensionMetamorphPermeryMenu, page + 1);
				if (player.hasStatusEffect(StatusEffects.UnlockedMantisAntennae) && player.statusEffectv4(StatusEffects.UnlockedMantisAntennae) < 9000) addButton(5, "Mantis A.", permanentizeStatusEffect9, StatusEffects.UnlockedMantisAntennae);
				else if (player.hasStatusEffect(StatusEffects.UnlockedMantisAntennae) && player.statusEffectv4(StatusEffects.UnlockedMantisAntennae) == 9000) addButtonDisabled(5, "Mantis A.", "Mantis Antennae option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(5, "Mantis A.", "Mantis Antennae");
				if (player.hasStatusEffect(StatusEffects.UnlockedMantisLegs) && player.statusEffectv4(StatusEffects.UnlockedMantisLegs) < 9000) addButton(6, "Mantis Legs", permanentizeStatusEffect9, StatusEffects.UnlockedMantisLegs);
				else if (player.hasStatusEffect(StatusEffects.UnlockedMantisLegs) && player.statusEffectv4(StatusEffects.UnlockedMantisLegs) == 9000) addButtonDisabled(6, "Mantis Legs", "Mantis Legs option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(6, "Mantis Legs", "Mantis Legs");
				if (player.hasStatusEffect(StatusEffects.UnlockedMantisArms) && player.statusEffectv4(StatusEffects.UnlockedMantisArms) < 9000) addButton(7, "Mantis Arms", permanentizeStatusEffect9, StatusEffects.UnlockedMantisArms);
				else if (player.hasStatusEffect(StatusEffects.UnlockedMantisArms) && player.statusEffectv4(StatusEffects.UnlockedMantisArms) == 9000) addButtonDisabled(7, "Mantis Arms", "Mantis Arms option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(7, "Mantis Arms", "Mantis Arms");
				if (player.hasStatusEffect(StatusEffects.UnlockedMantisTail) && player.statusEffectv4(StatusEffects.UnlockedMantisTail) < 9000) addButton(8, "Mantis Tail", permanentizeStatusEffect9, StatusEffects.UnlockedMantisTail);
				else if (player.hasStatusEffect(StatusEffects.UnlockedMantisTail) && player.statusEffectv4(StatusEffects.UnlockedMantisTail) == 9000) addButtonDisabled(8, "Mantis Tail", "Mantis Tail option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(8, "Mantis Tail", "Mantis Tail");
				addButton(9, "Previous", ascensionMetamorphPermeryMenu, page - 1);
				if (player.hasStatusEffect(StatusEffects.UnlockedMantisWingsSmall) && player.statusEffectv4(StatusEffects.UnlockedMantisWingsSmall) < 9000) addButton(10, "Mantis W. S.", permanentizeStatusEffect9, StatusEffects.UnlockedMantisWingsSmall);
				else if (player.hasStatusEffect(StatusEffects.UnlockedMantisWingsSmall) && player.statusEffectv4(StatusEffects.UnlockedMantisWingsSmall) == 9000) addButtonDisabled(10, "Mantis W. S.", "Mantis Wings Small option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(10, "Mantis W. S.", "Mantis Wings Small");
				if (player.hasStatusEffect(StatusEffects.UnlockedMantisWingsLarge) && player.statusEffectv4(StatusEffects.UnlockedMantisWingsLarge) < 9000) addButton(11, "Mantis W. L.", permanentizeStatusEffect9, StatusEffects.UnlockedMantisWingsLarge);
				else if (player.hasStatusEffect(StatusEffects.UnlockedMantisWingsLarge) && player.statusEffectv4(StatusEffects.UnlockedMantisWingsLarge) == 9000) addButtonDisabled(11, "Mantis W. L.", "Mantis Wings Large option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(11, "Mantis W. L.", "Mantis Wings Large");
				if (player.hasStatusEffect(StatusEffects.UnlockedElfLegs) && player.statusEffectv4(StatusEffects.UnlockedElfLegs) < 9000) addButton(12, "Elf Legs", permanentizeStatusEffect9, StatusEffects.UnlockedElfLegs);
				else if (player.hasStatusEffect(StatusEffects.UnlockedElfLegs) && player.statusEffectv4(StatusEffects.UnlockedElfLegs) == 9000) addButtonDisabled(12, "Elf Legs", "Elf Legs option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(12, "Elf Legs", "Elf Legs");
				if (player.hasStatusEffect(StatusEffects.UnlockedElfArms) && player.statusEffectv4(StatusEffects.UnlockedElfArms) < 9000) addButton(13, "Elf Arms", permanentizeStatusEffect9, StatusEffects.UnlockedElfArms);
				else if (player.hasStatusEffect(StatusEffects.UnlockedElfArms) && player.statusEffectv4(StatusEffects.UnlockedElfArms) == 9000) addButtonDisabled(13, "Elf Arms", "Elf Arms option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(13, "Elf Arms", "Elf Arms");
			}
			if (page == 10) {
				if (player.hasStatusEffect(StatusEffects.UnlockedElfEars) && player.statusEffectv4(StatusEffects.UnlockedElfEars) < 9000) addButton(0, "Elf Ears", permanentizeStatusEffect10, StatusEffects.UnlockedElfEars);
				else if (player.hasStatusEffect(StatusEffects.UnlockedElfEars) && player.statusEffectv4(StatusEffects.UnlockedElfEars) == 9000) addButtonDisabled(0, "Elf Ears", "Elf Ears option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(0, "Elf Ears", "Elf Ears");
				if (player.hasStatusEffect(StatusEffects.UnlockedElfEyes) && player.statusEffectv4(StatusEffects.UnlockedElfEyes) < 9000) addButton(1, "Elf Eyes", permanentizeStatusEffect10, StatusEffects.UnlockedElfEyes);
				else if (player.hasStatusEffect(StatusEffects.UnlockedElfEyes) && player.statusEffectv4(StatusEffects.UnlockedElfEyes) == 9000) addButtonDisabled(1, "Elf Eyes", "Elf Eyes option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(1, "Elf Eyes", "Elf Eyes");
				if (player.hasStatusEffect(StatusEffects.UnlockedElfHair) && player.statusEffectv4(StatusEffects.UnlockedElfHair) < 9000) addButton(2, "Elf Hair", permanentizeStatusEffect10, StatusEffects.UnlockedElfHair);
				else if (player.hasStatusEffect(StatusEffects.UnlockedElfHair) && player.statusEffectv4(StatusEffects.UnlockedElfHair) == 9000) addButtonDisabled(2, "Elf Hair", "Elf Hair option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(2, "Elf Hair", "Elf Hair");
				if (player.hasStatusEffect(StatusEffects.UnlockedElfTongue) && player.statusEffectv4(StatusEffects.UnlockedElfTongue) < 9000) addButton(3, "Elf Tongue", permanentizeStatusEffect10, StatusEffects.UnlockedElfTongue);
				else if (player.hasStatusEffect(StatusEffects.UnlockedElfTongue) && player.statusEffectv4(StatusEffects.UnlockedElfTongue) == 9000) addButtonDisabled(3, "Elf Tongue", "Elf Tongue option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(3, "Elf Tongue", "Elf Tongue");
				addButton(4, "Next", ascensionMetamorphPermeryMenu, page + 1);
				if (player.hasStatusEffect(StatusEffects.UnlockedOniLegs) && player.statusEffectv4(StatusEffects.UnlockedOniLegs) < 9000) addButton(5, "Oni Legs", permanentizeStatusEffect10, StatusEffects.UnlockedOniLegs);
				else if (player.hasStatusEffect(StatusEffects.UnlockedOniLegs) && player.statusEffectv4(StatusEffects.UnlockedOniLegs) == 9000) addButtonDisabled(5, "Oni Legs", "Oni Legs option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(5, "Oni Legs", "Oni Legs");
				if (player.hasStatusEffect(StatusEffects.UnlockedOniArms) && player.statusEffectv4(StatusEffects.UnlockedOniArms) < 9000) addButton(6, "Oni Arms", permanentizeStatusEffect10, StatusEffects.UnlockedOniArms);
				else if (player.hasStatusEffect(StatusEffects.UnlockedOniArms) && player.statusEffectv4(StatusEffects.UnlockedOniArms) == 9000) addButtonDisabled(6, "Oni Arms", "Oni Arms option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(6, "Oni Arms", "Oni Arms");
				if (player.hasStatusEffect(StatusEffects.UnlockedOniEyes) && player.statusEffectv4(StatusEffects.UnlockedOniEyes) < 9000) addButton(7, "Oni Eyes", permanentizeStatusEffect10, StatusEffects.UnlockedOniEyes);
				else if (player.hasStatusEffect(StatusEffects.UnlockedOniEyes) && player.statusEffectv4(StatusEffects.UnlockedOniEyes) == 9000) addButtonDisabled(7, "Oni Eyes", "Oni Eyes option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(7, "Oni Eyes", "Oni Eyes");
				if (player.hasStatusEffect(StatusEffects.UnlockedOniEars) && player.statusEffectv4(StatusEffects.UnlockedOniEars) < 9000) addButton(8, "Oni Ears", permanentizeStatusEffect10, StatusEffects.UnlockedOniEars);
				else if (player.hasStatusEffect(StatusEffects.UnlockedOniEars) && player.statusEffectv4(StatusEffects.UnlockedOniEars) == 9000) addButtonDisabled(8, "Oni Ears", "Oni Ears option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(8, "Oni Ears", "Oni Ears");
				addButton(9, "Previous", ascensionMetamorphPermeryMenu, page - 1);
				if (player.hasStatusEffect(StatusEffects.UnlockedOniFace) && player.statusEffectv4(StatusEffects.UnlockedOniFace) < 9000) addButton(10, "Oni Face", permanentizeStatusEffect10, StatusEffects.UnlockedOniFace);
				else if (player.hasStatusEffect(StatusEffects.UnlockedOniFace) && player.statusEffectv4(StatusEffects.UnlockedOniFace) == 9000) addButtonDisabled(10, "Oni Face", "Oni Face option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(10, "Oni Face", "Oni Face");
				if (player.hasStatusEffect(StatusEffects.UnlockedOniSingleHorn) && player.statusEffectv4(StatusEffects.UnlockedOniSingleHorn) < 9000) addButton(11, "Oni S. Horn", permanentizeStatusEffect10, StatusEffects.UnlockedOniSingleHorn);
				else if (player.hasStatusEffect(StatusEffects.UnlockedOniSingleHorn) && player.statusEffectv4(StatusEffects.UnlockedOniSingleHorn) == 9000) addButtonDisabled(11, "Oni S. Horn", "Oni Single Horn option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(11, "Oni S. Horn", "Oni Single Horn");
				if (player.hasStatusEffect(StatusEffects.UnlockedOniTwinHorns) && player.statusEffectv4(StatusEffects.UnlockedOniTwinHorns) < 9000) addButton(12, "Oni T. Horns", permanentizeStatusEffect10, StatusEffects.UnlockedOniTwinHorns);
				else if (player.hasStatusEffect(StatusEffects.UnlockedOniTwinHorns) && player.statusEffectv4(StatusEffects.UnlockedOniTwinHorns) == 9000) addButtonDisabled(12, "Oni T. Horns", "Oni Twin Horns option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(12, "Oni T. Horns", "Oni Twin Horns");
				if (player.hasStatusEffect(StatusEffects.UnlockedRaijuLegs) && player.statusEffectv4(StatusEffects.UnlockedRaijuLegs) < 9000) addButton(13, "Raiju Legs", permanentizeStatusEffect10, StatusEffects.UnlockedRaijuLegs);
				else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuLegs) && player.statusEffectv4(StatusEffects.UnlockedRaijuLegs) == 9000) addButtonDisabled(13, "Raiju Legs", "Raiju Legs option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(13, "Raiju Legs", "Raiju Legs");
			}
			if (page == 11) {
				if (player.hasStatusEffect(StatusEffects.UnlockedRaijuArms) && player.statusEffectv4(StatusEffects.UnlockedRaijuArms) < 9000) addButton(0, "Raiju Arms", permanentizeStatusEffect11, StatusEffects.UnlockedRaijuArms);
				else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuArms) && player.statusEffectv4(StatusEffects.UnlockedRaijuArms) == 9000) addButtonDisabled(0, "Raiju Arms", "Raiju Arms option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(0, "Raiju Arms", "Raiju Arms");
				if (player.hasStatusEffect(StatusEffects.UnlockedRaijuTail) && player.statusEffectv4(StatusEffects.UnlockedRaijuTail) < 9000) addButton(1, "Raiju Tail", permanentizeStatusEffect11, StatusEffects.UnlockedRaijuTail);
				else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuTail) && player.statusEffectv4(StatusEffects.UnlockedRaijuTail) == 9000) addButtonDisabled(1, "Raiju Tail", "Raiju Tail option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(1, "Raiju Tail", "Raiju Tail");
				if (player.hasStatusEffect(StatusEffects.UnlockedRaijuMane) && player.statusEffectv4(StatusEffects.UnlockedRaijuMane) < 9000) addButton(2, "Raiju Mane", permanentizeStatusEffect11, StatusEffects.UnlockedRaijuMane);
				else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuMane) && player.statusEffectv4(StatusEffects.UnlockedRaijuMane) == 9000) addButtonDisabled(2, "Raiju Mane", "Raiju Mane option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(2, "Raiju Mane", "Raiju Mane");
				if (player.hasStatusEffect(StatusEffects.UnlockedRaijuFace) && player.statusEffectv4(StatusEffects.UnlockedRaijuFace) < 9000) addButton(3, "Raiju Face", permanentizeStatusEffect11, StatusEffects.UnlockedRaijuFace);
				else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuFace) && player.statusEffectv4(StatusEffects.UnlockedRaijuFace) == 9000) addButtonDisabled(3, "Raiju Face", "Raiju Face option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(3, "Raiju Face", "Raiju Face");
				//addButton(4, "Next", ascensionMetamorphPermeryMenu, page + 1);
				if (player.hasStatusEffect(StatusEffects.UnlockedRaijuEars) && player.statusEffectv4(StatusEffects.UnlockedRaijuEars) < 9000) addButton(5, "Raiju Ears", permanentizeStatusEffect11, StatusEffects.UnlockedRaijuEars);
				else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuEars) && player.statusEffectv4(StatusEffects.UnlockedRaijuEars) == 9000) addButtonDisabled(5, "Raiju Ears", "Raiju Ears option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(5, "Raiju Ears", "Raiju Ears");
				if (player.hasStatusEffect(StatusEffects.UnlockedRaijuEyes) && player.statusEffectv4(StatusEffects.UnlockedRaijuEyes) < 9000) addButton(6, "Raiju Eyes", permanentizeStatusEffect11, StatusEffects.UnlockedRaijuEyes);
				else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuEyes) && player.statusEffectv4(StatusEffects.UnlockedRaijuEyes) == 9000) addButtonDisabled(6, "Raiju Eyes", "Raiju Eyes option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(6, "Raiju Eyes", "Raiju Eyes");
				if (player.hasStatusEffect(StatusEffects.UnlockedRaijuHair) && player.statusEffectv4(StatusEffects.UnlockedRaijuHair) < 9000) addButton(7, "Raiju Hair", permanentizeStatusEffect11, StatusEffects.UnlockedRaijuHair);
				else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuHair) && player.statusEffectv4(StatusEffects.UnlockedRaijuHair) == 9000) addButtonDisabled(7, "Raiju Hair", "Raiju Hair option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(7, "Raiju Hair", "Raiju Hair");
				/*if (player.hasStatusEffect(StatusEffects.) && player.statusEffectv4(StatusEffects.) < 9000) addButton(8, "", permanentizeStatusEffect11, StatusEffects.);
				else if (player.hasStatusEffect(StatusEffects.) && player.statusEffectv4(StatusEffects.) == 9000) addButtonDisabled(8, "", " option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(8, "", "");*/
				addButton(9, "Previous", ascensionMetamorphPermeryMenu, page - 1);
				/*if (player.hasStatusEffect(StatusEffects.) && player.statusEffectv4(StatusEffects.) < 9000) addButton(10, "", permanentizeStatusEffect11, StatusEffects.);
				else if (player.hasStatusEffect(StatusEffects.) && player.statusEffectv4(StatusEffects.) == 9000) addButtonDisabled(10, "", " option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(10, "", "");*/
			}
			if (page == 12) {
				/*if (player.hasStatusEffect(StatusEffects.) && player.statusEffectv4(StatusEffects.) < 9000) addButton(0, "", permanentizeStatusEffect12, StatusEffects.);
				else if (player.hasStatusEffect(StatusEffects.) && player.statusEffectv4(StatusEffects.) == 9000) addButtonDisabled(0, "", " option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(0, "", "");*/
				//addButton(4, "Next", ascensionMetamorphPermeryMenu, page + 1);
				/*if (player.hasStatusEffect(StatusEffects.) && player.statusEffectv4(StatusEffects.) < 9000) addButton(5, "", permanentizeStatusEffect12, StatusEffects.);
				else if (player.hasStatusEffect(StatusEffects.) && player.statusEffectv4(StatusEffects.) == 9000) addButtonDisabled(5, "", " option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(5, "", "");*/
				addButton(9, "Previous", ascensionMetamorphPermeryMenu, page - 1);
				/*if (player.hasStatusEffect(StatusEffects.) && player.statusEffectv4(StatusEffects.) < 9000) addButton(10, "", permanentizeStatusEffect12, StatusEffects.);
				else if (player.hasStatusEffect(StatusEffects.) && player.statusEffectv4(StatusEffects.) == 9000) addButtonDisabled(10, "", " option is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(10, "", "");*/
			}
			addButton(14, "Back", ascensionMenu);
		}

		private function permanentizeStatusEffect1(statusEffect:StatusEffectType):void {
			if (player.statusEffectv2(StatusEffects.TranscendentalGeneticMemory) >= player.statusEffectv1(StatusEffects.TranscendentalGeneticMemory)) return;
			if (player.ascensionPerkPoints < 5) return;
			player.ascensionPerkPoints -= 5;
			player.addStatusValue(statusEffect, 4, 9000);
			player.addStatusValue(StatusEffects.TranscendentalGeneticMemory, 2, 1);
			ascensionMetamorphPermeryMenu(1);
		}
		private function permanentizeStatusEffect2(statusEffect:StatusEffectType):void {
			if (player.statusEffectv2(StatusEffects.TranscendentalGeneticMemory) >= player.statusEffectv1(StatusEffects.TranscendentalGeneticMemory)) return;
			if (player.ascensionPerkPoints < 5) return;
			player.ascensionPerkPoints -= 5;
			player.addStatusValue(statusEffect, 4, 9000);
			player.addStatusValue(StatusEffects.TranscendentalGeneticMemory, 2, 1);
			ascensionMetamorphPermeryMenu(2);
		}
		private function permanentizeStatusEffect3(statusEffect:StatusEffectType):void {
			if (player.statusEffectv2(StatusEffects.TranscendentalGeneticMemory) >= player.statusEffectv1(StatusEffects.TranscendentalGeneticMemory)) return;
			if (player.ascensionPerkPoints < 5) return;
			player.ascensionPerkPoints -= 5;
			player.addStatusValue(statusEffect, 4, 9000);
			player.addStatusValue(StatusEffects.TranscendentalGeneticMemory, 2, 1);
			ascensionMetamorphPermeryMenu(3);
		}
		private function permanentizeStatusEffect4(statusEffect:StatusEffectType):void {
			if (player.statusEffectv2(StatusEffects.TranscendentalGeneticMemory) >= player.statusEffectv1(StatusEffects.TranscendentalGeneticMemory)) return;
			if (player.ascensionPerkPoints < 5) return;
			player.ascensionPerkPoints -= 5;
			player.addStatusValue(statusEffect, 4, 9000);
			player.addStatusValue(StatusEffects.TranscendentalGeneticMemory, 2, 1);
			ascensionMetamorphPermeryMenu(4);
		}
		private function permanentizeStatusEffect5(statusEffect:StatusEffectType):void {
			if (player.statusEffectv2(StatusEffects.TranscendentalGeneticMemory) >= player.statusEffectv1(StatusEffects.TranscendentalGeneticMemory)) return;
			if (player.ascensionPerkPoints < 5) return;
			player.ascensionPerkPoints -= 5;
			player.addStatusValue(statusEffect, 4, 9000);
			player.addStatusValue(StatusEffects.TranscendentalGeneticMemory, 2, 1);
			ascensionMetamorphPermeryMenu(5);
		}
		private function permanentizeStatusEffect6(statusEffect:StatusEffectType):void {
			if (player.statusEffectv2(StatusEffects.TranscendentalGeneticMemory) >= player.statusEffectv1(StatusEffects.TranscendentalGeneticMemory)) return;
			if (player.ascensionPerkPoints < 5) return;
			player.ascensionPerkPoints -= 5;
			player.addStatusValue(statusEffect, 4, 9000);
			player.addStatusValue(StatusEffects.TranscendentalGeneticMemory, 2, 1);
			ascensionMetamorphPermeryMenu(6);
		}
		private function permanentizeStatusEffect7(statusEffect:StatusEffectType):void {
			if (player.statusEffectv2(StatusEffects.TranscendentalGeneticMemory) >= player.statusEffectv1(StatusEffects.TranscendentalGeneticMemory)) return;
			if (player.ascensionPerkPoints < 5) return;
			player.ascensionPerkPoints -= 5;
			player.addStatusValue(statusEffect, 4, 9000);
			player.addStatusValue(StatusEffects.TranscendentalGeneticMemory, 2, 1);
			ascensionMetamorphPermeryMenu(7);
		}
		private function permanentizeStatusEffect8(statusEffect:StatusEffectType):void {
			if (player.statusEffectv2(StatusEffects.TranscendentalGeneticMemory) >= player.statusEffectv1(StatusEffects.TranscendentalGeneticMemory)) return;
			if (player.ascensionPerkPoints < 5) return;
			player.ascensionPerkPoints -= 5;
			player.addStatusValue(statusEffect, 4, 9000);
			player.addStatusValue(StatusEffects.TranscendentalGeneticMemory, 2, 1);
			ascensionMetamorphPermeryMenu(8);
		}
		private function permanentizeStatusEffect9(statusEffect:StatusEffectType):void {
			if (player.statusEffectv2(StatusEffects.TranscendentalGeneticMemory) >= player.statusEffectv1(StatusEffects.TranscendentalGeneticMemory)) return;
			if (player.ascensionPerkPoints < 5) return;
			player.ascensionPerkPoints -= 5;
			player.addStatusValue(statusEffect, 4, 9000);
			player.addStatusValue(StatusEffects.TranscendentalGeneticMemory, 2, 1);
			ascensionMetamorphPermeryMenu(9);
		}
		private function permanentizeStatusEffect10(statusEffect:StatusEffectType):void {
			if (player.statusEffectv2(StatusEffects.TranscendentalGeneticMemory) >= player.statusEffectv1(StatusEffects.TranscendentalGeneticMemory)) return;
			if (player.ascensionPerkPoints < 5) return;
			player.ascensionPerkPoints -= 5;
			player.addStatusValue(statusEffect, 4, 9000);
			player.addStatusValue(StatusEffects.TranscendentalGeneticMemory, 2, 1);
			ascensionMetamorphPermeryMenu(10);
		}
		private function permanentizeStatusEffect11(statusEffect:StatusEffectType):void {
			if (player.statusEffectv2(StatusEffects.TranscendentalGeneticMemory) >= player.statusEffectv1(StatusEffects.TranscendentalGeneticMemory)) return;
			if (player.ascensionPerkPoints < 5) return;
			player.ascensionPerkPoints -= 5;
			player.addStatusValue(statusEffect, 4, 9000);
			player.addStatusValue(StatusEffects.TranscendentalGeneticMemory, 2, 1);
			ascensionMetamorphPermeryMenu(11);
		}
		private function permanentizeStatusEffect12(statusEffect:StatusEffectType):void {
			if (player.statusEffectv2(StatusEffects.TranscendentalGeneticMemory) >= player.statusEffectv1(StatusEffects.TranscendentalGeneticMemory)) return;
			if (player.ascensionPerkPoints < 5) return;
			player.ascensionPerkPoints -= 5;
			player.addStatusValue(statusEffect, 4, 9000);
			player.addStatusValue(StatusEffects.TranscendentalGeneticMemory, 2, 1);
			ascensionMetamorphPermeryMenu(12);
		}
		
		private function renamePrompt():void {
			clearOutput();
			outputText("You may choose to change your name.");
			mainView.nameBox.visible = true;
			mainView.nameBox.width = 165;
			mainView.nameBox.text = player.short;
			mainView.nameBox.maxChars = 16;
			mainView.nameBox.restrict = null;
			menu();
			addButton(0, "OK", chooseName);
			addButton(4, "Back", ascensionMenu);
			//Workaround
			mainView.nameBox.x = mainView.mainText.x + 5;
			mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
		}
		
		private function reincarnatePrompt():void {
			clearOutput();
			outputText("Would you like to reincarnate and start a new life as a Champion?");
			doYesNo(reincarnate, ascensionMenu);
		}
		private function reincarnate():void {
			flags[kFLAGS.NEW_GAME_PLUS_LEVEL]++;
			player.createKeyItem("Ascension", 0, 0, 0, 0);
			customPlayerProfile = null;
			newGameGo();
			player.removeKeyItem("Ascension");
			clearOutput();
			mainView.nameBox.visible = false;
			mainView.hideComboBox();
			outputText("Everything fades to white and finally... black. You can feel yourself being whisked back to reality as you slowly awaken in your room. You survey your surroundings and recognize almost immediately; you are in your room inside the inn in Ingnam! You get up and look around. ");
			if (player.hasKeyItem("Sky Poison Pearl") >= 0) {
				outputText("\n\nYou soon noticing a circular green imprint at the palm of your left hand. When you trying to figure out it meaning something clicks in your mind. It's a strange artifact that fused with your body that allow storing many things inside. Artifact that fused with your body? You are unable to recall when did yo... Wait a second there are few almost fully faded away memory fragments of you been somewhere underwater fearlessly facing some huge monster with tentacles as it legs... Doing you utermost efforts no other memories even slightest fragments apprear in your mind. Resigned you try to concentrate on remembering how to use this thing but those memories are still too blurred. Maybe with time you remember all about this... 'thing'.")
			}
			player.breastRows = [];
			player.cocks = [];
			player.vaginas = new <VaginaClass>[];
			player.horns.count = 0;
			player.horns.type = Horns.NONE;
			player.antennae.type = Antennae.NONE;
			player.ears.type = Ears.HUMAN;
			player.eyes.type = Eyes.HUMAN;
			player.tongue.type = Tongue.HUMAN;
			player.gills.type = Gills.NONE;
			player.arms.type = Arms.HUMAN;
			player.wings.type = Wings.NONE;
			player.wings.desc = "non-existant";
			player.rearBody.type = RearBody.NONE;
			player.lowerBody = LowerBody.HUMAN;
			player.skin.base.pattern = Skin.PATTERN_NONE;
			player.skin.base.adj = "";
			player.legCount = 2;
			player.tailType = Tail.NONE;
			player.tailRecharge = 0;
			player.level = 0;
			player.teaseLevel = 0;
			player.teaseXP = 0;
			player.statPoints = 0;
			player.perkPoints = 0;
			player.XP = 0;
			player.setArmor(armors.C_CLOTH);
			player.setWeapon(WeaponLib.FISTS);
			player.setWeaponRange(WeaponRangeLib.NOTHING);
			player.setShield(ShieldLib.NOTHING);
			player.setHeadJewelry(HeadJewelryLib.NOTHING);
			player.setNecklace(NecklaceLib.NOTHING);
			player.setJewelry(JewelryLib.NOTHING);
			inventory.clearStorage();
			inventory.clearGearStorage();
			inventory.initializeGearStorage();
			doNext(removeLevelPerks);
		}
		
		private function removeLevelPerks():void {
			clearOutput();
			player.perkPoints = player.level - 1;
			var ascendPerkTemp:Array = [];
			for (var i:int = 0; i < player.perks.length; i++) {
				if (isAscensionPerk(player.perks[i], true)) ascendPerkTemp.push(player.perks[i]);
			}
			player.removePerks();
			if (ascendPerkTemp.length > 0) {
				for (i = 0; i < ascendPerkTemp.length; i++) {
					player.createPerk(ascendPerkTemp[i].ptype, ascendPerkTemp[i].value1, ascendPerkTemp[i].value2, ascendPerkTemp[i].value3, ascendPerkTemp[i].value4);
				}
			}
			outputText("After looking around the room for a while, you look into the mirror and begin to recollect who you are...");
			doNext(routeToGenderChoiceReincarnation);
		}
		
		private function routeToGenderChoiceReincarnation():void {
			clearOutput();
			genericGenderChoice();
		}
		
		private function isAscensionPerk(perk:PerkClass, respec:Boolean = false):Boolean {
			return perk.ptype.keepOnAscension(respec) || perk.value4 > 0;
		}

		private function isSpecialKeyItem(keyName:* = null):Boolean {//tylko sky poinson pearl zostawić tutaj
			return (keyName == "Ascension" || keyName == "Sky Poison Pearl" || keyName == "Nieve's Tear"); 
		}

		private function isSpecialStatus(statusEffects:StatusEffectClass, statusEffect:* = null):Boolean {	
			return (statusEffect == StatusEffects.KnowsWereBeast || statusEffects.value4 == 9000);	//na razie jest tu tylko werebeast
		}	//ale potem zamienić to na specialne soulskills z każdego z klanów
	}
}
