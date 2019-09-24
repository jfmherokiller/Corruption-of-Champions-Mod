//Achievements ahoy!
package classes.GlobalFlags 
{
	import classes.Achievement;
	import classes.display.AchievementDb;
	
	public class kACHIEVEMENTS 
	{
		//Storyline Achievements
		public static const STORY_NEWCOMER:Achievement			= new Achievement(00, AchievementDb.story_newcomer, "Newcomer", "Enter the realm of Mareth after being banished from Ingnam thanks to a tradition."); //Enter the realm of Mareth.
		public static const STORY_MARAE_SAVIOR:Achievement		= new Achievement(01, AchievementDb.story_maraesavior, "Marae's Savior", "Save Marae from the demonic factory.", "You've shut down the factory and now it's no longer a problem for Marae! She must be so grateful!"); //Complete Marae’s quest.
		public static const STORY_ZETAZ_REVENGE:Achievement		= new Achievement(02, AchievementDb.story_revenge, "Revenge at Last", "Make Zetaz pay for what he did and obtain map.", "You've went the mile to make the notorious imp Zetaz pay and you received a map!"); //Defeat Zetaz and obtain the map.
		public static const STORY_FINALBOSS:Achievement			= new Achievement(03, AchievementDb.story_finalboss, "Demon Slayer", "Defeat the big bad Lethice, Queen of the Demons.", "You finally defeated Lethice, Queen of the Demons! No longer shall corruption be a problem."); //Defeat Lethice.
		
		//Zone Achievements
		public static const ZONE_EXPLORER:Achievement			= new Achievement(10, AchievementDb.explore_explorer, "Explorer", "Discover every zone available."); //Discover every zone.
		public static const ZONE_SIGHTSEER:Achievement			= new Achievement(11, null, "Sightseer", "Discover every place available."); //Discover every place.
		public static const ZONE_WHERE_AM_I:Achievement			= new Achievement(12, AchievementDb.explore_whereami, "Where am I?", "Explore for the first time."); //Explore for the first time.
		public static const ZONE_FOREST_RANGER:Achievement		= new Achievement(13, AchievementDb.explore_forest, "Forest Ranger", "Explore the forest 100 times."); //Explore the forest 100 times.
		public static const ZONE_VACATIONER:Achievement			= new Achievement(14, AchievementDb.explore_lake, "Vacationer", "Explore the lake 100 times."); //Explore the lake 100 times.
		public static const ZONE_DEHYDRATED:Achievement			= new Achievement(15, AchievementDb.explore_desert, "Dehydrated", "Explore the desert 100 times."); //Explore the desert 100 times.
		public static const ZONE_MOUNTAINEER:Achievement		= new Achievement(16, AchievementDb.explore_mountain, "Mountaineer", "Explore the mountains 100 times."); //Explore the mountain 100 times.
		public static const ZONE_WE_NEED_TO_GO_DEEPER:Achievement = new Achievement(17, AchievementDb.explore_deepwoods, "We Need to Go Deeper", "Explore the deepwoods 100 times."); //Explore the deepwoods 100 times.
		public static const ZONE_ROLLING_HILLS:Achievement		= new Achievement(18, AchievementDb.explore_plains , "Rolling Hills", "Explore the plains 100 times."); //Explore the plains 100 times.
		public static const ZONE_WET_ALL_OVER:Achievement		= new Achievement(19, AchievementDb.explore_swamp, "Wet All Over", "Explore the swamps 100 times."); //Explore the swamp 100 times.
		public static const ZONE_LIGHT_HEADED:Achievement		= new Achievement(20, AchievementDb.explore_highmountain, "Light-headed", "Explore the high mountains 100 times."); //Explore the high mountain 100 times.
		public static const ZONE_ALL_MURKY:Achievement			= new Achievement(21, AchievementDb.explore_bog, "All Murky", "Explore the bog 100 times."); //Explore the bog 100 times.
		public static const ZONE_FROZEN:Achievement				= new Achievement(22, AchievementDb.explore_glacialrift, "Frozen", "Explore the glacial rift 100 times."); //Explore the glacial rift 100 times.
		public static const ZONE_ARCHAEOLOGIST:Achievement		= new Achievement(23, null, "Archaeologist", "Visit the town ruins 15 times."); //Visit the town ruins 15 times.
		public static const ZONE_FARMER:Achievement				= new Achievement(24, null, "Farmer", "Visit the farm 30 times."); //Visit the farm 30 times.
		public static const ZONE_SEA_LEGS:Achievement			= new Achievement(25, null, "Sea-legs", "Use the boat 15 times."); //Use the boat 15 times.
		public static const ZONE_ROASTED:Achievement			= new Achievement(26, null, "Roasted", "Explore the volcanic crag 50 times."); //Explore the volcanic crag 50 times.
		
		//Level Achievements
		public static const LEVEL_LEVEL_UP:Achievement			= new Achievement(30, AchievementDb.level_t0, "Level Up!", "Get to level 2."); 
		public static const LEVEL_NOVICE:Achievement			= new Achievement(31, AchievementDb.level_t1, "Novice", "Get to level 5.");
		public static const LEVEL_APPRENTICE:Achievement		= new Achievement(32, AchievementDb.level_t2, "Apprentice", "Get to level 10.");
		public static const LEVEL_JOURNEYMAN:Achievement		= new Achievement(33, AchievementDb.level_t3, "Journeyman", "Get to level 15.");
		public static const LEVEL_EXPERT:Achievement			= new Achievement(34, AchievementDb.level_t4, "Expert", "Get to level 20.");
		public static const LEVEL_MASTER:Achievement			= new Achievement(35, AchievementDb.level_t5, "Master", "Get to level 30.");
		public static const LEVEL_GRANDMASTER:Achievement		= new Achievement(36, AchievementDb.level_t6, "Grandmaster", "Get to level 45.");
		public static const LEVEL_ILLUSTRIOUS:Achievement		= new Achievement(37, AchievementDb.level_t7, "Illustrious", "Get to level 60.");
		public static const LEVEL_OVERLORD:Achievement			= new Achievement(38, AchievementDb.level_t8, "Overlord", "Get to level 90.");
		public static const LEVEL_DEITY:Achievement				= new Achievement(39, AchievementDb.level_t8, "Deity", "Get to the level cap of 120.", "Get to the level cap of 120. Your powers would have surpassed Marae's by now.");
		
		//Population Achievements (040-049)
		public static const POPULATION_FIRST:Achievement		= new Achievement(40, AchievementDb.population_t1, "My First Companion", "Have a camp population of at least 2."); //Population 2
		public static const POPULATION_HAMLET:Achievement		= new Achievement(41, AchievementDb.population_t2, "Hamlet", "Have a camp population of at least 5."); //Population 5
		public static const POPULATION_VILLAGE:Achievement		= new Achievement(42, AchievementDb.population_t3, "Village", "Have a camp population of at least 10."); //Population 10
		public static const POPULATION_TOWN:Achievement			= new Achievement(43, AchievementDb.population_t4, "Town", "Have a camp population of at least 25."); //Population 25
		public static const POPULATION_CITY:Achievement			= new Achievement(44, AchievementDb.population_t5, "City", "Have a camp population of at least 100."); //Population 100
		public static const POPULATION_METROPOLIS:Achievement	= new Achievement(45, AchievementDb.population_t6, "Metropolis", "Have a camp population of at least 250."); //Population 250
		public static const POPULATION_MEGALOPOLIS:Achievement	= new Achievement(46, AchievementDb.population_t7, "Megapolis", "Have a camp population of at least 500."); //Population 500
		public static const POPULATION_CITY_STATE:Achievement	= new Achievement(47, AchievementDb.population_t7, "City State", "Have a camp population of at least 1,000.", "", true); //Population 1,000 (shadow achievement)
		public static const POPULATION_KINGDOM:Achievement		= new Achievement(48, AchievementDb.population_t7, "Kingdom", "Have a camp population of at least 2,500.", "", true); //Population 2,500 (shadow achievement)
		public static const POPULATION_EMPIRE:Achievement		= new Achievement(49, AchievementDb.population_t7, "Empire", "Have a camp population of at least 5,000.", "", true); //Population 5,000 (shadow achievement)
		
		//Time Achievements (050-059)
		public static const TIME_MONTH:Achievement				= new Achievement(50, AchievementDb.time_t1, "A Whole Month", "Get to day 30."); //30 days
		public static const TIME_SEASON:Achievement				= new Achievement(59, AchievementDb.time_t2, "A Full Season", "Get to day 90."); //90 days
		public static const TIME_HALF_YEAR:Achievement			= new Achievement(51, AchievementDb.time_t3, "Half-year", "Get to day 180."); //180 days
		public static const TIME_ANNUAL:Achievement				= new Achievement(52, AchievementDb.time_t4, "Annual", "Get to day 365. That's a whole year."); //365 days
		public static const TIME_BIENNIAL:Achievement			= new Achievement(53, AchievementDb.time_t5, "Bi-Annual", "Get to day 730. (2 years)"); //730 days
		public static const TIME_TRIENNIAL:Achievement			= new Achievement(54, AchievementDb.time_t6, "Tri-Annual", "Get to day 1,095. (3 years)"); //1095 days
		public static const TIME_LONG_HAUL:Achievement			= new Achievement(55, AchievementDb.time_t7, "In for the Long Haul", "Get to day 1,825. (5 years)"); //1825 days
		public static const TIME_DECADE:Achievement				= new Achievement(56, AchievementDb.time_t8, "A Whopping Decade", "Get to day 3,650. That's 10 long years! You can stop playing now...", "", true); //3650 days
		public static const TIME_CENTURY:Achievement			= new Achievement(57, AchievementDb.time_t9, "A Long Century", "Get to day 36,500. A full century! It's time to stop playing. Go outside. Please.", "", true); //36,500 days (shadow achievement)
		public static const TIME_MILLENNIUM:Achievement			= new Achievement(58, null, "A Full Millennium", "Get to day 365,000. A full millennium! Do you really have no life that you dedicated yourself to spending a THOUSAND years in Mareth? You lived FAR beyond your lifespan!", "", true);
		
		//Dungeon Achievements (060-069)
		public static const DUNGEON_DELVER:Achievement			= new Achievement(60, AchievementDb.dungeon_t1, "Rookie Delver", "Clear any dungeon.");
		public static const DUNGEON_DELVER_APPRENTICE:Achievement = new Achievement(68, AchievementDb.dungeon_t2, "Adept Delver", "Clear any 3 dungeons.");
		public static const DUNGEON_DELVER_MASTER:Achievement	= new Achievement(61, AchievementDb.dungeon_t3, "Master Delver", "Clear every dungeon in the game.");
		public static const DUNGEON_SHUT_DOWN_EVERYTHING:Achievement = new Achievement(62, null, "Shut Down Everything", "Clear the Factory and shut it down.", "You've fully cleared the Factory and acquired everything you can!");
		public static const DUNGEON_YOURE_IN_DEEP:Achievement	= new Achievement(63, null, "You're in Deep", "Fully clear the Deep Cave.", "You've fully cleared the Deep Cave and acquired everything you can!");
		public static const DUNGEON_END_OF_REIGN:Achievement	= new Achievement(69, null, "End of Reign", "Fully clear Lethice's Stronghold.", "You've fully cleared Lethice's Stronghold and eliminated every encounter!");
		public static const DUNGEON_SAND_WITCH_FRIEND:Achievement = new Achievement(64, null, "Friend of the Sand Witches", "Fully clear the Desert Cave.", "You've fully cleared the Desert Cave and acquired everything you can!");
		public static const DUNGEON_PHOENIX_FALL:Achievement	= new Achievement(65, null, "Fall of the Phoenix", "Clear the Tower of the Phoenix", "You've fully cleared the Tower of the Phoenix and looted everything you can!");
		public static const DUNGEON_ACCOMPLICE:Achievement		= new Achievement(66, null, "Accomplice", "You've witnessed Helia slaying the Harpy Queen.", "", true); //shadow achievement
		public static const DUNGEON_CELIBATE_DELVER:Achievement	= new Achievement(67, null, "Celibate Delver", "You've managed to complete Phoenix Tower without ever had an orgasm from the beginning of the game.", "", true); //shadow achievement
		
		//Fashion and Wealth Achievements (070-074)(075-079)
		public static const FASHION_WANNABE_WIZARD:Achievement	= new Achievement(70, null, "Wannabe Wizard", "Dress like a wizard by equipping wizard robes and magic staff.");
		public static const FASHION_COSPLAYER:Achievement		= new Achievement(71, null, "Cosplayer", "Wear 10 different clothes or armours.", "Wear 10 different clothings/armors. I see you've got a taste for fashion!");
		public static const FASHION_DOMINATRIX:Achievement		= new Achievement(72, null, "Dominatrix", "Wear any form of kinky clothing and wield any form of whip.");
		public static const FASHION_GOING_COMMANDO:Achievement	= new Achievement(73, null, "Going Commando", "Wear no undergarments while wearing any clothes or armours.");
		public static const FASHION_BLING_BLING:Achievement		= new Achievement(74, null, "Bling Bling", "Wear a total value of 5,000 gems across jewellery and clothes.");
		
		public static const WEALTH_RICH:Achievement				= new Achievement(75, AchievementDb.wealth_t1, "Rich", "Have 1,000 gems.");
		public static const WEALTH_HOARDER:Achievement			= new Achievement(76, AchievementDb.wealth_t2, "Hoarder", "Have 10,000 gems.");
		public static const WEALTH_GEM_VAULT:Achievement		= new Achievement(77, AchievementDb.wealth_t3, "Gem Vault", "Have 100,000 gems.");
		public static const WEALTH_MILLIONAIRE:Achievement		= new Achievement(78, AchievementDb.wealth_t3, "Millionaire", "Have a whopping 1,000,000 gems.", "Have a whopping 1,000,000 gems. What are you going to spend these gems on?");
		public static const WEALTH_ITEM_VAULT:Achievement		= new Achievement(79, null, "Item Vault", "Fill up your inventory (10 slots), chest, jewelry box, dresser, and all racks.");
		
		//Combat Achievements (080-089)
		public static const COMBAT_PAIN:Achievement				= new Achievement(82, null, "Pain", "Deal at least 50 damage in a single hit."); //50 damage
		public static const COMBAT_FRACTURED_LIMBS:Achievement	= new Achievement(83, null, "Fractured Limbs", "Deal at least 100 damage in a single hit."); //100 damage
		public static const COMBAT_BROKEN_BONES:Achievement		= new Achievement(84, null, "Broken Bones", "Deal at least 250 damage in a single hit."); //250 damage
		public static const COMBAT_OVERKILL:Achievement			= new Achievement(85, null, "Overkill", "Deal at least 500 damage in a single hit."); //500 damage
		
		public static const COMBAT_DAMAGE_SPONGE:Achievement	= new Achievement(87, null, "Damage Sponge", "Take a total of 10,000 damage.");
		public static const COMBAT_BLOOD_LETTER:Achievement		= new Achievement(88, null, "Bloodletter", "Deal a total of 50,000 damage.");
		
		public static const COMBAT_WIZARD:Achievement			= new Achievement(80, null, "Wizard", "Have knowledge of all black and white spells in the game."); //Learn all black and white spells.
		public static const COMBAT_CUM_CANNON:Achievement		= new Achievement(81, null, "Cum Cannon", "Cum in the middle of battle."); //Cum in the middle of battle.
		public static const COMBAT_SHOT_WEB:Achievement			= new Achievement(86, null, "How do I Shot Web?", "Use the web attack to trap your opponents."); //How do I shot web?
		
		//Holiday Achievements (090-099)
		public static const HOLIDAY_EGG_HUNTER:Achievement		= new Achievement(90, null, "Egg Hunter", "Find 10 eggs as random drops during Easter event.", "", true);
		public static const HOLIDAY_HELIA_BIRTHDAY:Achievement	= new Achievement(91, null, "Happy Birthday, Helia!", "Participate in Helia's Birthday event during August.", "", true);
		public static const HOLIDAY_THANKSGIVING_I:Achievement	= new Achievement(92, null, "Thankslutting", "Meet the Piggy-Slut during Thanksgiving event.", "", true);
		public static const HOLIDAY_THANKSGIVING_II:Achievement	= new Achievement(93, null, "Gobble Gobble", "Meet the Cock-gobbler during Thanksgiving event.", "", true);
		public static const HOLIDAY_HALLOWEEN_I:Achievement		= new Achievement(94, null, "Pump-kin-kin-kin", "Find the pumpkin in the Deepwoods during Halloween event.", "", true);
		public static const HOLIDAY_HALLOWEEN_II:Achievement	= new Achievement(95, null, "Fera's Wonderland", "Free Fera and visit her Wonderland during Halloween event.", "", true);
		public static const HOLIDAY_CHRISTMAS_I:Achievement		= new Achievement(96, null, "Naughty or Nice", "Meet the Christmas Elf during Christmas event.", "", true);
		public static const HOLIDAY_CHRISTMAS_II:Achievement	= new Achievement(97, null, "A Christmas Carol", "Complete Carol's mini-quest during Christmas event.", "", true);
		public static const HOLIDAY_CHRISTMAS_III:Achievement	= new Achievement(98, null, "The Lovable Snowman", "Have Nieve in your camp as lover during Christmas event.", "", true);
		public static const HOLIDAY_VALENTINE:Achievement		= new Achievement(99, null, "Will You Be My Valentine?", "Visit the Wet Bitch during Valentine's day.", "", true);
		
		//Hunger Achievements (100-104)
		public static const REALISTIC_TASTES_LIKE_CHICKEN:Achievement = new Achievement(100, null, "Tastes Like Chicken", "Refill your hunger for the first time.");
		public static const REALISTIC_CHAMPION_NEEDS_FOOD:Achievement = new Achievement(101, null, "Champion Needs Food Badly", "Instantly refill your hunger from 0 to 100 in one go."); //Champion needs food badly!
		public static const REALISTIC_GOURMAND:Achievement		= new Achievement(102, null, "Gourmand", "Refill your hunger from five different sources.");
		public static const REALISTIC_GLUTTON:Achievement		= new Achievement(103, null, "Glutton", "Eat while you're already mostly full.");
		public static const REALISTIC_FASTING:Achievement		= new Achievement(104, null, "Fasting", "Keep your hunger meter below 25 for a week but don't let it reach zero.");
		
		//Challenge Achievements (105-109)
		public static const CHALLENGE_ULTIMATE_NOOB:Achievement	= new Achievement(105, null, "The Ultimate Noob", "Defeat Lethice at level 1.", "Defeat Lethice at level 1. Wow, that must be quite impressive if you can defeat the final boss at only level one!"); //Defeat Lethice at level 1.
		public static const CHALLENGE_ULTIMATE_MUNDANE:Achievement = new Achievement(106, null, "The Mundane Champion", "Defeat Lethice without possessing any knowledge of spells."); //Defeat Lethice without spells.
		public static const CHALLENGE_ULTIMATE_CELIBATE:Achievement = new Achievement(107, null, "The Celibate Hero", "Finish the main story without ever having sex or masturbating.", "Finish the main story without ever having sex or masturbating. Proud of your virgin run, eh?"); //Finish without ever having orgasm or sex.
		public static const CHALLENGE_PACIFIST:Achievement		= new Achievement(108, null, "Pacifist", "Finish the main storyline without beating and killing anybody.", "Finish the main storyline without beating and killing anybody. Frisk would be so proud of you!"); //Beat the game without killing anyone.
		public static const CHALLENGE_SPEEDRUN:Achievement		= new Achievement(109, null, "Speedrunner", "Finish the main story within 30 days or less. Must not be on New Game+.", "Finish the main story within 30 days or less. Must not be on New Game+. You really know how to make each hour count!"); //Beat the game in 30 days or less.
		
		//Companion Achievements
		public static const GENERAL_LOVERS_HAREM:Achievement    = new Achievement(125, null, "Gotta Love 'Em All", "Get every lover in the game. (Nieve optional)");
		public static const GENERAL_LEADER:Achievement          = new Achievement(126, null, "Follow the Leader", "Get every follower in the game.");
		public static const GENERAL_SLAVER:Achievement          = new Achievement(127, null, "Meet your Master", "Get every slave in the game. (Corrupt Jojo & Amily, and Bimbo Sophie optional.)");
		public static const GENERAL_SLAVER_TRUE:Achievement     = new Achievement(128, null, "True Slaver", "Get every slave in the game, including corrupt Jojo and Amily, and Bimbo Sophie.", "", true);
		public static const GENERAL_ALL_UR_PPLZ:Achievement     = new Achievement(129, null, "All Your People are Belong to Us", "Obtain every follower, lover and slave in the game, even if they are normally mutually exclusive.");
		
		public static const GENERAL_HELSPAWN:Achievement		= new Achievement(120, null, "Helspawn", "Raise a salamander daughter with Helia until she finally reaches adulthood.");
		public static const GENERAL_GOO_ARMOR:Achievement		= new Achievement(121, null, "Goo Armour", "Acquire and wear Valeria the goo-girl armour.");
		public static const GENERAL_JOJOS_ADVENTURE:Achievement	= new Achievement(182, null, "Jojo's Bizarre Adventure", "Have Jojo in your camp, through either methods."); //Have Jojo in your camp.
		public static const GENERAL_GHOST_HOST:Achievement		= new Achievement(131, null, "Ghost Host", "Allow Shouldra to 'tag along' with you.");
		public static const GENERAL_SHARK_TALE:Achievement		= new Achievement(132, null, "Shark Tale", "Allow Izma to move into your camp.");
		
		//NPC Questline Achievements
		public static const GENERAL_MINERVA_PURED:Achievement	= new Achievement(161, null, "Divine Intervention", "Complete Minerva's purification process.");
		public static const GENERAL_URTA_TRUE_LOVER:Achievement	= new Achievement(122, AchievementDb.quest_urtalover, "Urta's True Lover", "Help Urta solve her infertility issues.");
		public static const GENERAL_MARBLE_PURED:Achievement	= new Achievement(141, AchievementDb.quest_puremarble, "Pure Marble", "Complete Marble purification quest.");
		
		//Construction Achievements
		public static const GENERAL_IM_NO_LUMBERJACK:Achievement = new Achievement(154, null, "I'm No Lumberjack", "Buy a total of 100 wood.");
		public static const GENERAL_DEFORESTER:Achievement		= new Achievement(155, null, "Deforester", "Cut down 100 wood pieces.");
		public static const GENERAL_HAMMER_TIME:Achievement		= new Achievement(156, null, "Hammer Time", "Buy a total of 300 nails.");
		public static const GENERAL_NAIL_SCAVENGER:Achievement	= new Achievement(157, null, "Nail Scavenger", "Scavenge a total of 200 nails from the library wreckage");
		public static const GENERAL_YABBA_DABBA_DOO:Achievement	= new Achievement(170, null, "Yabba Dabba Doo", "Buy a total of 100 stones.");
		public static const GENERAL_ANTWORKS:Achievement		= new Achievement(171, null, "AntWorks", "Gather a total of 200 stones with Phylla's help.");
		public static const GENERAL_HOME_SWEET_HOME:Achievement	= new Achievement(145, AchievementDb.general_house, "Home Sweet Home", "Finish the cabin and complete it with furnishings.");
		public static const GENERAL_MAKE_MARETH_GREAT_AGAIN:Achievement	= new Achievement(176, null, "Make Mareth Great Again", "Construct a wall around your camp and add a gate.", "Construct a wall around your camp and add a gate. No pesky imps shall get into your camp now!"); //Make Mareth Great Again indeed!
		public static const GENERAL_GETTING_WOOD:Achievement	= new Achievement(165, null, "Getting Wood", "Punch a tree until wood falls out... Wait, what?"); //Minecraft reference
		
		//General Achievements (110+)
		public static const GENERAL_PORTAL_DEFENDER:Achievement	= new Achievement(110, null, "Portal Defender", "Spend 10 days in Mareth and defeat a total of 25 demons."); //Defeat 25 demons and sleep 10 times.
		public static const GENERAL_BAD_ENDER:Achievement		= new Achievement(111, null, "Bad Ender", "Cause or witness 3 Bad Ends to various NPCs."); //Cause 3 bad ends to various NPCs.
		public static const GENERAL_GAME_OVER:Achievement		= new Achievement(112, null, "Game Over!", "Get a Bad End."); //Get a Bad End.
		public static const GENERAL_URINE_TROUBLE:Achievement	= new Achievement(113, null, "Urine Trouble", "Urinate in the realm of Mareth."); //Urinate once in the realm of Mareth.
		public static const GENERAL_WHATS_HAPPENING_TO_ME:Achievement = new Achievement(114, null, "What's Happening to Me?", "Transform for the first time."); //Transform for the first time. 
		public static const GENERAL_TRANSFORMER:Achievement		= new Achievement(115, null, "Transformer", "Transform a total of 10 times."); //Transform 10 times.
		public static const GENERAL_SHAPESHIFTY:Achievement		= new Achievement(116, null, "Shapeshifty", "Transform a total of 25 times."); //Transform 25 times.
		public static const GENERAL_FAPFAPFAP:Achievement		= new Achievement(117, null, "Fapfapfap", "Masturbate for the first time."); //Masturbate for the first time.
		public static const GENERAL_FAPTASTIC:Achievement		= new Achievement(118, null, "Faptastic", "Masturbate a total of 10 times."); //Masturbate 10 times.
		public static const GENERAL_FAPSTER:Achievement			= new Achievement(119, null, "Master-bation", "Masturbate a total of 100 times."); //Masturbate 100 times.
		public static const GENERAL_DRESSTACULAR:Achievement	= new Achievement(123, null, "Dresstacular", "Fill out Rubi's wardrobe with every outfit that can be given.");
		public static const GENERAL_GODSLAYER:Achievement		= new Achievement(124, null, "Godslayer", "Defeat the goddess Marae.", "Defeat the goddess Marae. If you can defeat her then you can defeat any form of challenges thrown at you!");
		public static const GENERAL_SCHOLAR:Achievement			= new Achievement(130, null, "Scholar", "Fill out your codex with every entry available in the game.");
		public static const GENERAL_FREELOADER:Achievement		= new Achievement(133, null, "Freeloader", "Visit the Kitsunes' Mansion three times.");
		public static const GENERAL_PERKY:Achievement			= new Achievement(134, null, "Perky", "Have a total of 20 perks.");
		public static const GENERAL_SUPER_PERKY:Achievement		= new Achievement(135, null, "Super Perky", "Have a total of 35 perks.");
		public static const GENERAL_ULTRA_PERKY:Achievement		= new Achievement(167, null, "Ultra Perky", "Have a total of 50 perks.");
		public static const GENERAL_STATS_50:Achievement		= new Achievement(136, null, "Jack of All Trades", "Raise your attributes to at least 50. (Libido, Sensitivity, and Corruption optional)");
		public static const GENERAL_STATS_100:Achievement		= new Achievement(137, null, "Incredible Stats", "Raise your attributes to at least 100. (Libido, Sensitivity, and Corruption optional)");
		public static const GENERAL_SCHIZO:Achievement			= new Achievement(138, null, "Schizophrenic", "Go between pure and corrupt 4 times. (Threshold of 20 and 80 corruption)");
		public static const GENERAL_CLEAN_SLATE:Achievement		= new Achievement(139, null, "Clean Slate", "Go from 100 corruption to zero for the first time.");
		public static const GENERAL_EVERYBODY_LOVES_ME:Achievement = new Achievement(140, null, "Everybody Loves Me", "Have maximum affection with at least five different NPCs.");
		public static const GENERAL_LIKE_CHUCK_NORRIS:Achievement = new Achievement(142, null, "Like Chuck Norris", "Defeat level 22+ opponent without any equipment.", "Defeat level 22+ opponent without any equipment. Way to be a badass!");
		public static const GENERAL_TENTACLE_BEAST_SLAYER:Achievement = new Achievement(144, null, "Tentacle Beast Slayer", "Slay your first Tentacle Beast.");
		public static const GENERAL_GETAWAY:Achievement			= new Achievement(146, null, "Getaway", "Spend the night outside your camp.");
		public static const GENERAL_RESTART_THE_RACES:Achievement = new Achievement(149, null, "Restart the Races", "Have at least 10 offsprings with Ember in any form.", "Have at least 10 offsprings with Ember in any form. Thanks to your help, the dragons will rise again!");
		public static const GENERAL_SMASHED:Achievement         = new Achievement(153, null, "Smashed", "Get so drunk that you end up urinating.", "", true);
		public static const GENERAL_MY_TENT_NOT_BETTER:Achievement = new Achievement(160, null, "My Tent's (not) Better Than Yours", "Sleep in Arian's tent.");
		public static const GENERAL_FENCER:Achievement		    = new Achievement(162, null, "Fencer", "Complete rapier training from Raphael.", "", true); //Shadow until there's a way for non-females to train.
		public static const GENERAL_FUCK_WITH_PORTALS:Achievement = new Achievement(164, null, "Now You're Fucking with Portals", "Engage in portal sex with Ceraph.", "", true);
		public static const GENERAL_DICK_BANISHER:Achievement	= new Achievement(166, null, "Dick Banisher", "Remove cocks from at least three dedickable NPCs. Don't you think they'll miss having their own cocks?", "", true);
		public static const GENERAL_UP_TO_11:Achievement		= new Achievement(168, null, "Up to Eleven", "Take your height up to 11 feet."); //This one goes to eleven.
		public static const GENERAL_YOU_BASTARD:Achievement		= new Achievement(169, null, "You Bastard", "Perform something only someone who's evil would do. Like corrupting NPCs or removing dick from at least 7 dedickable NPCs.", "", true);
		
		public static const GENERAL_OFF_WITH_HER_HEAD:Achievement = new Achievement(172, null, "Off With Her Head!", "You've managed to behead Lethice and show her head to the demons!", "", true); //Awarded for beheading Lethice.
		public static const GENERAL_NOOOOOOO:Achievement		= new Achievement(173, null, "NOOOOOOOOOOOO!", "You've managed to kill yourself before Lethice takes you as her slave.", "", true); //Insert Darth Vader voice here.
		public static const GENERAL_KAIZO_TRAP:Achievement		= new Achievement(174, null, "Kaizo Trap", "Just when you think you got a victory only to fall right into a Bad End instead!", "", true); //Fall victim to Kaizo Trap.
		
		public static const GENERAL_TERRACOTTA_IMPY:Achievement	= new Achievement(177, null, "Terracotta Impy", "You've placed 100 imp statues around your camp wall. No, bassy. Bad bassy! Baaad Mr. Bassy!!!", "", true); //Place 100 Imp Statues around your camp (Shadow achievement)
		public static const GENERAL_DINING_IN:Achievement		= new Achievement(178, null, "Dining In", "Eat any food at The Black Cock."); //Eat at the Black Cock.
		public static const GENERAL_HUNTER_IS_HUNTED:Achievement= new Achievement(179, null, "The Hunter Becomes the Hunted", "Turn the tables against Erlking.", "Turn the tables against Erlking. That should ought to teach him a lesson!"); //Turn the tables on Erlking
		public static const GENERAL_ALLAHU_AKBAL:Achievement	= new Achievement(180, null, "Allahu Akbal", "Submit to Akbal until you receive the associated perks."); //Get all the perks from Akbal.
		public static const GENERAL_PRISONER:Achievement		= new Achievement(181, null, "Prisoner", "Get captured and be sent to Mistress Elly's prison.", "", true); //Get captured and go to prison.
		
		//Empty IDs: 089, 143, 147, 148, 150, 151, 152, 158, 159, 163, 175
	}

}
