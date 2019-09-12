package classes 
{
	import classes.*
	import classes.BaseContent;
	import classes.GlobalFlags.kACHIEVEMENTS;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.display.AchievementDisplay;
	import classes.display.AchievementPane;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class AchievementMenu extends BaseContent
	{
		public var achievementsPane:AchievementPane = null;
		public var achievementsEarned:int = 0;
		public var achievementsTotal:int = 0;
		
		public function AchievementMenu() {}
		
		//Achievement toast
		public function toastAchievement(achievement:Achievement):void {
			var acToast:AchievementDisplay = new AchievementDisplay();
				acToast.name = "AchToast_" + achievement.getID();
				acToast.x = -acToast.width;
				acToast.y = mainView.height - acToast.height;
				acToast.alpha = 0;
				acToast.setAchievement(achievement);
			acToast.addShadowBG();
			mainView.addElement(acToast);
			tweenIn(acToast);
		}
		private function tweenIn(acBox:AchievementDisplay):void {
			var tmr:Timer = new Timer(20, 25);
			tmr.addEventListener(TimerEvent.TIMER, function():void {
				acBox.x += 10;
				acBox.alpha = 0 + (tmr.currentCount / tmr.repeatCount);
			});
			tmr.addEventListener(TimerEvent.TIMER_COMPLETE, createCallBackFunction(waitForTween, acBox));
			tmr.start();
		}
		private function waitForTween(acBox:AchievementDisplay):void {
			var tmr:Timer = new Timer(3000, 1);
			tmr.addEventListener(TimerEvent.TIMER_COMPLETE, createCallBackFunction(tweenOut, acBox));
			tmr.start();
		}
		private function tweenOut(acBox:AchievementDisplay):void {
			var tmr:Timer = new Timer(20, 25);
			tmr.addEventListener(TimerEvent.TIMER, function():void {
				acBox.x -= 10;
				acBox.alpha = 1 - (tmr.currentCount / tmr.repeatCount);
			});
			tmr.addEventListener(TimerEvent.TIMER_COMPLETE, createCallBackFunction(mainView.removeElement, acBox));
			tmr.start();
		}
		
		//Core functions
		public function exitAchievements():void {
			achievementsPane.hide();
			getGame().mainMenu.mainMenu();
		}
		
		private function addOrUpdateAchievement(achievement:Achievement):void {
			achievementsPane.addOrUpdateAchievementBox(achievement);
		}
		
		private function titleAchievementSection(title:String):void {
			achievementsPane.addCategoryHeader(title);
		}
		
		public function achievementsScreen():void {
			getGame().mainMenu.hideMainMenu();
			clearOutput();
			achievementsPane.show();
			//getGame().displayHeader("Achievements");
			//outputText("Note: Some achievements are contradictory and may require multiple playthroughs to obtain every achievement.\n");
			achievementsPane.progressBar.maxValue = Achievement.totalAchievements;
			achievementsPane.progressBar.value = Achievement.currentAchievements;
			titleAchievementSection("Main Story"); //4 achievements
			addOrUpdateAchievement(kACHIEVEMENTS.STORY_NEWCOMER);
			addOrUpdateAchievement(kACHIEVEMENTS.STORY_MARAE_SAVIOR);
			addOrUpdateAchievement(kACHIEVEMENTS.STORY_ZETAZ_REVENGE);
			addOrUpdateAchievement(kACHIEVEMENTS.STORY_FINALBOSS);

			titleAchievementSection("Side Quests");
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_URTA_TRUE_LOVER);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_MINERVA_PURED);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_MARBLE_PURED);
			
			titleAchievementSection("Exploration"); //17/20 achievements
			addOrUpdateAchievement(kACHIEVEMENTS.ZONE_EXPLORER);
			addOrUpdateAchievement(kACHIEVEMENTS.ZONE_SIGHTSEER);
			addOrUpdateAchievement(kACHIEVEMENTS.ZONE_WHERE_AM_I);
			addOrUpdateAchievement(kACHIEVEMENTS.ZONE_FOREST_RANGER);
			addOrUpdateAchievement(kACHIEVEMENTS.ZONE_VACATIONER);
			addOrUpdateAchievement(kACHIEVEMENTS.ZONE_DEHYDRATED);
			addOrUpdateAchievement(kACHIEVEMENTS.ZONE_MOUNTAINEER);
			addOrUpdateAchievement(kACHIEVEMENTS.ZONE_ROLLING_HILLS);
			addOrUpdateAchievement(kACHIEVEMENTS.ZONE_WET_ALL_OVER);
			addOrUpdateAchievement(kACHIEVEMENTS.ZONE_WE_NEED_TO_GO_DEEPER);
			addOrUpdateAchievement(kACHIEVEMENTS.ZONE_LIGHT_HEADED);
			addOrUpdateAchievement(kACHIEVEMENTS.ZONE_ALL_MURKY);
			addOrUpdateAchievement(kACHIEVEMENTS.ZONE_FROZEN);
			//addOrUpdateAchievement(kACHIEVEMENTS.ZONE_ROASTED");
			addOrUpdateAchievement(kACHIEVEMENTS.ZONE_ARCHAEOLOGIST);
			addOrUpdateAchievement(kACHIEVEMENTS.ZONE_FARMER);
			addOrUpdateAchievement(kACHIEVEMENTS.ZONE_SEA_LEGS);
			
			titleAchievementSection("Levels");
			addOrUpdateAchievement(kACHIEVEMENTS.LEVEL_LEVEL_UP);
			addOrUpdateAchievement(kACHIEVEMENTS.LEVEL_NOVICE);
			addOrUpdateAchievement(kACHIEVEMENTS.LEVEL_APPRENTICE);
			addOrUpdateAchievement(kACHIEVEMENTS.LEVEL_JOURNEYMAN);
			addOrUpdateAchievement(kACHIEVEMENTS.LEVEL_EXPERT);
			addOrUpdateAchievement(kACHIEVEMENTS.LEVEL_MASTER);
			addOrUpdateAchievement(kACHIEVEMENTS.LEVEL_GRANDMASTER);
			addOrUpdateAchievement(kACHIEVEMENTS.LEVEL_ILLUSTRIOUS);
			addOrUpdateAchievement(kACHIEVEMENTS.LEVEL_OVERLORD);
			addOrUpdateAchievement(kACHIEVEMENTS.LEVEL_DEITY);
			
			titleAchievementSection("Time");
			addOrUpdateAchievement(kACHIEVEMENTS.TIME_MONTH);
			addOrUpdateAchievement(kACHIEVEMENTS.TIME_HALF_YEAR);
			addOrUpdateAchievement(kACHIEVEMENTS.TIME_ANNUAL);
			addOrUpdateAchievement(kACHIEVEMENTS.TIME_BIENNIAL);
			addOrUpdateAchievement(kACHIEVEMENTS.TIME_TRIENNIAL);
			addOrUpdateAchievement(kACHIEVEMENTS.TIME_LONG_HAUL);
			addOrUpdateAchievement(kACHIEVEMENTS.TIME_DECADE);
			addOrUpdateAchievement(kACHIEVEMENTS.TIME_CENTURY);
			
			titleAchievementSection("Dungeons");
			addOrUpdateAchievement(kACHIEVEMENTS.DUNGEON_DELVER);
			addOrUpdateAchievement(kACHIEVEMENTS.DUNGEON_DELVER_APPRENTICE);
			addOrUpdateAchievement(kACHIEVEMENTS.DUNGEON_DELVER_MASTER);
			addOrUpdateAchievement(kACHIEVEMENTS.DUNGEON_SHUT_DOWN_EVERYTHING);
			addOrUpdateAchievement(kACHIEVEMENTS.DUNGEON_YOURE_IN_DEEP);
			addOrUpdateAchievement(kACHIEVEMENTS.DUNGEON_END_OF_REIGN);
			addOrUpdateAchievement(kACHIEVEMENTS.DUNGEON_SAND_WITCH_FRIEND);
			addOrUpdateAchievement(kACHIEVEMENTS.DUNGEON_PHOENIX_FALL);
			addOrUpdateAchievement(kACHIEVEMENTS.DUNGEON_ACCOMPLICE);
			addOrUpdateAchievement(kACHIEVEMENTS.DUNGEON_CELIBATE_DELVER);
			
			titleAchievementSection("Companions");
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_LEADER);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_LOVERS_HAREM);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_SLAVER);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_SLAVER_TRUE);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_ALL_UR_PPLZ);
			
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_JOJOS_ADVENTURE);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_HELSPAWN);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_GOO_ARMOR);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_SHARK_TALE);
			
			titleAchievementSection("Population");
			addOrUpdateAchievement(kACHIEVEMENTS.POPULATION_FIRST);
			addOrUpdateAchievement(kACHIEVEMENTS.POPULATION_HAMLET);
			addOrUpdateAchievement(kACHIEVEMENTS.POPULATION_VILLAGE);
			addOrUpdateAchievement(kACHIEVEMENTS.POPULATION_TOWN);
			addOrUpdateAchievement(kACHIEVEMENTS.POPULATION_CITY);
			addOrUpdateAchievement(kACHIEVEMENTS.POPULATION_METROPOLIS);
			addOrUpdateAchievement(kACHIEVEMENTS.POPULATION_MEGALOPOLIS);
			addOrUpdateAchievement(kACHIEVEMENTS.POPULATION_CITY_STATE);
			addOrUpdateAchievement(kACHIEVEMENTS.POPULATION_KINGDOM);
			addOrUpdateAchievement(kACHIEVEMENTS.POPULATION_EMPIRE);
			
			titleAchievementSection("Fashion");
			addOrUpdateAchievement(kACHIEVEMENTS.FASHION_WANNABE_WIZARD);
			addOrUpdateAchievement(kACHIEVEMENTS.FASHION_COSPLAYER);
			addOrUpdateAchievement(kACHIEVEMENTS.FASHION_DOMINATRIX);
			addOrUpdateAchievement(kACHIEVEMENTS.FASHION_GOING_COMMANDO);
			addOrUpdateAchievement(kACHIEVEMENTS.FASHION_BLING_BLING);
			
			titleAchievementSection("Wealth");
			addOrUpdateAchievement(kACHIEVEMENTS.WEALTH_RICH);
			addOrUpdateAchievement(kACHIEVEMENTS.WEALTH_HOARDER);
			addOrUpdateAchievement(kACHIEVEMENTS.WEALTH_GEM_VAULT);
			addOrUpdateAchievement(kACHIEVEMENTS.WEALTH_MILLIONAIRE);
			addOrUpdateAchievement(kACHIEVEMENTS.WEALTH_ITEM_VAULT);
			
			titleAchievementSection("Combat"); 
			addOrUpdateAchievement(kACHIEVEMENTS.COMBAT_WIZARD);
			addOrUpdateAchievement(kACHIEVEMENTS.COMBAT_CUM_CANNON);
			addOrUpdateAchievement(kACHIEVEMENTS.COMBAT_SHOT_WEB);
			addOrUpdateAchievement(kACHIEVEMENTS.COMBAT_PAIN);
			addOrUpdateAchievement(kACHIEVEMENTS.COMBAT_FRACTURED_LIMBS);
			addOrUpdateAchievement(kACHIEVEMENTS.COMBAT_BROKEN_BONES);
			addOrUpdateAchievement(kACHIEVEMENTS.COMBAT_OVERKILL);
			addOrUpdateAchievement(kACHIEVEMENTS.COMBAT_DAMAGE_SPONGE);
			addOrUpdateAchievement(kACHIEVEMENTS.COMBAT_BLOOD_LETTER);
			
			titleAchievementSection("Construction");
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_HAMMER_TIME);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_NAIL_SCAVENGER);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_IM_NO_LUMBERJACK);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_DEFORESTER);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_YABBA_DABBA_DOO);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_ANTWORKS);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_HOME_SWEET_HOME);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_MAKE_MARETH_GREAT_AGAIN);
			//addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_JUST_BUILD_LOL);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_GETTING_WOOD);
			
			titleAchievementSection("Seasonal Events");
			addOrUpdateAchievement(kACHIEVEMENTS.HOLIDAY_EGG_HUNTER);
			addOrUpdateAchievement(kACHIEVEMENTS.HOLIDAY_HELIA_BIRTHDAY);
			addOrUpdateAchievement(kACHIEVEMENTS.HOLIDAY_THANKSGIVING_I);
			addOrUpdateAchievement(kACHIEVEMENTS.HOLIDAY_THANKSGIVING_II);
			addOrUpdateAchievement(kACHIEVEMENTS.HOLIDAY_HALLOWEEN_I);
			addOrUpdateAchievement(kACHIEVEMENTS.HOLIDAY_HALLOWEEN_II);
			addOrUpdateAchievement(kACHIEVEMENTS.HOLIDAY_CHRISTMAS_I);
			addOrUpdateAchievement(kACHIEVEMENTS.HOLIDAY_CHRISTMAS_II);
			addOrUpdateAchievement(kACHIEVEMENTS.HOLIDAY_CHRISTMAS_III);
			addOrUpdateAchievement(kACHIEVEMENTS.HOLIDAY_VALENTINE);
			
			titleAchievementSection("Survival/Realistic Mode"); //4/5 achievements
			addOrUpdateAchievement(kACHIEVEMENTS.REALISTIC_TASTES_LIKE_CHICKEN);
			addOrUpdateAchievement(kACHIEVEMENTS.REALISTIC_CHAMPION_NEEDS_FOOD);
			addOrUpdateAchievement(kACHIEVEMENTS.REALISTIC_GOURMAND);
			addOrUpdateAchievement(kACHIEVEMENTS.REALISTIC_GLUTTON);
			addOrUpdateAchievement(kACHIEVEMENTS.REALISTIC_FASTING);
			
			titleAchievementSection("Challenges");
			addOrUpdateAchievement(kACHIEVEMENTS.CHALLENGE_ULTIMATE_NOOB);
			addOrUpdateAchievement(kACHIEVEMENTS.CHALLENGE_ULTIMATE_MUNDANE);
			addOrUpdateAchievement(kACHIEVEMENTS.CHALLENGE_ULTIMATE_CELIBATE);
			addOrUpdateAchievement(kACHIEVEMENTS.CHALLENGE_PACIFIST);
			addOrUpdateAchievement(kACHIEVEMENTS.CHALLENGE_SPEEDRUN);
			
			titleAchievementSection("General"); //Loads of achievements
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_PORTAL_DEFENDER);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_BAD_ENDER);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_GAME_OVER);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_URINE_TROUBLE);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_SMASHED);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_WHATS_HAPPENING_TO_ME);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_TRANSFORMER);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_SHAPESHIFTY);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_FAPFAPFAP);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_FAPTASTIC);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_FAPSTER);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_PERKY);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_SUPER_PERKY);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_ULTRA_PERKY);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_GODSLAYER);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_SCHOLAR);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_FREELOADER);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_SCHIZO);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_CLEAN_SLATE);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_STATS_50);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_STATS_100);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_LIKE_CHUCK_NORRIS);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_TENTACLE_BEAST_SLAYER);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_GETAWAY);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_MY_TENT_NOT_BETTER);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_FENCER);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_FUCK_WITH_PORTALS);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_DICK_BANISHER);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_YOU_BASTARD);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_UP_TO_11);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_OFF_WITH_HER_HEAD);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_NOOOOOOO);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_TERRACOTTA_IMPY);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_KAIZO_TRAP);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_HUNTER_IS_HUNTED);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_ALLAHU_AKBAL);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_DINING_IN);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_PRISONER);
			addOrUpdateAchievement(kACHIEVEMENTS.GENERAL_DRESSTACULAR);
			doNext(exitAchievements);
		}
		
	}

}
