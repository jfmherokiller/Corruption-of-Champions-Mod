package classes{
	import classes.Items.ConsumableLib;
	import classes.internals.SaveGameUtils;
	import classes.internals.SerializationUtils;
	import classes.lists.BreastCup;
	import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	
	import flash.display.Stage;
	
	import classes.CoC;
	import classes.Scenes.Inventory;
	import classes.Saves;
	import classes.helper.StageLocator;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	
	public class SavesTest {
		private static const TEST_VERSION:String = "test";
		private static const TEST_SAVE_GAME:String = "test";
		
		private static const CLIT_LENGTH:Number = 5;
		private static const VAGINA_RECOVERY_PROGRESS:int = 6;
		
		private static const NUMBER_OF_COCKS:int = 3;
		private static const TEST_SOCK:String = "testSock";
		private static const VIRIDIAN_SOCK:String = "viridian";
		
		private static const NUMBER_OF_BREAST_ROWS:int = 3;
		
		private static const TEST_PLAYER_A:String = "foo";
		private static const TEST_PLAYER_SHORT:String = "bar";
		
		private static const ASS_WETTNESS:int = 1;
		private static const ASS_LOOSENESS:int = 2;
		private static const ASS_FULLNESS:int = 3;
		
		private static const PLAYER_STR:int = 42;
		private static const PLAYER_TOU:int = 43;
		private static const PLAYER_SPE:int = 44;
		private static const PLAYER_INT:int = 45;
		private static const PLAYER_LIB:int = 46;
		private static const PLAYER_SENS:int = 47;
		private static const PLAYER_COR:int = 48;
		private static const PLAYER_FATIGUE:int = 49;
		
		private static const PLAYER_XP:int = 7;

		private var player:Player;
		private var cut:SavesForTest;
		private static var consumables:ConsumableLib;
		
		private var saveFile:*;
		private var serializedSave:* = [];
		
		[BeforeClass]
		public static function setUpClass():void {
			kGAMECLASS = new CoC(StageLocator.stage);
			consumables = new ConsumableLib();
		}
		
		[Before]
		public function setUp():void {
			player = new Player();
			player.short = TEST_PLAYER_SHORT;
			player.a = TEST_PLAYER_A;
		
			createPlayerCocks();
			createPlayerBreasts();
			createPlayerAss();
			setPlayerStats();
			createDummySerializedObject();
			
			kGAMECLASS.player = player;
			kGAMECLASS.ver = TEST_VERSION;
			kGAMECLASS.version = TEST_VERSION;
			
			cut = new SavesForTest(kGAMECLASS.gameStateDirectGet, kGAMECLASS.gameStateDirectSet);
			kGAMECLASS.inventory = new Inventory(cut);
			
			player.itemSlot(0).setItemAndQty(consumables.CANINEP, 6);
			player.itemSlot(0).damage = 7;
			
			player.itemSlot(2).setItemAndQty(consumables.EQUINUM, 8);
			player.itemSlot(2).damage = 9;
			
			initInventory();
			
			saveGame();

			kGAMECLASS.flags[kFLAGS.JOJO_STATUS] = 5;
			saveFile = [];
			saveFile.data = [];
			
			kGAMECLASS.inventory.clearStorage();
		}
		
		[After]
		public function tearDown():void
		{
			SaveGameUtils.deleteSaveGame(TEST_SAVE_GAME);
			SaveGameUtils.deleteSaveGame(TEST_SAVE_GAME + "_backup");
		}
		
		private function saveGame():void {
			cut.saveGame(TEST_SAVE_GAME, false);
		}
		
		private function loadGame():void {
			kGAMECLASS.player = new Player();
			
			cut.loadGame(TEST_SAVE_GAME);
			
			this.player = kGAMECLASS.player;
		}
		
		private function createPlayerCocks():void {
			player.removeCock(0, int.MAX_VALUE);
			
			player.createCock(1, 1, CockTypesEnum.CAT);
			player.createCock(2, 2, CockTypesEnum.DOG);
			player.createCock(3, 3, CockTypesEnum.HORSE);
		}
		
		private function createPlayerBreasts():void {
			player.removeBreastRow(0, int.MAX_VALUE);
			
			player.createBreastRow(BreastCup.A);
			player.createBreastRow(BreastCup.B);
			player.createBreastRow(BreastCup.C);
		}
		
		private function createPlayerAss():void
		{
			player.ass.analWetness = ASS_WETTNESS;
			player.ass.analLooseness = ASS_LOOSENESS;
			player.ass.fullness = ASS_FULLNESS;
		}
		
		private function setPlayerStats():void
		{
			player.str = PLAYER_STR;
			player.tou = PLAYER_TOU;
			player.spe = PLAYER_SPE;
			player.inte = PLAYER_INT;
			player.lib = PLAYER_LIB;
			player.sens = PLAYER_SENS;
			player.cor = PLAYER_COR;
			player.fatigue = PLAYER_FATIGUE;
			
			player.XP = PLAYER_XP;
		}
		
		private function buildDummySaveForJojoTest():void
		{
			SerializationUtils.serialize(saveFile.data, new Player());
			saveFile.data.serializationVersion = undefined;
			saveFile.data.npcs = [];
			saveFile.data.npcs.jojo = [];
		}
		
		private function createDummySerializedObject():void
		{
			serializedSave["serializationVersion"] = 1;
			serializedSave.itemStorage = [];
			
			var slot1:ItemSlot = new ItemSlot();
			slot1.setItemAndQty(consumables.CANINEP, 2);
			
			var slot2:ItemSlot = new ItemSlot();
			slot2.setItemAndQty(consumables.EQUINUM, 3);
			
			
			serializedSave.itemStorage.push(slot1);
			serializedSave.itemStorage.push(slot2);
		}
		
		private function initInventory():void
		{
			//TODO remove this once the saves serialization has been completed
			var items:Array = kGAMECLASS.inventory.itemStorageDirectGet();
			
			kGAMECLASS.inventory.createStorage();
			kGAMECLASS.inventory.createStorage();
			kGAMECLASS.inventory.createStorage();
			kGAMECLASS.inventory.createStorage();
			kGAMECLASS.inventory.createStorage();
			
			// this is completely safe, trust me!  /s
			(items[0] as ItemSlot).setItemAndQty(consumables.PURPDYE, 3);
			(items[1] as ItemSlot).setItemAndQty(consumables.PURHONY, 5);
			(items[2] as ItemSlot).setItemAndQty(ItemType.NOTHING, 0);
			(items[2] as ItemSlot).unlocked = false;
		}
		
		[Test]
		public function testClitLengthSaved():void {
			player.createVagina();
			player.setClitLength(CLIT_LENGTH);
			cut.saveGame(TEST_SAVE_GAME, false);
			player.setClitLength(0);
			
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.getClitLength(), equalTo(CLIT_LENGTH));
		}
		
		[Test] 
		public function testRecoveryProgressSaved():void {
			player.createVagina();
			player.vaginas[0].recoveryProgress = VAGINA_RECOVERY_PROGRESS;
			cut.saveGame(TEST_SAVE_GAME, false);
			player.vaginas[0].resetRecoveryProgress();
			
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.vaginas[0].recoveryProgress, equalTo(VAGINA_RECOVERY_PROGRESS));
		}
		
		[Test]
		public function playerHasThreeCocks():void {
			assertThat(player.cocks.length, equalTo(NUMBER_OF_COCKS));
		}
		
		[Test]
		public function cocksAreStored():void {
			player.removeCock(0, 3);
			assertThat(player.cocks.length, equalTo(0));
			
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.cocks.length, equalTo(NUMBER_OF_COCKS));
		}

		[Test]
		public function cocksLoadOrder():void {
			player.removeCock(0, 3);
			assertThat(player.cocks.length, equalTo(0));
			
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.cocks[0].cockType, equalTo(CockTypesEnum.CAT));
			assertThat(kGAMECLASS.player.cocks[2].cockType, equalTo(CockTypesEnum.HORSE));
		}
		
		[Test]
		public function cockLoadViridianSockGrantsLustyRegenerationPerk():void {
			player.cocks[0].sock = VIRIDIAN_SOCK;
			
			saveGame();
			loadGame();
			
			assertThat(player.hasPerk(PerkLib.LustyRegeneration), equalTo(true));
		}
		
		[Test]
		public function cockLoadNoLustyRegenerationPerkWithoutViridianSock():void {
			player.cocks[0].sock = TEST_SOCK;
			
			saveGame();
			loadGame();
			
			assertThat(player.hasPerk(PerkLib.LustyRegeneration), equalTo(false));
		}

		[Test]
		public function jojoLegacyStatusLoadJojoIsSlave():void {
			buildDummySaveForJojoTest();
			
			cut.loadNPCstest(saveFile);

			assertThat(kGAMECLASS.flags[kFLAGS.JOJO_STATUS], equalTo(6));
		}

		[Test]
		public function jojoLegacyStatusLoadJojoEncountersInProgress():void {
			buildDummySaveForJojoTest();
			
			var jojoStatus:int = 3;
			kGAMECLASS.flags[kFLAGS.JOJO_STATUS] = jojoStatus;
			
			cut.loadNPCstest(saveFile);

			assertThat(kGAMECLASS.flags[kFLAGS.JOJO_STATUS], equalTo(jojoStatus));
		}

		[Test]
		public function jojoNewStatusLoadUpdateSlaveStatus():void {
			buildDummySaveForJojoTest();
			saveFile.data.npcs.jojo.serializationVersion = 1;

			cut.loadNPCstest(saveFile);

			assertThat(kGAMECLASS.flags[kFLAGS.JOJO_STATUS], equalTo(5));
		}

		[Test]
		public function loadWithMissingNpcs():void {
			buildDummySaveForJojoTest();
			saveFile.data.npcs = undefined;

			cut.loadNPCstest(saveFile);

			assertThat(kGAMECLASS.flags[kFLAGS.JOJO_STATUS], equalTo(6));
		}

		[Test]
		public function loadWithMissingJojoNpc():void {
			buildDummySaveForJojoTest();
			saveFile.data.npcs = [];

			cut.loadNPCstest(saveFile);

			assertThat(kGAMECLASS.flags[kFLAGS.JOJO_STATUS], equalTo(6));
		}
		
		[Test]
		public function breastRowsAreStored():void
		{
			player.breastRows.length = 0;
			assertThat(player.breastRows.length, equalTo(0));
			
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.breastRows.length, equalTo(NUMBER_OF_BREAST_ROWS));
		}
		
		[Test]
		public function breastRowLoadOrder():void {
			player.breastRows.length = 0;
			assertThat(player.breastRows.length, equalTo(0));
			
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.breastRows[0].breastRating, equalTo(BreastCup.A));
			assertThat(kGAMECLASS.player.breastRows[2].breastRating, equalTo(BreastCup.C));
		}
		
		[Test]
		public function vaginaTypeReset():void {
			player.createVagina(true, 1, 0);
			player.vaginas[0].type = Vagina.EQUINE;
			
			cut.saveGame(TEST_SAVE_GAME);
			cut.loadGame(TEST_SAVE_GAME);

			assertThat(kGAMECLASS.player.vaginas[0].type, equalTo(Vagina.HUMAN));
		}
		
		[Test]
		public function humanVaginaIsOK():void {
			player.createVagina(true, 1, 0);
			player.vaginas[0].type = Vagina.HUMAN;
			
			cut.saveGame(TEST_SAVE_GAME);
			cut.loadGame(TEST_SAVE_GAME);

			assertThat(kGAMECLASS.player.vaginas[0].type, equalTo(Vagina.HUMAN));
		}
		
		[Test]
		public function sandTrapVaginaIsOK():void {
			player.createVagina(true, 1, 0);
			player.vaginas[0].type = Vagina.BLACK_SAND_TRAP;
			
			cut.saveGame(TEST_SAVE_GAME);
			cut.loadGame(TEST_SAVE_GAME);

			assertThat(kGAMECLASS.player.vaginas[0].type, equalTo(Vagina.BLACK_SAND_TRAP));
		}
		
		[Test]
		public function playerForceOneBreastRow():void {
			player.breastRows.length = 0;
			assertThat(player.breastRows.length, equalTo(0));
			
			cut.saveGame(TEST_SAVE_GAME);
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.breastRows.length, equalTo(1));
		}
		
		[Test]
		public function serializePlayerShortName():void {
			kGAMECLASS.player.short = "";
			
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.short, equalTo(TEST_PLAYER_SHORT));
		}
		
		[Test]
		public function serializePlayerA():void {
			kGAMECLASS.player.a = "";
			
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.a, equalTo(TEST_PLAYER_A));
		}
		
		[Test]
		public function playerAssWetnessLoaded():void
		{
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.ass.analWetness, equalTo(ASS_WETTNESS));
		}
		
		[Test]
		public function playerAssLoosenessLoaded():void
		{
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.ass.analLooseness, equalTo(ASS_LOOSENESS));
		}
		
		[Test]
		public function playerAssFullnessLoaded():void
		{
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.ass.fullness, equalTo(ASS_FULLNESS));
		}
		
		[Test]
		public function playerStrStatLoaded():void
		{
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.str, equalTo(PLAYER_STR));
		}
		
		[Test]
		public function playerTouStatLoaded():void
		{
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.tou, equalTo(PLAYER_TOU));
		}
		
		[Test]
		public function playerSpeStatLoaded():void
		{
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.spe, equalTo(PLAYER_SPE));
		}
		
		[Test]
		public function playerIntStatLoaded():void
		{
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.inte, equalTo(PLAYER_INT));
		}
		
		[Test]
		public function playerLibStatLoaded():void
		{
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.lib, equalTo(PLAYER_LIB));
		}
		
		[Test]
		public function playerSensStatLoaded():void
		{
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.sens, equalTo(PLAYER_SENS));
		}
		
		[Test]
		public function playerCorStatLoaded():void
		{
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.cor, equalTo(PLAYER_COR));
		}
		
		[Test]
		public function playerFatigueStatLoaded():void
		{
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.fatigue, equalTo(PLAYER_FATIGUE));
		}
		
		[Test]
		public function playerXPLoaded():void
		{
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.XP, equalTo(PLAYER_XP));
		}
		
		[Test]
		public function undefinedGemsShouldBeZero():void
		{
			kGAMECLASS.player.gems = undefined;
			
			cut.saveGame(TEST_SAVE_GAME);
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.gems, equalTo(0));
		}
		
		[Test]
		public function negativeGemsShouldBeZero():void
		{
			kGAMECLASS.player.gems = -10;
			
			cut.saveGame(TEST_SAVE_GAME);
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.gems, equalTo(0));
		}
		
		[Test]
		public function loadPlayerNipplelengthUndefined():void
		{
			kGAMECLASS.player.nippleLength = undefined;
			
			cut.saveGame(TEST_SAVE_GAME);
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.nippleLength, equalTo(0.25));
		}
		
		[Test]
		public function loadItemSlot1Type():void
		{
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.itemSlot1.itype, equalTo(consumables.CANINEP));
		}
		
		[Test]
		public function loadItemSlot1Quantity():void
		{
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.itemSlot1.quantity, equalTo(6));
		}
		
		[Test]
		public function loadItemSlot1Unlocked():void
		{
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.itemSlot1.unlocked, equalTo(true));
		}
		
		public function loadItemSlot1Damage():void
		{
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.itemSlot1.damage, equalTo(7));
		}
		
		[Test]
		public function firstItemSlotUnlocked():void
		{
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.itemSlot(0).unlocked, equalTo(true));
		}
		
		[Test]
		public function secondItemSlotUnlocked():void
		{
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.itemSlot(1).unlocked, equalTo(true));
		}
		
		[Test]
		public function thirdItemSlotUnlocked():void
		{
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.itemSlot(2).unlocked, equalTo(true));
		}
		
		[Test]
		public function fourthItemSlotLocked():void
		{
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.itemSlot(3).unlocked, equalTo(false));
		}
		
		[Test]
		public function tenththItemSlotLocked():void
		{
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.itemSlot(9).unlocked, equalTo(false));
		}
		
		[Test(expected=RangeError)]
		public function accessOutOfBoundsItemSlot():void
		{
			assertThat(kGAMECLASS.player.itemSlot(10), nullValue());
		}
		
		[Test]
		public function itemSlotLoadOrder():void
		{
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.itemSlot1.itype, equalTo(consumables.CANINEP));
			assertThat(kGAMECLASS.player.itemSlot2.itype, equalTo(ItemType.NOTHING));
			assertThat(kGAMECLASS.player.itemSlot3.itype, equalTo(consumables.EQUINUM));
		}
		
		[Test]
		public function upgradeCreatesInventory():void
		{	
			cut.upgradeSerializationVersion(serializedSave, 1);
			
			assertThat(serializedSave, hasProperty("inventory"));
		}
		
		[Test]
		public function upgradeCreatesItemStorageInInventory():void
		{	
			cut.upgradeSerializationVersion(serializedSave, 1);
			
			assertThat(serializedSave.inventory, hasProperty("itemStorage"));
		}
		
		[Test]
		public function upgradeCopiesItemStorageData():void
		{	
			cut.upgradeSerializationVersion(serializedSave, 1);
			
			assertThat(serializedSave.inventory.itemStorage[0].itype.id, equalTo(consumables.CANINEP.id));
			assertThat(serializedSave.inventory.itemStorage[1].itype.id, equalTo(consumables.EQUINUM.id));
		}
		
		[Test]
		public function upgradeDeletesItemStorageFromSaveRoot():void
		{	
			cut.upgradeSerializationVersion(serializedSave, 1);
			
			assertThat(serializedSave, not(hasProperty("itemStorage")));
		}
		
		[Test]
		public function upgradeAddsVersionForPlayer():void
		{	
			cut.upgradeSerializationVersion(serializedSave, 2);
			
			assertThat(serializedSave.serializationVersionDictionary, hasProperty(new Player().serializationUUID()));
		}
		
		[Test]
		public function inventoryMustBeValid():void
		{
			assertThat(kGAMECLASS.inventory, notNullValue());
		}
		
		[Test(description="This is to test that the inventory is correctly serialized")]
		public function itemStorageLoaded():void
		{
			//TODO remove this once the saves serialization has been completed
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat("Item storage did not contain purple dye", kGAMECLASS.inventory.hasItemInStorage(consumables.PURPDYE), equalTo(true));
			assertThat("Item storage did not contain pure honey", kGAMECLASS.inventory.hasItemInStorage(consumables.PURHONY), equalTo(true));
		}
	}
}

import classes.Saves
import classes.internals.SerializationUtils;

class SavesForTest extends Saves {
	public function SavesForTest(gameStateDirectGet:Function, gameStateDirectSet:Function) {
		super(gameStateDirectGet, gameStateDirectSet);
	}

	public function saveNPCstest(saveFile:*):void {
		SerializationUtils.serialize(saveFile.data, this);
	}

	public function loadNPCstest(saveFile:*):void {
		SerializationUtils.deserialize(saveFile.data, this);
	}
}
