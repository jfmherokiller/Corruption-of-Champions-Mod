package classes {
    import fats.valueObjects.*;

    import flash.net.SharedObject;

    import mx.graphics.SolidColor;
    import mx.utils.ObjectUtil;

    public class noonesContent extends BaseContent {




        //registerClassAlias("src.valueObjects.Items", Items);
        //registerClassAlias("src.valueObjects.Quests", Quests);
        //registerClassAlias("src.valueObjects.Player", Species);
        //registerClassAlias("src.valueObjects.Enemies", Enemies);
        //registerClassAlias("src.valueObjects.Gender", Gender);
        //registerClassAlias("src.valueObjects.NPCs", NPCs);
        //registerClassAlias("src.valueObjects.Spells", Spells);
        //registerClassAlias("src.valueObjects.DamageType", DamageType);
        //registerClassAlias("src.valueObjects.Vendors", Vendors);

        [Bindable]
        public var version:Number = 0.6;

        //Embedded images////////////////////////////////////////////////

        //Enemy Images
        [Bindable]
        public var enemyImageSource:Class;

        //Location images
        [Bindable]
        public var backgroundImageSource:Class;


        //Player stats, these are modified by the other stat variables
        [Bindable]
        public var STR:Number = 0;
        [Bindable]
        public var AGI:Number = 0;
        [Bindable]
        public var INT:Number = 0;
        [Bindable]
        public var STO:Number = 0;
        [Bindable]
        public var END:Number = 0;

        //The players base stats before modifiers
        //these are the stats that are actually increased when your character raises their stats
        [Bindable]
        public var bSTR:Number = 0;
        public var bAGI:Number = 0;
        public var bINT:Number = 0;
        public var bSTO:Number = 0;
        public var bEND:Number = 0;

        //The temporary modifiers for the players stats, usually done by enemy attacks
        public var tenemySTRdebuff:Number = 0;
        public var tenemyAGIdebuff:Number = 0;
        public var tenemyINTdebuff:Number = 0;
        public var tenemySTOdebuff:Number = 0;
        public var tenemyENDdebuff:Number = 0;
        [Bindable]
        public var tenemyFATdebuff:Number = 0;

        //Temporary magic duffs and debuffs
        public var tmagicSTRbuff:Number = 0;
        public var tmagicAGIbuff:Number = 0;
        public var tmagicINTbuff:Number = 0;
        public var tmagicSTObuff:Number = 0;
        public var tmagicENDbuff:Number = 0;
        public var tmagicDEFbuff:Number = 0;
        public var tmagicDODGEbuff:int = 0;
        public var tmagicREGENbuff:int = 0;
        public var tmagicREGENbuffDamage:int = 0;
        public var tmagicREGENbuffRange:int = 0;

        //Stat bar colors, these are changed by the updateStats() function
        [Bindable]
        public var strColor:uint = new uint(0x000000);
        [Bindable]
        public var agiColor:uint = new uint(0x000000);
        [Bindable]
        public var endColor:uint = new uint(0x000000);
        [Bindable]
        public var intColor:uint = new uint(0x000000);
        [Bindable]
        public var stoColor:uint = new uint(0x000000);
        [Bindable]
        public var manaColor:uint = 0;
        [Bindable]
        public var healthColor:uint = 0;

        //Players maximum values for stats, these are updated by the updateStats() function
        [Bindable]
        public var maxFUL:int = 1;
        [Bindable]
        public var maxHEA:int = 100;
        [Bindable]
        public var bmaxHEA:int = 100;
        [Bindable]
        public var tmaxHEA:int = 100;
        [Bindable]
        public var maxMANA:int = 1;
        [Bindable]
        public var tmaxMANA:int;

        //Constantly varying player stats
        [Bindable]
        public var HEA:int = 0;
        [Bindable]
        public var MANA:Number = 0;
        [Bindable]
        public var FUL:int = 0;
        [Bindable]
        public var FULbarScale:Number = 0;
        [Bindable]
        public var HEAbarScale:Number = 0;
        [Bindable]
        public var MANAbarScale:Number = 0;
        [Bindable]
        public var STA:Number = 0;
        [Bindable]
        public var ATE:Number = 0;
        [Bindable]
        public var Eaten:Number = 0;
        [Bindable]
        public var Drank:Number = 0;
        public var Inflated:Number = 0;
        [Bindable]
        public var InflatedMass:Number = 0;
        public var Calories:Number = 0;
        [Bindable]
        public var FAT:Number = 0;

        //Quests array
        public var questArray:Array = [];

        //Character's descriptive characteristics
        [Bindable]
        public var playerHeight:int = 70;
        [Bindable]
        public var playerSpecies:Species;
        [Bindable]
        public var playerName:String;
        [Bindable]
        public var playerGender:Gender;

        //Players secondary stats
        [Bindable]
        public var XP:int = 0;
        [Bindable]
        public var XPtoLevel:int = 100;
        [Bindable]
        public var LVL:int = 1;
        public var LVLup:int = 0;

        //Equipped items
        public var WEA:Items;
        public var ARM:Items;
        public var TOP:Items;
        public var BTM:Items;

        //Timed event counters
        //Many timed events are broken up into a timer component and a power component
        //For instance "statusENDBuff" represents how long your endurance is buffed for and "statusENDBuffPower" represents how much your endurance is buffed by
        //Different counters count up or down depending on what the event calls for
        public var statusStomachStretch:int = 0;
        public var statusBloatVenom:int = 0;
        public var statusBloatVenomPower:int = 0;
        public var statusBurn:int = 0;
        public var statusBurnPower:int = 0;
        public var statusWellFed:int = 0;
        public var statusWellFedPower:int = 0;
        public var statusSTRBuff:int = 0;
        public var statusSTRBuffPower:int = 0;
        public var statusAGIBuff:int = 0;
        public var statusAGIBuffPower:int = 0;
        public var statusINTBuff:int = 0;
        public var statusINTBuffPower:int = 0;
        public var statusENDBuff:int = 0;
        public var statusENDBuffPower:int = 0;
        public var statusMANABuff:int = 0;
        public var statusMANABuffPower:int = 0;
        public var statusSTOBuff:int = 0;
        public var statusSTOBuffPower:int = 0;

        //Clock variables
        [Bindable]
        public var day:int = 1;
        [Bindable]
        public var AMPM:String = "AM";
        [Bindable]
        public var hour:int = 9;
        [Bindable]
        public var displayHour:int = 8;
        [Bindable]
        public var tensMinute:int = 0;
        [Bindable]
        public var onesMinute:Number = 0;

        //Main scene text
        [Bindable]
        public var mainText:String = "";

        //Miscellaneous scene text
        //Used for things like the "Surroundings" menu and other submenus so that the main screen text doesn't get overwritten
        [Bindable]
        public var miscellaneousText:String = "";

        //Tags for states of being
        //Mostly used so various functions now how to properly execute
        public var inShop:Boolean = false;
        public var depositing:Boolean = false;
        public var discarding:Boolean = false;
        public var keyItems:Boolean = false;

        //Hides or displays the rest, inventory, spells, instructions, options, and load buttons
        //This is used to prevent the player from getting stuck after clicking on one of those buttons
        [Bindable]
        public var appButtonVisibility:Boolean = false;

        //Both of these variables record which stage of a special event you are in. I recommend using the "subEvent" variable
        //Used to record what stage of an event you are on so it might go "1" -> "11" -> "112" -> "1121" -> etc.
        //Not a very intuitive way to record what stage you're on though and can be confusing to work with
        public var specialEvent:int = 0;

        //Also used to keep track of what stage of an event you are on, but this is represented with text. For example you might use
        //"introduction" -> "opened door" -> "pulled rope" -> "failed to dodge boulder" -> etc.
        //This is much more intuitive and easy to remember what you're doing, since things have actual names rather than being strings of numbers
        public var subEvent:String = "";

        //Records what caused you to be defeated, E.G. overeating, defeated in battle, overinflated, etc.
        public var defeatedBy:Defeats;

        //records whether you've started a game or not. Used to tell certain functions how to work
        [Bindable]
        public var newGame:Boolean = true;

        //Records where you are and where you came from
        [Bindable]
        public var location:Locations;
        [Bindable]
        public var cameFrom:Locations;

        //Records which one of the decision buttons you clicked on
        /*The buttons are arranged as so on the screen
            [1][2][3]
            [4][5][6]
            [7][8][9]
            [11][12][13]*/
        //There is no button 10 so that the bottom first button ends with 1 and the second buttons ends with 2 and the third button ends with 3.
        //It's just to make them easier to remember
        public var btnchc:int = 0;

        //Perhaps most important variable in the game!////////////////////////////////////////////
        //This is why clicking on decision buttons does stuff!////////////////////////////////////
        //Every time you click a decision making button, the game records which button you clicked and then runs the "listen" function
        //You're supposed to set the listen function to take the appropriate action based on which button click the game recorded
        public var listen:Function;

        //Items handling variables

        //The arrays for your regular and key items
        [Bindable]
        public var invArray:Array = [];
        [Bindable]
        public var keyInvArray:Array = [];

        //The gold you're carrying
        [Bindable]
        public var GLD:int;

        //The array for your stored items as well as your stored gold variable
        public var storageArray:Array = [];
        public var storageGold:int;

        //What page of an inventory screen you are one
        //Used for inventory, storage, shops, possibly some other thing I forgot
        [Bindable]
        public var invPage:int = 1;

        //The maximum number of items you can hold in your inventory
        [Bindable]
        public var maxInv:int = 18;

        //Maximum amount of items you can keep in storage
        public var maxStorage:int = 36;

        //Your known spells array
        public var spellArray:Array = [];

        //The page of your spell book that you're on
        [Bindable]
        public var spellPage:int = 1;

        //NPC and vendor object slots
        //public var NPC1:NPCs = defaultNPC;
        //public var NPC2:NPCs = defaultNPC;
        //public var NPC3:NPCs = defaultNPC;
        //public var NPC4:NPCs = defaultNPC;
        public var Vendor:Vendors;

        //Temporary enemy object. This one can be editted freely because it just disappears after you use it.
        //this allows you to change it's description based on it's race or gender, or your player's race or gender, without permanently changing the original objects description
        [Bindable]
        public var enemyt:Enemies;

        //The enemy's health and mana
        [Bindable]
        public var eHEA:int;
        public var eMANA:int;

        //How much damage the enemy is going to do. Used by the doeDMG() and doeSpellDMG() functions
        public var eDMG:int;

        //Tracks how strongly your character is grappled
        public var grapple:int;

        //Tracks whether you choose to surrender or devour your enemy. Used so the enemyAttack() and
        public var surrender:Boolean = false;
        public var voreing:Boolean = false;

        //Status effects that are affecting your enemy
        public var eStatusBurnPower:int = 0;
        public var eStatusBurnTime:int = 0;
        public var eStatusStunTime:int = 0;
        public var eStatusSlowTime:int = 0;
        public var eStatusSoakTime:int = 0;

        //Statusa affects that are affecting the player
        public var pStatusStunTime:int = 0;

        //Array containing all the locations around you
        public var surroundingsArray:Array = [];

        //Random event randomization arrays
        //You can set these up however you want, but the default way I use them is; Special-Enemy-Leave-Minor
        //See the "eventRandomization" in "gameTravel.as" for more information
        public var exampleTravel:Array = [0, 0.5, 0, 2, 0, 0.5, 0, 2];

        //Options variables that are set in the options screen
        [Bindable]
        public var optionsMetric:Boolean = false;
        [Bindable]
        public var optionsImperial:Boolean = true;
        [Bindable]
        public var optionsPopping:Boolean = false;
        [Bindable]
        public var optionsMales:Boolean = true;
        [Bindable]
        public var optionsFemales:Boolean = true;
        [Bindable]
        public var optionsDescription:Boolean = true;


        //Placeholder variables///////////////

        //Used mostly to record how much an enemy is about to forcefeed you
        public var cram:int;

        //Used mostly in "for" loops
        public var i:int = 0;

        //Used to record how many attempts you have left to do a thing with a limited number of attempts
        public var attemptsLeft:int = 0;

        //Records how much damage you're about to do in combat
        [Bindable]
        public var DMG:int = 0;

        //Contains items in your inventory that you can tailor
        public var tailorArray:Array = [];

        //Records which item you have selected and are about to use
        public var selectedItem:Items;

        //Labels for the "discard/use" and "depositing/withdrawing" buttons
        [Bindable]
        public var depositLabel:String = "Depositing";
        [Bindable]
        public var discardLabel:String = "Using";

        //Functions that tell the game which of the main decision making buttons you've pressed
        /*Button order as they appear on the screen
            [1][2][3]
            [4][5][6]
            [7][8][9]
            [11][12][13]
            Note: there is no button 10*/
        public function btn2():void {
            btnchc = 2;
            listen();
        }

        public function btn3():void {
            btnchc = 3;
            listen();
        }

        public function btn4():void {
            btnchc = 4;
            listen();
        }

        public function btn5():void {
            btnchc = 5;
            listen();
        }

        public function btn6():void {
            btnchc = 6;
            listen();
        }

        public function btn7():void {
            btnchc = 7;
            listen();
        }

        public function btn8():void {
            btnchc = 8;
            listen();
        }

        public function btn9():void {
            btnchc = 9;
            listen();
        }

        public function dec1():void {
            btnchc = 11;
            listen();
        }

        public function dec2():void {
            btnchc = 12;
            listen();
        }

        public function dec3():void {
            btnchc = 13;
            listen();
        }

        //Function for the rest/level button
        public function restLvl():void {
            if (LVLup > 0) {
                doLevel();
            }
            else if (LVLup == 0) {
                doRest();
            }
        }
        //Variables for the button's text
        [Bindable]
        public var buttonLabel1:String;
        [Bindable]
        public var buttonLabel2:String;
        [Bindable]
        public var buttonLabel3:String;
        [Bindable]
        public var buttonLabel4:String;
        [Bindable]
        public var buttonLabel5:String;
        [Bindable]
        public var buttonLabel6:String;
        [Bindable]
        public var buttonLabel7:String;
        [Bindable]
        public var buttonLabel8:String;
        [Bindable]
        public var buttonLabel9:String;

        [Bindable]
        public var buttonLabeldec1:String;
        [Bindable]
        public var buttonLabeldec2:String;
        [Bindable]
        public var buttonLabeldec3:String;

        //Variables for the button's visibility
        [Bindable]
        public var buttonVisible1:Boolean;
        [Bindable]
        public var buttonVisible2:Boolean;
        [Bindable]
        public var buttonVisible3:Boolean;
        [Bindable]
        public var buttonVisible4:Boolean;
        [Bindable]
        public var buttonVisible5:Boolean;
        [Bindable]
        public var buttonVisible6:Boolean;
        [Bindable]
        public var buttonVisible7:Boolean;
        [Bindable]
        public var buttonVisible8:Boolean;
        [Bindable]
        public var buttonVisible9:Boolean;

        [Bindable]
        public var buttonVisibledec1:Boolean;
        [Bindable]
        public var buttonVisibledec2:Boolean;
        [Bindable]
        public var buttonVisibledec3:Boolean;
        private var currentState:* = null;
        private const Female:Gender = null;
        private const Male:* = null;

        //Sets the input button # to the input icons
        public function buttonIcons(buttonNumber:int, buttonIcon:Class):void {
            var decision3:* = null;
            var decision2:* = null;
            var decision1:* = null;
            var button9:* = null;
            var button8:* = null;
            var button7:* = null;
            var button6:* = null;
            var button5:* = null;
            var button4:* = null;
            var button3:* = null;
            var button2:* = null;
            var button1:* = null;
            switch (buttonNumber) {
                case 1:
                    button1.setStyle("icon", buttonIcon);
                    break;
                case 2:
                    button2.setStyle("icon", buttonIcon);
                    break;
                case 3:
                    button3.setStyle("icon", buttonIcon);
                    break;
                case 4:
                    button4.setStyle("icon", buttonIcon);
                    break;
                case 5:
                    button5.setStyle("icon", buttonIcon);
                    break;
                case 6:
                    button6.setStyle("icon", buttonIcon);
                    break;
                case 7:
                    button7.setStyle("icon", buttonIcon);
                    break;
                case 8:
                    button8.setStyle("icon", buttonIcon);
                    break;
                case 9:
                    button9.setStyle("icon", buttonIcon);
                    break;
                case 11:
                    decision1.setStyle("icon", buttonIcon);
                    break;
                case 12:
                    decision2.setStyle("icon", buttonIcon);
                    break;
                case 13:
                    decision3.setStyle("icon", buttonIcon);
                    break
            }
        }

        //Clears which button you previously chose
        //This function mainly exists to make sure the game doesn't loop through several decisions accidentally
        //I'm entirely not sure if this function even needs to exist.
        public function clrchc():void {
            btnchc = 0;
        }

        //Clears off the text on the buttons
        public function clrBtnTxt():void {
            for (i = 1; i <= 9; i++) {
                btntxt(i, "");
            }
        }

        //Writes the input text on the input button number
        public function btntxt(buttonNumber:int, buttonText:String):void {
            switch (buttonNumber) {
                case 1:
                    buttonLabel1 = buttonText;
                    buttonVisible1 = true;
                    break;
                case 2:
                    buttonLabel2 = buttonText;
                    buttonVisible2 = true;
                    break;
                case 3:
                    buttonLabel3 = buttonText;
                    buttonVisible3 = true;
                    break;
                case 4:
                    buttonLabel4 = buttonText;
                    buttonVisible4 = true;
                    break;
                case 5:
                    buttonLabel5 = buttonText;
                    buttonVisible5 = true;
                    break;
                case 6:
                    buttonLabel6 = buttonText;
                    buttonVisible6 = true;
                    break;
                case 7:
                    buttonLabel7 = buttonText;
                    buttonVisible7 = true;
                    break;
                case 8:
                    buttonLabel8 = buttonText;
                    buttonVisible8 = true;
                    break;
                case 9:
                    buttonLabel9 = buttonText;
                    buttonVisible9 = true;
                    break;
                case 11:
                    buttonLabeldec1 = buttonText;
                    buttonVisibledec1 = true;
                    break;
                case 12:
                    buttonLabeldec2 = buttonText;
                    buttonVisibledec2 = true;
                    break;
                case 13:
                    buttonLabeldec3 = buttonText;
                    buttonVisibledec3 = true;
                    break;
            }
        }

        //Changes the visibility of the miscellaneous action buttons ()rest,inventory,etc.)
        //These buttons often need to be turned off to prevent the player from getting stuck by going to a menu that overwrites the buttons
        //This is largely relevant in the middle of events
        public function appView(viewAppButtons:int):void {
            if (viewAppButtons == 1) {
                appButtonVisibility = true;
            }
            else {
                appButtonVisibility = false;
            }
        }

        //Changes the visibility of the inventory buttons
        public function invView(buttonsOn:int):void {
            var inventoryPanel:* = null;
            if (buttonsOn == 1) {
                inventoryPanel.visible = true;
            }
            else {
                inventoryPanel.visible = false;
            }
        }

        //Clears out a specific input button
        public function clearButton(ID:int):void {
            var decision3:* = null;
            var decision2:* = null;
            var decision1:* = null;
            var button9:* = null;
            var button8:* = null;
            var button7:* = null;
            var button6:* = null;
            var button5:* = null;
            var button4:* = null;
            var button3:* = null;
            var button2:* = null;
            var button1:* = null;
            switch (ID) {
                case 1:
                    buttonLabel1 = "";
                    buttonVisible1 = false;
                    button1.setStyle("icon", null);
                    break;
                case 2:
                    buttonLabel2 = "";
                    buttonVisible2 = false;
                    button2.setStyle("icon", null);
                    break;
                case 3:
                    buttonLabel3 = "";
                    buttonVisible3 = false;
                    button3.setStyle("icon", null);
                    break;
                case 4:
                    buttonLabel4 = "";
                    buttonVisible4 = false;
                    button4.setStyle("icon", null);
                    break;
                case 5:
                    buttonLabel5 = "";
                    buttonVisible5 = false;
                    button5.setStyle("icon", null);
                    break;
                case 6:
                    buttonLabel6 = "";
                    buttonVisible6 = false;
                    button6.setStyle("icon", null);
                    break;
                case 7:
                    buttonLabel7 = "";
                    buttonVisible7 = false;
                    button7.setStyle("icon", null);
                    break;
                case 8:
                    buttonLabel8 = "";
                    buttonVisible8 = false;
                    button8.setStyle("icon", null);
                    break;
                case 9:
                    buttonLabel9 = "";
                    buttonVisible9 = false;
                    button9.setStyle("icon", null);
                    break;
                case 11:
                    buttonLabeldec1 = "";
                    buttonVisibledec1 = false;
                    decision1.setStyle("icon", null);
                    break;
                case 12:
                    buttonLabeldec2 = "";
                    buttonVisibledec2 = false;
                    decision2.setStyle("icon", null);
                    break;
                case 13:
                    buttonLabeldec3 = "";
                    buttonVisibledec3 = false;
                    decision3.setStyle("icon", null);
                    break;
            }
        }

        //Clears all 9 actions buttons
        public function clearTextView():void {
            buttonVisible1 = false;
            buttonVisible2 = false;
            buttonVisible3 = false;
            buttonVisible4 = false;
            buttonVisible5 = false;
            buttonVisible6 = false;
            buttonVisible7 = false;
            buttonVisible8 = false;
            buttonVisible9 = false;
            var button1:* = null;
            button1.setStyle("icon", null);
            var button2:* = null;
            button2.setStyle("icon", null);
            var button3:* = null;
            button3.setStyle("icon", null);
            var button4:* = null;
            button4.setStyle("icon", null);
            var button5:* = null;
            button5.setStyle("icon", null);
            var button6:* = null;
            button6.setStyle("icon", null);
            var button7:* = null;
            button7.setStyle("icon", null);
            var button8:* = null;
            button8.setStyle("icon", null);
            var button9:* = null;
            button9.setStyle("icon", null);
        }

        //Clears all 3 decision buttons
        public function clearDecisionView():void {
            buttonVisibledec1 = false;
            buttonVisibledec2 = false;
            buttonVisibledec3 = false;
            var decision1:* = null;
            decision1.setStyle("icon", null);
            var decision2:* = null;
            decision2.setStyle("icon", null);
            var decision3:* = null;
            decision3.setStyle("icon", null);
        }

        //clears all buttons and the decision variable
        public function clearView():void {
            clearTextView();
            clearDecisionView();
            clrchc();
        }

        //Displays "Next" button
        public function nextView():void {
            clearView();
            appView(0);
            btntxt(12, "Next");
        }

        //Displays next button and sets the default "Next" function
        public function nextButton():void {
            nextView();
            listen = function ():void {
                if (btnchc == 12) {
                    doNext(null);
                }
            }
        }

        //Displays "Yes" button on the input button #
        public function yesView(ID:int):void {
            btntxt(ID, "Yes");
        }

        //Displays "No" button on the input button #
        public function noView(ID:int):void {
            btntxt(ID, "No");
        }

        //Displays Yes/No buttons
        public function choiceButton():void {
            clearView();
            appView(0);
            yesView(11);
            noView(13);
        }

        //Displays return button on the input button #
        public function returnView(ID:int):void {
            btntxt(ID, "Return");
        }

        //Displays "Up" button for inventory/spell pages
        public function upView():void {
            btntxt(11, "Page up");
        }

        //Displays "Down" button for inventory/spell pages
        public function downView():void {
            btntxt(13, "Page down");
        }

        //Displays "Up"/"Down" button
        public function pageView():void {
            upView();
            downView();
        }

        //Sets a "leave" button to the input button #
        public function leaveButton(buttonNumber:int):void {
            btntxt(buttonNumber, "Leave");
        }

        //Sets a "Buy" button to the input button #
        public function tradeButton(buttonNumber:int):void {
            btntxt(buttonNumber, "Trade");
        }

        //The default function for the "Next" button for general purpose use
        override protected function doNext(eventNo:Function):void {
            switch (currentState) {
                case "inventory":
                    doInventory();
                    break;
                case "combat":
                    doBattle();
                    break;
                case "default":
                    general();
                    break;
                case "defeated":
                    doDefeat();
                    break;
            }
        }

        //Leaves the various other states and returns to the default state in a way that prevents errors
        public function leaveMisc():void {
            var YourHouse:Locations = null;
            switch (currentState) {
                case "combatInventory":
                    currentState = "combat";
                    doBattle();
                    break;
                case "storage":
                    doEvent(YourHouse);
                    depositing = true;
                    depositLabel = "Depositing";
                    currentState = "default";
                    break;
                case "inventory":
                    general();
                    discarding = false;
                    keyItems = false;
                    discardLabel = "Using";
                    currentState = "default";
                    break;
                case "spells":
                    general();
                    currentState = "default";
                    break;
                case "combatSpells":
                    currentState = "combat";
                    doBattle();
                    break;
                case "options":
                    currentState = "default";
                    if (newGame == true) {
                        introduction();
                    }
                    else {
                        if (location == YourHouse) {
                            specialEvent = 1;
                            subEvent = "";
                            locationUpdate(YourHouse);
                            doEvent(YourHouse);
                        }
                        else {
                            general();
                        }
                    }
                    break;
                default:
                    currentState = "default";
                    break;
            }
            invPage = 1;
        }

        //Displays the instructions for the game
        public function instructions():void {
            currentState = "appearance";

            miscScene("\tThis space intentionally left blank. ", true);
        }

        /*        //Displays the credits for the game
                override protected function credits():void {
                    scene("\nCoding by Noone ", true);
                    clearView();
                    returnView(8);
                    listen = function ():void {
                        if (btnchc == 8) {
                            introduction();
                        }
                    }
                }*/

        //Displays the games introduction and sets up the introductory buttons
        public function introduction():void {

            //Sets the game's scaling so that it updates when you resize the window
            //I'm almost certainly doing this the wrong way
            //this.stage.scaleMode = StageScaleMode.SHOW_ALL;

            //Moves you to the starting location of the game
            var exampleCenter:Locations = null;
            location = exampleCenter;

            //Displays your games intro
            scene("\tThis space intentionally left blank. ", true);

            clearView();
            btntxt(1, "New Game");
            btntxt(2, "Load");
            btntxt(3, "Instructions");
            btntxt(8, "Credits");

            listen = function ():void {
                switch (btnchc) {
                    case 1:
                        selectSpecies();
                        break;
                    case 2:
                        tryLoad();
                        break;
                    case 3:
                        instructions();
                        break;
                    case 8:
                        //credits();
                        break;
                }
            }
        }

        //Selects which family of species you want to be
        public function selectSpecies():void {
            //Sets base stats
            bSTR = 15;
            bAGI = 15;
            bINT = 15;
            bEND = 15;
            bSTO = 20;
            Drank = 2;
            Eaten = 2;
            maxFUL = 130;
            bmaxHEA = 100;
            HEA = maxHEA;
            STA = 100;
            FAT = 5;
            Calories = 10;
            GLD = 30;

            //Sets base equipment
            var Weaponless:* = null;
            WEA = ObjectUtil.copy(Weaponless) as Items;
            var Armorless:* = null;
            ARM = ObjectUtil.copy(Armorless) as Items;
            var Shirtless:* = null;
            TOP = ObjectUtil.copy(Shirtless) as Items;
            var Pantsless:* = null;
            BTM = ObjectUtil.copy(Pantsless) as Items;

            updateStats();

            scene("Please select your race... ", true);

            //Displays relevant UI panel
            var speciesDropDown:* = true;

            nextButton();
            btntxt(11, "Custom Species");

            listen = function ():void {
                var speciesDropDown:* = null;
                if (btnchc == 12 && speciesDropDown.selectedIndex != -1) {
                    //Makes the player into the species selected from the drop down menu
                    var speciesID:Species = speciesDropDown.selectedItem.type;
                    playerSpecies = ObjectUtil.copy(speciesID) as Species;
                    playerHeight = speciesID.baseHeight;
                    chgStats(playerSpecies.statChange[0], playerSpecies.statChange[1], playerSpecies.statChange[2], playerSpecies.statChange[3], playerSpecies.statChange[4]);
                    FAT += playerSpecies.statChange[5];
                    //selectGender();
                }
                if (btnchc == 11) {
                    currentState = "customSpecies";
                }
            }
        }

//Moves you to the correct custom species screen based on wether you're starting a new character or using the cabal
        public function customSpeciesBack():void {
            currentState = "default";
            selectSpecies();
        }

        //Displays the selected species stats/description
        public function displaySpeciesStats():void {
            if (newGame) {
                var speciesDropDown:* = null;
                var tempSpecies:Species = speciesDropDown.selectedItem.type;
                scene("<b>" + capFirst(tempSpecies.speciesName) + "</b>" +
                        "\n~~~~~~~~~~~~~~~~~~~~~~\n", true);
                for (i = 0; i <= 5; i++) {
                    var tempStat:int = tempSpecies.statChange[i];
                    if (tempStat > 0) {
                        scene("<li>", false);
                        switch (i) {
                            case 0:
                                scene("Strength: +", false);
                                break;
                            case 1:
                                scene("Agility: +", false);
                                break;
                            case 2:
                                scene("Endurance: +", false);
                                break;
                            case 3:
                                scene("Intelligence: +", false);
                                break;
                            case 4:
                                scene("Starting Stomach capacity: +", false);
                                break;
                            case 5:
                                scene("Starting fatness: +", false);
                                break;
                        }
                        scene(tempStat + "</li>", false);
                    }
                }
                scene("<li>Starting height: " + (Math.floor(tempSpecies.baseHeight / 12)) + "'" + (tempSpecies.baseHeight % 12) + "\" (" + Math.floor(tempSpecies.baseHeight * 2.54) + " centimeters)</li>", false);
            }
        }


        /*//Makes your character the selected gender
        public function selectGender():void {
            scene("Are you male or female? ", true);
            clearView();
            var speciesDropDown:* = false;
            btntxt(1, "Male");
            btntxt(3, "Female");
            btntxt(13, "Back");
            listen = function ():void {
                var genderID:Gender;
                switch (btnchc) {
                    case 1:
                        if (playerSpecies.mName != null) {
                            playerSpecies.name = playerSpecies.mName;
                        }
                        else {
                            playerSpecies.name = playerSpecies.speciesName;
                        }
                        genderID = Male;
                        playerGender = ObjectUtil.copy(genderID) as Gender;
                        selectName();
                        break;
                    case 3:
                        if (playerSpecies.fName != null) {
                            playerSpecies.name = playerSpecies.fName;
                        }
                        else {
                            playerSpecies.name = playerSpecies.speciesName;
                        }
                        genderID = Female;
                        playerGender = ObjectUtil.copy(genderID) as Gender;
                        selectName();
                        break;
                    case 13:
                        selectSpecies();
                        break;
                }
            }
        }*/


        //Allows the player to input their name
        public function selectName():void {
            scene("What is your name? ", true);
            var nameInput:* = true;
            nameInput.text = "Hero";
            nameInput.setFocus();
            nameInput.selectAll();
            clearView();

            nextView();
            btntxt(13, "Back");

            listen = function ():void {
                var nameInput:* = null;
                if (nameInput.text != "" && btnchc == 12) {
                    playerName = nameInput.text;
                    startNewGame();
                }
                if (btnchc == 13) {
                    clrchc();
                    nameInput.visible = false;
                    //selectGender();
                }
            }
        }

        //Makes sure all the flags and whatnot are appropriatel set up for when you start a new game
        public function startNewGame():void {
            doXP(0);
            doTime(0);
            var nameInput:* = false;
            //common.visible = true;
            newGame = false;
            general();
            var YourHouse:Locations = null;
            locationTravel(YourHouse);
            scene("The inroductory scene for starting a new game would go here. ", true);
        }

        //Display stuff//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////Display stuff//

        //Displays input text as a scene and either overwrites what was already there based on the input boolean
        public function scene(texts:String, reset:Boolean):void {
            if (reset == false) {
                mainText = mainText + texts;
            }
            else {
                mainText = texts;
                //Scrolls to the top of the page
                //eventText.verticalScrollPosition = 0;
            }
        }

        //Works as the scene function except for miscellaneous scenes (player description, surroundings description, etc.)
        //These functions are split up so that you can go back and forth between two different states without overwriting text on the default screen
        public function miscScene(texts:String, reset:Boolean):void {
            if (reset == false) {
                miscellaneousText = miscellaneousText + texts;
            }
            else {
                miscellaneousText = texts;
            }
        }

        //Returns the input string with the first letter capitalized
        public function capFirst(stringID:String):String {
            return stringID.charAt(0).toUpperCase() + stringID.substr(1).toLowerCase();
        }

        //Sets up the general display for when the player is just traveling around normally
        public function general():void {
            appView(1);
            clearView();
            //removeArrows();
            rmvTempStats();
            updateStats();
            if (LVLup > 0) {
                //restLvlBtn.label = "Level Up!";
            }
            if (LVLup == 0) {
                //restLvlBtn.label = "Rest";
            }
            explore();
        }

        //Changes fat level by input amount and displays the relevant stat change arrow
        public function doFat(fattened:Number):void {
            FAT += fattened;
            if (FAT < 0) {
                FAT = 0;
            }
            if (fattened > 0) {
                ////doArrow("FATup");
            }
            if (fattened < 0) {
                ////doArrow("FATdown");
            }
        }

        //Changes stats by input amount
        public function chgStats(strength:Number, speed:Number, endurance:Number, intelligence:Number, stomach:Number):void {
            //Removes old arrows
            //removeArrows();

            //Adds new arrows based on wether went up or down or neither
            if (strength > 0) {
                //doArrow("STRup");
            }
            if (speed > 0) {
                //doArrow("SPDup");
            }
            if (endurance > 0) {
                //doArrow("ENDup");
            }
            if (intelligence > 0) {
                //doArrow("INTup");
            }
            if (stomach < 0) {
                //doArrow("FULup");
            }
            if (strength < 0) {
                //doArrow("STRdown");
            }
            if (speed < 0) {
                //doArrow("SPDdown");
            }
            if (endurance < 0) {
                //doArrow("ENDdown");
            }
            if (intelligence < 0) {
                //doArrow("INTdown");
            }
            if (stomach > 0) {
                //doArrow("FULdown");
            }

            //Stat increases for when the stat is below 100
            if (bSTR < 100) {
                bSTR += strength;
            }
            if (bAGI < 100) {
                bAGI += speed;
            }
            if (bEND < 100) {
                bEND += endurance;
            }
            if (bINT < 100) {
                bINT += intelligence;
            }
            if (bSTO < 200) {
                bSTO += stomach;
            }

            //Stat increases for when a stat is over 100 and thus incurs diminishing returns
            if (bSTR >= 100) {
                bSTR += strength / (bSTR * .01);
            }
            if (bAGI >= 100) {
                bAGI += speed / (bAGI * .01);
            }
            if (bEND >= 100) {
                bEND += endurance / (bEND * .01);
            }
            if (bINT >= 100) {
                bINT += intelligence / (bINT * .01);
            }
            if (bSTO >= 200) {
                bSTO += stomach / (bSTO * .005);
            }

            updateStats();
        }

        //Changes input temporary stat by input amount
        public function chgTempStats(debuffType:String, debuffAmount:Number):void {

            //Debuffs character
            switch (debuffType) {
                case "AGI":
                    tenemyAGIdebuff -= debuffAmount;
                    break;
                case "END":
                    tenemyENDdebuff -= debuffAmount;
                    break;
                case "INT":
                    tenemyINTdebuff -= debuffAmount;
                    break;
                case "STO":
                    tenemySTOdebuff -= debuffAmount;
                    break;
                case "STR":
                    tenemySTRdebuff -= debuffAmount;
                    break;
                case "stun":
                    pStatusStunTime += debuffAmount;
                    break;
                case "burn":
                    statusBurnPower += debuffAmount;
                    break;
                case "fat":
                    tenemyFATdebuff += debuffAmount;
                    break;
                default:
                    debuffType = "debuff error";
                    break;
            }

            //Displays status change message
            if (inCombat()) {
                scene("\n\t<i>(", false);
                switch (debuffType) {
                    case "stun":
                        scene("You've been stunned!", false);
                        break;
                    case "poison":
                        scene("You've been poisoned!", false);
                        break;
                    case "burn":
                        scene("You're burning!", false);
                        break;
                    case "fat":
                        scene(debuffType, false);
                        if (debuffAmount > 0) {
                            scene(" +" + debuffAmount, false);
                        }
                        if (debuffAmount < 0) {
                            scene(" " + -debuffAmount, false);
                        }
                        break;
                    default:
                        scene(debuffType, false);
                        if (debuffAmount > 0) {
                            scene(" -" + debuffAmount, false);
                        }
                        if (debuffAmount < 0) {
                            scene(" +" + -debuffAmount, false);
                        }
                        break;
                }
                scene(")</i> ", false);
            }

            updateStats();
        }

        //Removes temporary combat stats, usually used whenever combat ends
        public function rmvTempStats():void {
            tenemySTRdebuff = 0;
            tenemyAGIdebuff = 0;
            tenemyINTdebuff = 0;
            tenemyENDdebuff = 0;
            tenemySTOdebuff = 0;
            tenemyFATdebuff = 0;

            tmagicSTRbuff = 0;
            tmagicAGIbuff = 0;
            tmagicINTbuff = 0;
            tmagicENDbuff = 0;
            tmagicSTObuff = 0;
            tmagicDEFbuff = 0;
            tmagicREGENbuff = 0;
            tmagicREGENbuffDamage = 0;
            tmagicREGENbuffRange = 0;
            tmagicDODGEbuff = 0;

            pStatusStunTime = 0;
        }

        //Removes temporary buffs/debuffs, usually from dying
        public function rmvTempBuffs():void {
            statusBloatVenomPower = 0;
            statusBloatVenom = 0;

            statusWellFedPower = 0;
            statusWellFed = 0;

            statusSTRBuff = 0;
            statusSTRBuffPower = 0;

            statusAGIBuff = 0;
            statusAGIBuffPower = 0;

            statusINTBuff = 0;
            statusINTBuffPower = 0;

            statusENDBuff = 0;
            statusENDBuffPower = 0;

            statusMANABuff = 0;
            statusMANABuffPower = 0;

            statusSTOBuff = 0;
            statusSTOBuffPower = 0;

            statusBurn = 0;
            statusBurnPower = 0;

            updateStats();
        }

        //Returns modified base stats
        public function modStrength():int {
            var modStrength:Number = 0;
            modStrength += statusWellFedPower;
            modStrength += statusSTRBuffPower;
            modStrength += WEA.strBuff;
            modStrength += ARM.strBuff;
            return modStrength;
        }

        public function modSpeed():int {
            var modSpeed:Number = 0;
            modSpeed += statusWellFedPower;
            modSpeed += statusAGIBuffPower;
            modSpeed += WEA.agiBuff;
            modSpeed += ARM.agiBuff;
            return modSpeed;
        }

        public function modEndurance():int {
            var modEndurance:Number = 0;
            modEndurance += statusWellFedPower;
            modEndurance += statusENDBuffPower;
            modEndurance += WEA.endBuff;
            modEndurance += ARM.endBuff;
            return modEndurance;
        }

        public function modIntelligence():int {
            var modIntelligence:Number = 0;
            modIntelligence += statusWellFedPower;
            modIntelligence += statusINTBuffPower;
            modIntelligence += WEA.intBuff;
            modIntelligence += ARM.intBuff;
            return modIntelligence;
        }

        public function modStomach():int {
            var modStomach:Number = 0;
            modStomach += statusSTOBuffPower;
            return modStomach;
        }

        public function modMana():int {
            var modMana:Number = 0;
            modMana += statusMANABuffPower;
            modMana += WEA.manaBuff;
            modMana += ARM.manaBuff;
            return modMana;
        }

        public function modHealth():int {
            var modHealth:Number = 0;
            modHealth += WEA.healthBuff;
            modHealth += ARM.healthBuff;
            return modHealth;
        }

        //Returns temporary combat stat changes
        public function tempStrength():int {
            var tempStrength:Number = 0;
            tempStrength += tenemySTRdebuff;
            tempStrength += tmagicSTRbuff;
            return tempStrength;
        }

        public function tempSpeed():int {
            var tempSpeed:Number = 0;
            tempSpeed += tenemyAGIdebuff;
            tempSpeed += tmagicAGIbuff;
            return tempSpeed;
        }

        public function tempEndurance():int {
            var tempEndurance:Number = 0;
            tempEndurance += tenemyENDdebuff;
            tempEndurance += tmagicENDbuff;
            return tempEndurance;
        }

        public function tempIntelligence():int {
            var tempIntelligence:Number = 0;
            tempIntelligence += tenemyINTdebuff;
            tempIntelligence += tmagicINTbuff;
            return tempIntelligence;
        }

        public function tempStomach():int {
            var tempStomach:Number = 0;
            tempStomach += tenemySTOdebuff;
            tempStomach += tmagicSTObuff;
            return tempStomach;
        }

        //Increases/decreases health and makes sure it's within bounds
        public function doHealth(ID:int):void {
            HEA += ID;

            if (inCombat()) {
                if (ID > 0) {
                    scene("\n\t<i>(Health +" + ID + ")</i>", false);
                }
                if (ID < 0) {
                    scene("\n\t<i>(Health " + ID + ")</i>", false);
                }
            }

            if (ID > 0) {
                //doArrow("HEAup");
            }
            if (ID < 0) {
                //doArrow("HEAdown");
            }

            //prevents health from going over your maximum HP or below 0
            if (HEA > maxHEA) {
                HEA = maxHEA;
            }
            if (HEA < 0) {
                HEA = 0;
            }

            //Updates health bar collor
            var healthBar:* = null;
            if (HEA / bmaxHEA <= 2 / 3) {
                healthBar.fill = new SolidColor(0xff9900, 1);
            }
            if (HEA / bmaxHEA <= 1 / 3) {
                healthBar.fill = new SolidColor(0x550000, 1);
            }
            if (HEA / bmaxHEA > 2 / 3) {
                healthBar.fill = new SolidColor(0x005500, 1);
            }

            //Updates health bar size
            if (bmaxHEA > 0) {
                HEAbarScale = HEA / bmaxHEA;
            }
            if (bmaxHEA <= 0) {
                HEAbarScale = 0;
            }
        }

        //Increases/decreases enemy health, makes sure they don't go over their max health, and displays a status message
        public function doEnemyHealth(ID:int):void {

            //Prevents enemy from being healed for more health than they're missing
            if (eHEA + ID > enemyt.maxHEA) {
                ID = enemyt.maxHEA - eHEA;
            }

            eHEA += ID;

            if (ID > 0) {
                scene("\n\t<i>(Enemy health +" + ID + ")</i>", false);
            }
            if (ID < 0) {
                scene("\n\t<i>(Enemy health " + ID + ")</i>", false);
            }

            //Prevents enemy health from going above it's maximum HP or below 0
            if (eHEA > enemyt.maxHEA) {
                eHEA = enemyt.maxHEA;
            }
            if (eHEA < 0) {
                eHEA = 0;
            }
        }

        //Increases/decreases mana and makes sure it's within bounds
        public function doMana(ID:Number):void {
            MANA += ID;

            if (ID > 0) {
                //doArrow("MANAup");
            }
            if (ID < 0) {
                //doArrow("MANAdown");
            }

            //Prevents mana from going over maximum mana or below 0
            if (MANA > maxMANA) {
                MANA = maxMANA;
            }
            if (MANA < 0) {
                MANA = 0;
            }
        }

        //Updates stats
        public function updateStats():void {
            //Sets your stats based on their base level +/- all relevant modifiers
            STR = bSTR + tempStrength() + modStrength();
            AGI = bAGI + tempSpeed() + modSpeed();
            END = bEND + tempEndurance() + modEndurance();
            INT = bINT + tempIntelligence() + modIntelligence();
            STO = bSTO + tempStomach() + modStomach();
            maxMANA = (bINT * 0.5) + tmaxMANA + modMana();

            //Updates size of the mana bar
            if (maxMANA > 0) {
                MANAbarScale = MANA / maxMANA;
            }
            if (maxMANA <= 0) {
                MANAbarScale = 0;
            }

            //Prevents any stats from going negative
            if (STR < 0) {
                STR = 0;
            }
            if (AGI < 0) {
                AGI = 0;
            }
            if (END < 0) {
                END = 0;
            }
            if (INT < 0) {
                INT = 0;
            }
            if (STO < 0) {
                STO = 0;
            }
            if (maxMANA < 0) {
                maxMANA = 0;
            }

            //Updates how full the player should be
            fixFull();

            if (FUL > 100) {
                //Reduces health when over 100% full
                tmaxHEA = ((maxFUL - FUL) / (maxFUL - 100)) * (bmaxHEA + modHealth());
                if (tmaxHEA < 0) {
                    tmaxHEA = 0
                }
                maxHEA = tmaxHEA;

                //Updates bar coloring and size
                //fullnessBar.fill = new SolidColor(0xff9900, 1);
                if (FUL > 120) {
                    //fullnessBar.fill = new SolidColor(0x550000, 1);
                }

                //updates fullnes bar size
                FULbarScale = 1;
            }
            if (FUL <= 100) {
                maxHEA = bmaxHEA + modHealth();

                //Updates bar coloring
                //fullnessBar.fill = new SolidColor(0x005500, 1);

                //updates fullness bar size
                FULbarScale = FUL / 100;
            }

            //Updates stat bar colors based on whether they're above/below/at their default value
            if (STR < bSTR) {
                strColor = uint(0x550000);
            }
            if (AGI < bAGI) {
                agiColor = uint(0x550000);
            }
            if (END < bEND) {
                endColor = uint(0x550000);
            }
            if (INT < bINT) {
                intColor = uint(0x550000);
            }
            if (STO < bSTO) {
                stoColor = uint(0x550000);
            }
            if (maxHEA < bmaxHEA) {
                healthColor = uint(0x550000);
            }
            if (maxMANA < int(bINT * 0.5)) {
                manaColor = uint(0x550000);
            }

            if (STR > bSTR) {
                strColor = uint(0x005500);
            }
            if (AGI > bAGI) {
                agiColor = uint(0x005500);
            }
            if (END > bEND) {
                endColor = uint(0x005500);
            }
            if (INT > bINT) {
                intColor = uint(0x005500);
            }
            if (STO > bSTO) {
                stoColor = uint(0x005500);
            }
            if (maxHEA > bmaxHEA) {
                healthColor = uint(0x005500);
            }
            if (maxMANA > int(bINT * 0.5)) {
                manaColor = uint(0x005500);
            }

            if (STR == bSTR) {
                strColor = uint(0x000000);
            }
            if (AGI == bAGI) {
                agiColor = uint(0x000000);
            }
            if (END == bEND) {
                endColor = uint(0x000000);
            }
            if (INT == bINT) {
                intColor = uint(0x000000);
            }
            if (STO == bSTO) {
                stoColor = uint(0x000000);
            }
            if (maxHEA == bmaxHEA) {
                healthColor = uint(0x000000);
            }
            if (maxMANA == int(bINT * 0.5)) {
                manaColor = uint(0x000000);
            }

            //Prevents stats from going out of bounds
            if (GLD < 0) {
                GLD = 0;
            }
            if (HEA > maxHEA) {
                HEA = maxHEA;
            }
            if (HEA < 0) {
                HEA = 0;
            }
            if (MANA > maxMANA) {
                MANA = maxMANA;
            }
            if (MANA < 0) {
                MANA = 0;
            }
            if (STA > 100) {
                STA = 100;
            }
            if (STA < 0) {
                STA = 0;
            }

            //Updates health bar color
            var healthBar:* = null;
            if (HEA / bmaxHEA <= 2 / 3) {
                healthBar.fill = new SolidColor(0xff9900, 1);
            }
            if (HEA / bmaxHEA <= 1 / 3) {
                healthBar.fill = new SolidColor(0x550000, 1);
            }
            if (HEA / bmaxHEA > 2 / 3) {
                healthBar.fill = new SolidColor(0x005500, 1);
            }

            //Updates health bar size
            if (bmaxHEA > 0) {
                HEAbarScale = HEA / bmaxHEA;
            }
            if (bmaxHEA <= 0) {
                HEAbarScale = 0;
            }

        }

        //Recalculates how full you should be
        public function fixFull():void {
            ATE = Eaten + Drank + Inflated;
            FUL = (ATE / STO) * 100;

            //Tests whether you clothes should pop off or not and displays the relevant descriptions
            if (waistDiameter() > TOP.Expand && TOP.Popped == false && TOP.Expand > 0) {
                scene("<i>" + TOP.Popoff + "</i>", false);
                TOP.Popped = true;
            }
            if (waistDiameter() > BTM.Expand && BTM.Popped == false && BTM.Expand > 0) {
                scene("<i>" + BTM.Popoff + "</i>", false);
                BTM.Popped = true;
            }
        }

        //Removes up and down arrows

        //Displays arrows based on input

        //Returns a random number between 1-100
        public function d100():int {
            return Math.floor(Math.random() * (100)) + 1;
        }

        //Rolls x amount of y-sided dice and returns their total
        public function xdy(amount:int, size:int):int {
            var rolled:int;
            for (i = 1; i <= amount; i++) {
                rolled += dXY(1, size);
            }
            return rolled;
        }

        //Returns a random number between the first and second number inclusive.
        public function dXY(low:int, high:int):int {
            var diceRoll:int = low;

            //Only rolls if the "high" input is actually higher than the "low" input
            if (high > low) {
                diceRoll = Math.floor(Math.random() * (1 + high - low)) + low;
            }

            //Prevents dice roll from being higher than the input maximum. Probably not necessary
            if (diceRoll > high) {
                diceRoll = high;
            }

            return diceRoll;
        }

        //Returns a random race. There's a 50/50 shot of it being an herbivore or a carnivore
        public function randomSpecies():Species {
            var tempSpecies:Species = randomHerbivore();
            if (dXY(1, 2) == 1) {
                tempSpecies = randomCarnivore();
            }
            return tempSpecies;
        }

        //Returns a random carnivore
        public function randomCarnivore():Species {
            var carnivoreArray:Array = [];
            //These are where the different groups of carnivores go
            switch (dXY(1, 4)) {
                case 1:
                    carnivoreArray = [];
                    break;
                case 2:
                    carnivoreArray = [];
                    break;
                case 3:
                    carnivoreArray = [];
                    break;
                default:
                    carnivoreArray = [];
                    break;
            }
            return carnivoreArray[dXY(0, carnivoreArray.length - 1)];
        }

        //Returns a random herbivore
        public function randomHerbivore():Species {
            var herbivoreArray:Array = [];
            //This is where the different groups of herbivores go
            switch (dXY(1, 2)) {
                case 1:
                    herbivoreArray = [];
                    break;
                default:
                    herbivoreArray = [];
                    break;
            }
            return herbivoreArray[dXY(0, herbivoreArray.length - 1)];
        }

        //Returns a random gender
        public function randomGender():Gender {
            var returnGender:Gender = Male;
            if (optionsMales == optionsFemales) {
                if (dXY(1, 2) == 1) {
                    returnGender = Female;
                }
            }
            if (optionsMales != optionsFemales) {
                if (optionsFemales) {
                    returnGender = Female;
                }
            }
            return returnGender;
        }

        //Creates a specific NPC in the input slot of the input species and input gender. You can have 4 different random NPCs concurrently, otherwise you should just write over old NPCs
        public function createNPC(ID:int, IDspecies:Species, IDgender:Gender):void {
            var defaultNPC:* = null;
            var outputNPC:NPCs = ObjectUtil.copy(defaultNPC) as NPCs;

            //Sets the NPCs species and gender
            outputNPC.species = ObjectUtil.copy(IDspecies) as Species;
            outputNPC.gender = ObjectUtil.copy(IDgender) as Gender;

            //Properly sets the NPCs species name based on gender I.E. "lion" vs "lioness" etc.
            switch (IDgender) {
                case Male:
                    if (IDspecies.mName != null) {
                        outputNPC.species.name = IDspecies.mName;
                    }
                    else {
                        outputNPC.species.name = IDspecies.speciesName;
                    }
                    break;
                default:
                    if (IDspecies.fName != null) {
                        outputNPC.species.name = IDspecies.fName;
                    }
                    else {
                        outputNPC.species.name = IDspecies.speciesName;
                    }
                    break;
            }
        }

        //Generates an npc of random race and gender to the input slot
        public function randomNPC(ID:int):void {
            createNPC(ID, randomSpecies(), randomGender());
        }

        //Creates the temporary version of the enemy based on the input enemy
        //The purpose of this is so you can edit the object's characteristics without changing the original object
        public function setEnemy(ID:Enemies):void {

            //enemy = ID;
            enemyt = ObjectUtil.copy(ID) as Enemies;

            //Sets the enemy portrait if it has one
            if (ID.image != null) {
                enemyImageSource = ID.image;
            }

            //Sets the enemy species randomly if the species isn't set already
            if (ID.species == null) {
                randomEnemyRace("any");
            }
            var Neutral:* = null;
            switch (ID.gender) {
                case Male:
                    setEnemyGender(Male);
                    break;
                case Female:
                    setEnemyGender(Female);
                    break;
                case Neutral:
                    setEnemyGender(Neutral);
                    break;
                default:
                    setEnemyGender(randomGender());
                    break;
            }

            //Updates enemy descriptions to the most current characteristics based on species gender/species etc.
            enemyt.name = ObjectUtil.copy(ID.name) as String;
            enemyt.victory = ObjectUtil.copy(ID.victory) as String;
            enemyt.description = ObjectUtil.copy(ID.description) as String;
            enemyt.introduction = ObjectUtil.copy(ID.introduction) as String;
            enemyt.defeat = ObjectUtil.copy(ID.defeat) as String;
            enemyt.playerEscape = ObjectUtil.copy(ID.playerEscape) as String;
            enemyt.playerEscapeFail = ObjectUtil.copy(ID.playerEscapeFail) as String;
            enemyt.grappleEscapeFail = ObjectUtil.copy(ID.grappleEscapeFail) as String;
            enemyt.grappleEscapeSucceed = ObjectUtil.copy(ID.grappleEscapeSucceed) as String;
            enemyt.itemFound = ObjectUtil.copy(ID.itemFound) as String;

        }

        //Sets an ememy's race at random based on what it eats
        public function randomEnemyRace(eater:String):void {
            var tempSpecies:Species;
            switch (eater) {
                case "carnivore":
                    tempSpecies = randomCarnivore();
                    break;
                case "herbivore":
                    tempSpecies = randomHerbivore();
                    break;
                default:
                    tempSpecies = randomSpecies();
                    break;
            }
            enemyt.species = ObjectUtil.copy(tempSpecies) as Species;
        }

        //Sets the enemy's gender to the input gender
        public function setEnemyGender(ID:Gender):void {
            enemyt.gender = ObjectUtil.copy(ID) as Gender;

            switch (ID) {
                case Male:
                    if (enemyt.species.mName != null) {
                        enemyt.species.name = enemyt.species.mName;
                    }
                    else {
                        enemyt.species.name = enemyt.species.speciesName;
                    }
                    break;
                case Female:
                    if (enemyt.species.fName != null) {
                        enemyt.species.name = enemyt.species.fName;
                    }
                    else {
                        enemyt.species.name = enemyt.species.speciesName;
                    }
                    break;
            }
        }

        //Creates a backup of the input array. Useful for how flash stores temporary information
        /*Flash stores information in certain areas of your computer memory, and if you change one thing and another thing is stored in that same spot,
        such as the weapon you're equipped with and the weapon the save slot says you're equipped with, then both end up changed if one of them changes.
        This is what caused a lot of the inventory glitches related to loading saves. */

        //This is very confusing, and I can't explain it very well, but there you go
        public function backupArray(savingArray:Array):Array {
            var arrayBackup:Array = [];
            if (savingArray != null) {
                for (i = 0; i < savingArray.length; i++) {
                    arrayBackup.push(savingArray[i]);
                }
            }
            return arrayBackup;
            arrayBackup = [];
        }

        //Displays dialogue for saving
        public function trySave():void {

            //Pulls up the saved game object from the players computer
            var saveGame:SharedObject = SharedObject.getLocal("fattyStripped");

            clearView();
            clrBtnTxt();
            returnView(12);

            //Displays saved game information to the buttons if a saved game exists in that slot
            if (saveGame.data.saveGame1) {
                btntxt(1, "1 " + saveGame.data.saveGame1["name"] + " Day:" + saveGame.data.saveGame1["day"] + "," + saveGame.data.saveGame1["display hour"] + ":" + saveGame.data.saveGame1["tens minute"] + int(saveGame.data.saveGame1["ones minute"]));
            }
            if (saveGame.data.saveGame2) {
                btntxt(2, "2 " + saveGame.data.saveGame2["name"] + " Day:" + saveGame.data.saveGame2["day"] + "," + saveGame.data.saveGame2["display hour"] + ":" + saveGame.data.saveGame2["tens minute"] + int(saveGame.data.saveGame2["ones minute"]));
            }
            if (saveGame.data.saveGame3) {
                btntxt(3, "3 " + saveGame.data.saveGame3["name"] + " Day:" + saveGame.data.saveGame3["day"] + "," + saveGame.data.saveGame3["display hour"] + ":" + saveGame.data.saveGame3["tens minute"] + int(saveGame.data.saveGame3["ones minute"]));
            }
            if (saveGame.data.saveGame4) {
                btntxt(4, "4 " + saveGame.data.saveGame4["name"] + " Day:" + saveGame.data.saveGame4["day"] + "," + saveGame.data.saveGame4["display hour"] + ":" + saveGame.data.saveGame4["tens minute"] + int(saveGame.data.saveGame4["ones minute"]));
            }
            if (saveGame.data.saveGame5) {
                btntxt(5, "5 " + saveGame.data.saveGame5["name"] + " Day:" + saveGame.data.saveGame5["day"] + "," + saveGame.data.saveGame5["display hour"] + ":" + saveGame.data.saveGame5["tens minute"] + int(saveGame.data.saveGame5["ones minute"]));
            }
            if (saveGame.data.saveGame6) {
                btntxt(6, "6 " + saveGame.data.saveGame6["name"] + " Day:" + saveGame.data.saveGame6["day"] + "," + saveGame.data.saveGame6["display hour"] + ":" + saveGame.data.saveGame6["tens minute"] + int(saveGame.data.saveGame6["ones minute"]));
            }
            if (saveGame.data.saveGame7) {
                btntxt(7, "7 " + saveGame.data.saveGame7["name"] + " Day:" + saveGame.data.saveGame7["day"] + "," + saveGame.data.saveGame7["display hour"] + ":" + saveGame.data.saveGame7["tens minute"] + int(saveGame.data.saveGame7["ones minute"]));
            }
            if (saveGame.data.saveGame8) {
                btntxt(8, "8 " + saveGame.data.saveGame8["name"] + " Day:" + saveGame.data.saveGame8["day"] + "," + saveGame.data.saveGame8["display hour"] + ":" + saveGame.data.saveGame8["tens minute"] + int(saveGame.data.saveGame8["ones minute"]));
            }
            if (saveGame.data.saveGame9) {
                btntxt(9, "9 " + saveGame.data.saveGame9["name"] + " Day:" + saveGame.data.saveGame9["day"] + "," + saveGame.data.saveGame9["display hour"] + ":" + saveGame.data.saveGame9["tens minute"] + int(saveGame.data.saveGame9["ones minute"]));
            }

            scene("Where would you like to save? ", true);

            scene("\n\n<i>Your saved games are stored locally on your computer either at some location or other. " +
                    "\n\nInside whichever relevant folder it is, there's a file called fattyStripped.sol which represents all your saved games. " +
                    "This is a temporary internet file that can and will get deleted any time your temporary internet files get cleaned out. " +
                    "If you would like to make a backup of your save games, copy the fattyStripped.sol file and save it somewhere else. " +
                    "To restore your saved games; place a copy of your backup back in whichever folder it came from originally, making sure the file name is still fattyStripped.sol. " +
                    "<\i>", false);

            //Creates buttons for you to select which slot to save in.
            listen = function ():void {
                switch (btnchc) {
                    case 1:
                        doSave(1);
                        break;
                    case 2:
                        doSave(2);
                        break;
                    case 3:
                        doSave(3);
                        break;
                    case 4:
                        doSave(4);
                        break;
                    case 5:
                        doSave(5);
                        break;
                    case 6:
                        doSave(6);
                        break;
                    case 7:
                        doSave(7);
                        break;
                    case 8:
                        doSave(8);
                        break;
                    case 9:
                        doSave(9);
                        break;
                    default:
                        if (btnchc == 12) {
                            specialEvent = 1;
                            subEvent = "";
                            doEvent(location);
                        }
                        break;
                }
            }
        }

        //Displays dialogue for loading a game
        public function tryLoad():void {

            //Pulls up the saved game object from the players computer
            var saveGame:SharedObject = SharedObject.getLocal("fattyStripped");
            currentState = "options";

            clearView();
            //Displays saved game information to the buttons if a saved game exists in that slot
            if (saveGame.data.saveGame1) {
                btntxt(1, "1 " + saveGame.data.saveGame1["name"] + " Day:" + saveGame.data.saveGame1["day"] + "," + saveGame.data.saveGame1["display hour"] + ":" + saveGame.data.saveGame1["tens minute"] + int(saveGame.data.saveGame1["ones minute"]));
            }
            if (saveGame.data.saveGame2) {
                btntxt(2, "2 " + saveGame.data.saveGame2["name"] + " Day:" + saveGame.data.saveGame2["day"] + "," + saveGame.data.saveGame2["display hour"] + ":" + saveGame.data.saveGame2["tens minute"] + int(saveGame.data.saveGame2["ones minute"]));
            }
            if (saveGame.data.saveGame3) {
                btntxt(3, "3 " + saveGame.data.saveGame3["name"] + " Day:" + saveGame.data.saveGame3["day"] + "," + saveGame.data.saveGame3["display hour"] + ":" + saveGame.data.saveGame3["tens minute"] + int(saveGame.data.saveGame3["ones minute"]));
            }
            if (saveGame.data.saveGame4) {
                btntxt(4, "4 " + saveGame.data.saveGame4["name"] + " Day:" + saveGame.data.saveGame4["day"] + "," + saveGame.data.saveGame4["display hour"] + ":" + saveGame.data.saveGame4["tens minute"] + int(saveGame.data.saveGame4["ones minute"]));
            }
            if (saveGame.data.saveGame5) {
                btntxt(5, "5 " + saveGame.data.saveGame5["name"] + " Day:" + saveGame.data.saveGame5["day"] + "," + saveGame.data.saveGame5["display hour"] + ":" + saveGame.data.saveGame5["tens minute"] + int(saveGame.data.saveGame5["ones minute"]));
            }
            if (saveGame.data.saveGame6) {
                btntxt(6, "6 " + saveGame.data.saveGame6["name"] + " Day:" + saveGame.data.saveGame6["day"] + "," + saveGame.data.saveGame6["display hour"] + ":" + saveGame.data.saveGame6["tens minute"] + int(saveGame.data.saveGame6["ones minute"]));
            }
            if (saveGame.data.saveGame7) {
                btntxt(7, "7 " + saveGame.data.saveGame7["name"] + " Day:" + saveGame.data.saveGame7["day"] + "," + saveGame.data.saveGame7["display hour"] + ":" + saveGame.data.saveGame7["tens minute"] + int(saveGame.data.saveGame7["ones minute"]));
            }
            if (saveGame.data.saveGame8) {
                btntxt(8, "8 " + saveGame.data.saveGame8["name"] + " Day:" + saveGame.data.saveGame8["day"] + "," + saveGame.data.saveGame8["display hour"] + ":" + saveGame.data.saveGame8["tens minute"] + int(saveGame.data.saveGame8["ones minute"]));
            }
            if (saveGame.data.saveGame9) {
                btntxt(9, "9 " + saveGame.data.saveGame9["name"] + " Day:" + saveGame.data.saveGame9["day"] + "," + saveGame.data.saveGame9["display hour"] + ":" + saveGame.data.saveGame9["tens minute"] + int(saveGame.data.saveGame9["ones minute"]));
            }

            miscScene("Which file would you like to load? ", true);

            miscScene("\n\n<i>Your saved games are stored locally on your computer either at some location or other. " +
                    "\n\nInside whichever relevant folder it is, there's a file called fattyStripped.sol which represents all your saved games. " +
                    "This is a temporary internet file that can and will get deleted any time your temporary internet files get cleaned out. " +
                    "If you would like to make a backup of your save games, copy the fattyStripped.sol file and save it somewhere else. " +
                    "To restore your saved games; place a copy of your backup back in whichever folder it came from originally, making sure the file name is still fattyStripped.sol. " +
                    "<\i>", false);

            //Creates buttons for you to choose which slot to load.
            listen = function ():void {
                switch (btnchc) {
                    case 1:
                        doLoad(1);
                        break;
                    case 2:
                        doLoad(2);
                        break;
                    case 3:
                        doLoad(3);
                        break;
                    case 4:
                        doLoad(4);
                        break;
                    case 5:
                        doLoad(5);
                        break;
                    case 6:
                        doLoad(6);
                        break;
                    case 7:
                        doLoad(7);
                        break;
                    case 8:
                        doLoad(8);
                        break;
                    case 9:
                        doLoad(9);
                        break;
                }
            }
        }

        //Saves the game in the input slot
        public function doSave(slot:int):void {

            //Pulls up the saved game data from the player's computer
            var saveGame:SharedObject = SharedObject.getLocal("fattyStripped");

            //Creates the object that'll store all of the current game's data
            var saveArray:Object = {};

            scene("Your game has been saved. ", true);
            nextView();
            listen = function ():void {
                if (btnchc == 12) {
                    //common.visible = true;
                    specialEvent = 0;
                    subEvent = "";
                    doEvent(location);
                }
            };

            //Location
            saveArray["locationName"] = location.Name;

            //basic stats
            saveArray["strength"] = bSTR;
            saveArray["speed"] = bAGI;
            saveArray["intelligence"] = bINT;
            saveArray["stomach"] = bSTO;
            saveArray["endurance"] = bEND;

            //stats
            saveArray["health"] = HEA;
            saveArray["max health"] = bmaxHEA;
            saveArray["MANA"] = MANA;
            saveArray["eaten"] = Eaten;
            saveArray["drank"] = Drank;
            saveArray["Inflated"] = Inflated;
            saveArray["InflatedMass"] = InflatedMass;
            saveArray["max full"] = maxFUL;
            saveArray["stamina"] = STA;
            saveArray["calories"] = Calories;
            saveArray["fat"] = FAT;

            //description
            saveArray["name"] = playerName;
            saveArray["player species"] = ObjectUtil.copy(playerSpecies) as Species;
            saveArray["gender"] = ObjectUtil.copy(playerGender) as Gender;
            saveArray["height"] = playerHeight;

            //inventory
            saveArray["inventory"] = backupArray(invArray);
            saveArray["keyInvArray"] = backupArray(keyInvArray);
            saveArray["max inventory"] = maxInv;
            saveArray["gold"] = GLD;

            //storage
            saveArray["storage"] = backupArray(storageArray);
            saveArray["max storage"] = maxStorage;
            saveArray["storage gold"] = storageGold;

            //quests
            saveArray["questArray"] = backupArray(questArray);

            //Spells
            saveArray["spellArray"] = backupArray(spellArray);

            //experience
            saveArray["experience"] = XP;
            saveArray["xp to level"] = XPtoLevel;
            saveArray["level"] = LVL;
            saveArray["level up"] = LVLup;

            //equipment
            saveArray["weapon"] = ObjectUtil.copy(WEA) as Items;
            saveArray["armor"] = ObjectUtil.copy(ARM) as Items;
            saveArray["top"] = ObjectUtil.copy(TOP) as Items;
            saveArray["bottom"] = ObjectUtil.copy(BTM) as Items;

            //Options
            saveArray["optionsMetric"] = optionsMetric;
            saveArray["optionsImperial"] = optionsImperial;
            saveArray["optionsPopping"] = optionsPopping;
            saveArray["optionsFemales"] = optionsFemales;
            saveArray["optionsMales"] = optionsMales;
            saveArray["optionsDescription"] = optionsDescription;

            //timed events
            saveArray["stomach stretch"] = statusStomachStretch;
            saveArray["statusBeeVenom"] = statusBloatVenom;
            saveArray["statusBeeVenomPower"] = statusBloatVenomPower;
            saveArray["statusWellFed"] = statusWellFed;
            saveArray["statusWellFedPower"] = statusWellFedPower;

            //Modified stats
            saveArray["statusSTRBuff"] = statusSTRBuff;
            saveArray["statusSTRBuffPower"] = statusSTRBuffPower;
            saveArray["statusINTBuff"] = statusINTBuff;
            saveArray["statusINTBuffPower"] = statusINTBuffPower;
            saveArray["statusENDBuff"] = statusENDBuff;
            saveArray["statusENDBuffPower"] = statusENDBuffPower;
            saveArray["statusAGIBuff"] = statusAGIBuff;
            saveArray["statusAGIBuffPower"] = statusAGIBuffPower;
            saveArray["statusMANABuff"] = statusMANABuff;
            saveArray["statusMANABuffPower"] = statusMANABuffPower;
            saveArray["statusSTOBuff"] = statusSTOBuff;
            saveArray["statusSTOBuffPower"] = statusSTOBuffPower;

            //time
            saveArray["day"] = day;
            saveArray["am pm"] = AMPM;
            saveArray["hour"] = hour;
            saveArray["display hour"] = displayHour;
            saveArray["tens minute"] = tensMinute;
            saveArray["ones minute"] = onesMinute;


            if (slot == 1) {
                saveGame.data.saveGame1 = saveArray;
            }
            if (slot == 2) {
                saveGame.data.saveGame2 = saveArray;
            }
            if (slot == 3) {
                saveGame.data.saveGame3 = saveArray;
            }
            if (slot == 4) {
                saveGame.data.saveGame4 = saveArray;
            }
            if (slot == 5) {
                saveGame.data.saveGame5 = saveArray;
            }
            if (slot == 6) {
                saveGame.data.saveGame6 = saveArray;
            }
            if (slot == 7) {
                saveGame.data.saveGame7 = saveArray;
            }
            if (slot == 8) {
                saveGame.data.saveGame8 = saveArray;
            }
            if (slot == 9) {
                saveGame.data.saveGame9 = saveArray;
            }

            //Creates the save game object on the player's computer
            saveGame.flush();
        }

        //Loads the game from the input slot
        public function doLoad(slot:int):void {

            //Pulls up the saved game data from the player's compute
            var saveGame:SharedObject = SharedObject.getLocal("fattyStripped");

            //Creates the object that'll store all of the current game's data
            var saveArray:Object = {};

            currentState = "default";
            scene("Your game has been loaded. ", true);

            switch (slot) {
                case 1:
                    saveArray = saveGame.data.saveGame1;
                    break;
                case 2:
                    saveArray = saveGame.data.saveGame2;
                    break;
                case 3:
                    saveArray = saveGame.data.saveGame3;
                    break;
                case 4:
                    saveArray = saveGame.data.saveGame4;
                    break;
                case 5:
                    saveArray = saveGame.data.saveGame5;
                    break;
                case 6:
                    saveArray = saveGame.data.saveGame6;
                    break;
                case 7:
                    saveArray = saveGame.data.saveGame7;
                    break;
                case 8:
                    saveArray = saveGame.data.saveGame8;
                    break;
                case 9:
                    saveArray = saveGame.data.saveGame9;
                    break;
            }

            //basic stats
            bSTR = saveArray["strength"];
            bAGI = saveArray["speed"];
            bINT = saveArray["intelligence"];
            bSTO = saveArray["stomach"];
            bEND = saveArray["endurance"];


            //advanced stats
            HEA = saveArray["health"];
            bmaxHEA = saveArray["max health"];
            if (saveArray["MANA"] != null) {
                MANA = saveArray["MANA"];
            }
            if (saveArray["MANA"] == null) {
                MANA = 0;
            }
            Eaten = saveArray["eaten"];
            Drank = saveArray["drank"];
            if (saveArray["Inflated"] != null) {
                Inflated = saveArray["Inflated"];
            }
            if (saveArray["InflatedMass"] != null) {
                InflatedMass = saveArray["InflatedMass"];
            }
            if (saveArray["Inflated"] == null) {
                Inflated = 0;
            }
            if (saveArray["InflatedMass"] == null) {
                InflatedMass = 0;
            }
            maxFUL = saveArray["max full"];
            STA = saveArray["stamina"];
            Calories = saveArray["calories"];
            FAT = saveArray["fat"];

            //player description
            playerName = saveArray["name"];
            playerSpecies = ObjectUtil.copy(saveArray["player species"]) as Species;
            var loadedGender:Gender = ObjectUtil.copy(saveArray["gender"]) as Gender;
            switch (loadedGender.name) {
                case Male.name:
                    playerGender = ObjectUtil.copy(Male) as Gender;
                    break;
                default:
                    playerGender = ObjectUtil.copy(Female) as Gender;
                    break;
            }
            playerHeight = saveArray["height"];

            //inventory
            invArray = [];
            invArray = backupArray(saveArray["inventory"]);
            keyInvArray = [];
            keyInvArray = backupArray(saveArray["keyInvArray"]);
            maxInv = saveArray["max inventory"];
            GLD = saveArray["gold"];

            //quests
            questArray = [];
            questArray = backupArray(saveArray["questArray"]);

            //Spells
            spellArray = [];
            spellArray = backupArray(saveArray["spellArray"]);

            //storage
            storageArray = [];
            storageArray = backupArray(saveArray["storage"]);
            maxStorage = saveArray["max storage"];
            storageGold = saveArray["storage gold"];

            //experience
            XP = saveArray["experience"];
            XPtoLevel = saveArray["xp to level"];
            LVL = saveArray["level"];
            LVLup = saveArray["level up"];

            //equipment
            WEA = ObjectUtil.copy(saveArray["weapon"]) as Items;
            ARM = ObjectUtil.copy(saveArray["armor"]) as Items;
            TOP = ObjectUtil.copy(saveArray["top"]) as Items;
            BTM = ObjectUtil.copy(saveArray["bottom"]) as Items;

            //Options
            if (saveArray["optionsMetric"] != null) {
                optionsMetric = saveArray["optionsMetric"];
            }
            if (saveArray["optionsImperial"] != null) {
                optionsImperial = saveArray["optionsImperial"];
            }
            if (saveArray["optionsMetric"] == null) {
                optionsMetric = false;
            }
            if (saveArray["optionsImperial"] == null) {
                optionsImperial = true;
            }

            if (saveArray["optionsPopping"] != null) {
                optionsPopping = saveArray["optionsPopping"];
            }
            if (saveArray["optionsPopping"] == null) {
                optionsPopping = false;
            }

            if (saveArray["optionsDescription"] != null) {
                optionsDescription = saveArray["optionsDescription"];
            }
            if (saveArray["optionsDescription"] == null) {
                optionsDescription = true;
            }

            if (saveArray["optionsFemales"] != null) {
                optionsFemales = saveArray["optionsFemales"];
            }
            if (saveArray["optionsFemales"] == null) {
                optionsFemales = true;
            }
            if (saveArray["optionsMales"] != null) {
                optionsMales = saveArray["optionsMales"];
            }
            if (saveArray["optionsMales"] == null) {
                optionsMales = true;
            }

            //timed events
            statusStomachStretch = saveArray["stomach stretch"];
            statusBloatVenom = saveArray["statusBeeVenom"];
            statusWellFed = saveArray["statusWellFed"];
            statusBloatVenomPower = saveArray["statusBeeVenomPower"];
            statusWellFedPower = saveArray["statusWellFedPower"];

            //Modified stats
            statusSTRBuff = saveArray["statusSTRBuff"];
            statusSTRBuffPower = saveArray["statusSTRBuffPower"];
            statusINTBuff = saveArray["statusINTBuff"];
            statusINTBuffPower = saveArray["statusINTBuffPower"];
            statusENDBuff = saveArray["statusENDBuff"];
            statusENDBuffPower = saveArray["statusENDBuffPower"];
            statusAGIBuff = saveArray["statusAGIBuff"];
            statusAGIBuffPower = saveArray["statusAGIBuffPower"];
            statusMANABuff = saveArray["statusMANABuff"];
            statusMANABuffPower = saveArray["statusMANABuffPower"];
            statusSTOBuff = saveArray["statusSTOBuff"];
            statusSTOBuffPower = saveArray["statusSTOBuffPower"];

            //time
            day = saveArray["day"];
            AMPM = saveArray["am pm"];
            hour = saveArray["hour"];
            displayHour = saveArray["display hour"];
            tensMinute = saveArray["tens minute"];
            onesMinute = saveArray["ones minute"];

            //Moves the player to whatever location the loaded game was saved at
            var savedLocationName:String = saveArray["locationName"];
            var YourHouse:Locations = null;
            switch (savedLocationName) {
                default:
                    locationUpdate(YourHouse);
                    break;
            }

            //Creates default button setup
            nextView();
            listen = function ():void {
                if (btnchc == 12) {
                    newGame = false;
                    //common.visible = true;
                    specialEvent = 0;
                    scene("", true);
                    doEvent(location);
                }
            }

        }

        //Keeps track of time////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////Keeps track of time//

        //Tells you if it's daytime or not
        public function dayTime():Boolean {
            if (hour >= 21 || hour <= 5) {
                return false;
            }
            else {
                return true;
            }
        }

        //Returns either "sun" or "moon" depending on time of day. Used to better contextualize scenes based on time of day
        public function saySun():String {
            if (dayTime()) {
                return "sun";
            }
            else {
                return "moon";
            }
        }

        //Returns the section of day, for use in scene descriptions
        public function timeOfDay():String {
            var timeString:String;
            switch (hour) {
                case 0:
                case 1:
                case 2:
                case 3:
                case 4:
                case 5:
                case 21:
                case 22:
                case 23:
                    timeString = "night";
                    break;
                case 6:
                case 7:
                case 8:
                case 9:
                    timeString = "morning";
                    break;
                case 10:
                case 11:
                case 12:
                case 13:
                case 14:
                case 15:
                    timeString = "day";
                    break;
                case 16:
                case 17:
                case 18:
                case 19:
                case 20:
                    timeString = "evening";
                    break;
            }
            return timeString;
        }


        //Moves time forward by the input number of minutes
        public function doTime(theTime:Number):void {
            doDigest(theTime);
            eventTime(theTime);

            //Advances minutes
            onesMinute += theTime;

            //Advances tens of minutes
            while (onesMinute > 9) {
                tensMinute += 1;
                onesMinute -= 10;

                //Activates the player's regeneration buff
                if (tmagicREGENbuff > 0) {
                    doHealth(xdy(tmagicREGENbuffDamage, tmagicREGENbuffRange) + (INT * 0.4));
                    tmagicREGENbuff--;
                    if (tmagicREGENbuff <= 0) {
                        tmagicREGENbuff = 0;
                        tmagicREGENbuffDamage = 0;
                        tmagicREGENbuffRange = 0;
                    }
                }
            }

            //Advances hours
            while (tensMinute > 5) {
                hour += 1;
                tensMinute -= 6;
                updateBackground();
            }

            //Advances days
            while (hour > 23) {
                day += 1;
                hour -= 24;
            }

            //Updates the displayed hour based on a twelve hour clock
            displayHour = hour;
            while (displayHour > 12) {
                displayHour -= 12;
            }
            if (displayHour == 0) {
                displayHour = 12;
            }

            //Updates the displayed clock to whether it's in the AM or PM
            AMPM = (hour <= 11) ? "AM" : "PM";
        }

        //Keeps track of timed events
        public function eventTime(theTime:int):void {

            //Stomach stretching from overfullness
            if (FUL > 100) {
                statusStomachStretch += theTime;
                if (statusStomachStretch >= 120) {
                    scene("\n<i>You've spent so much time being full that your stomach has stretched out.</i> ", false);
                    chgStats(0, 0, 0, 0, 1);
                    statusStomachStretch -= 500;
                }
            }

            //Well fed bonus
            if (statusWellFed > 0) {
                statusWellFed -= theTime;
                if (statusWellFed <= 0) {
                    statusWellFedPower = 0;
                    statusWellFed = 0;
                }
            }


            //Stomach size buff
            var eventText:* = null;
            if (statusSTOBuff > 0) {
                statusSTOBuff -= theTime;
                if (statusSTOBuff <= 0) {
                    if (statusSTOBuffPower > 0) {
                        scene("<i>You suddenly feel less hungry.</i> ", false);
                    }
                    if (statusSTOBuffPower < 0) {
                        scene("<i>You suddenly feel more hungry.</i> ", false);
                    }
                    statusSTOBuff = 0;
                    statusSTOBuffPower = 0;
                    updateStats();
                    //Tests you should explode from the buff wearing off or not and updates the buff accordingly
                    if (FUL > maxFUL) {
                        if (maximumFullness() < ATE && ATE - maximumFullness() < 30) {
                            statusSTOBuffPower = ATE - maximumFullness();
                        }
                        if (maximumFullness() < ATE && ATE - maximumFullness() > 30) {
                            statusSTOBuffPower = 30
                        }
                        statusSTOBuff = 40;
                        updateStats();
                        if (eventText.htmlText.match("Fortunately the shrinking eventually stops before you explode") == null) {
                            scene("\n\tYou hear an ominous gurgling sound emanating from your stomach. " +
                                    "You look down as you're struck by the all too familiar sensation of growing fuller and fuller. " +
                                    "You quickly realize that the powers affecting your stomach are wearing off in spite of you exceeding your normal limits. " +
                                    "Fortunately the shrinking eventually stops before you explode, although you're stomach is still stretched to its absolute limit. " +
                                    "It seems the effects haven't completely worn off... yet. ", false);
                        }
                    }
                }
            }

            //Bloat venom
            if (statusBloatVenomPower > 0) {
                statusBloatVenom += theTime;
                if (statusBloatVenom >= 30) {
                    if (ATE + statusBloatVenomPower < maximumFullness() + 1) {
                        doInflate(statusBloatVenomPower, 0);
                        statusBloatVenomPower -= 0.5;
                        statusBloatVenom %= 30;
                        if (eventText.htmlText.match("You suddenly feel slightly more full due to the bloat venom") == null) {
                            scene("<i>You suddenly feel slightly more full due to the bloat venom</i> ", false);
                        }
                        if (statusBloatVenomPower <= 0) {
                            statusBloatVenomPower = 0;
                            statusBloatVenom = 0;
                            scene("<i>Fortunately, your head no longer feels fuzzy and it seems you're finally over the effect's of the bloat venom</i> ", false);
                        }
                    }
                    else {
                        doInflate(remainingCapacity(), 0);
                        statusBloatVenomPower -= 0.5;
                        statusBloatVenom %= 30;
                        if (eventText.htmlText.match("Your stomach creaks ominously as it grows ever more distended from the venom coursing through your veins. ") == null) {
                            scene("Your stomach creaks ominously as it grows ever more distended from the venom coursing through your veins. " +
                                    "Your stomach is stretched to the absolute bursting point and it's a miracle it hasn't exploded already. ", false);
                        }
                    }
                }
            }

            //Strength buffs
            if (statusSTRBuff > 0) {
                statusSTRBuff -= theTime;
                if (statusSTRBuff <= 0) {
                    if (statusSTRBuffPower > 0) {
                        scene("<i>You no longer feel as strong.</i> ", false);
                    }
                    if (statusSTRBuffPower < 0) {
                        scene("<i>You no longer feel as weak!</i> ", false);
                    }
                    statusSTRBuff = 0;
                    statusSTRBuffPower = 0;
                }
            }

            //Agility buffs
            if (statusAGIBuff > 0) {
                statusAGIBuff -= theTime;
                if (statusAGIBuff <= 0) {
                    if (statusAGIBuffPower > 0) {
                        scene("<i>You no longer feel as fast.</i> ", false);
                    }
                    if (statusAGIBuffPower < 0) {
                        scene("<i>You no longer feel as slow!</i> ", false);
                    }
                    statusAGIBuff = 0;
                    statusAGIBuffPower = 0;
                }
            }

            //Intelligence buffs
            if (statusINTBuff > 0) {
                statusINTBuff -= theTime;
                if (statusINTBuff <= 0) {
                    if (statusINTBuffPower > 0) {
                        scene("<i>You no longer feel as smart.</i> ", false);
                    }
                    if (statusINTBuffPower < 0) {
                        scene("<i>You no longer feel as stupid!</i> ", false);
                    }
                    statusINTBuff = 0;
                    statusINTBuffPower = 0;
                }
            }

            //Endurance buffs
            if (statusENDBuff > 0) {
                statusENDBuff -= theTime;
                if (statusENDBuff <= 0) {
                    if (statusENDBuffPower > 0) {
                        scene("<i>You no longer feel as tough.</i> ", false);
                    }
                    if (statusENDBuffPower < 0) {
                        scene("<i>You no longer feel as sickly!</i> ", false);
                    }
                    statusENDBuff = 0;
                    statusENDBuffPower = 0;
                }
            }

            //Mana buffs
            if (statusMANABuff > 0) {
                statusMANABuff -= theTime;
                if (statusMANABuff <= 0) {
                    if (statusMANABuffPower > 0) {
                        scene("<i>You no longer feel as empowered.</i> ", false);
                    }
                    if (statusMANABuffPower < 0) {
                        scene("<i>You no longer feel as disempowered!</i> ", false);
                    }
                    statusMANABuff = 0;
                    statusMANABuffPower = 0;
                }
            }

        }

        //Returns how much stamina an action would cost based on your stats
        public function staminaCost(ID:Number):Number {
            return (ID * Math.pow(0.8, END / 40));
        }

        //Gain/spend input amount of stamina based on stats
        public function doStamina(resting:Number):void {
            if (resting > 0) {
                //doArrow("STAup");
                STA += resting;
            }
            if (resting < 0) {
                //doArrow("STAdown");
                STA += resting * Math.pow(0.8, END / 40);
            }
            if (STA < 0) {
                STA = 0;
            }
            if (STA > 100) {
                STA = 100;
            }
        }

        //Does travel time, digestion, and exhaustion
        public function doWalk(walkFor:Number):void {
            //Calculates what plateau yours tats are on
            var strengthLevel:Number = ((ATE / 2) + (FAT / 5)) / STR;
            var agilityLevel:Number = (AGI / 40) - strengthLevel;

            //Expends amount of stamina based on how strong you are
            if (strengthLevel > 20) {
                strengthLevel = 20;
            }
            doStamina((-walkFor) * Math.pow(1.25, strengthLevel));

            //Expends time based on how fast you are
            if (agilityLevel < -20) {
                agilityLevel = -20;
            }
            if (agilityLevel > 20) {
                agilityLevel = 20;
            }
            var timeTraveled:Number = walkFor * Math.pow(0.8, agilityLevel);
            //Makes sure traveling always takes at least some amount of time
            if (timeTraveled <= 1) {
                timeTraveled = 1;
            }
            doTime(timeTraveled);
        }

        //Food and digestion///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////Food and digestion//
        //Digests food for the input amount of time
        public function doDigest(digestFor:Number):void {
            fixFull();

            //Stores what your stats start out at to be referenced later in this function
            var digested:Number = ATE;
            var fatness:Number = FAT;

            //Calculates the rate at which you should digest food based on the size of your stomach
            var digestionRate:Number = (STO * .75) / 1440;
            var tempInt:int;

            //Removes an amount of food/drink based on how fast you digest such that food/drink remains at the same ratio to each other
            if (Eaten < Drank) {
                tempInt = Eaten / Drank;
                Eaten -= (digestFor * digestionRate) * tempInt;
                Drank -= (digestFor * digestionRate) * (1 - tempInt);
            }
            else if (Eaten > Drank) {
                tempInt = Drank / Eaten;
                Eaten -= (digestFor * digestionRate) * (1 - tempInt);
                Drank -= (digestFor * digestionRate) * tempInt;
            }
            else if (Eaten == Drank) {
                Eaten -= (digestFor * digestionRate * .5);
                Drank -= (digestFor * digestionRate * .5);
            }

            //Deflates the player
            var deflationRate:Number = digestFor * 0.1;
            var deflatedAmount:Number = Inflated;
            Inflated -= deflationRate;
            if (Inflated <= 0) {
                Inflated = 0;
                InflatedMass = 0;
            }
            if (deflatedAmount != 0) {
                InflatedMass *= Inflated / deflatedAmount;
            }

            //Prevents the amount you've eaten/drank from going negative
            if (Eaten <= 0) {
                Eaten = 0
            }
            if (Drank <= 0) {
                Drank = 0
            }

            //doArrow("FULdown");
            updateStats();

            //Burns fat
            doFat(-0.004 * digestFor);

            //Restores mana
            var startMana:Number = MANA;
            doMana(maxMANA * .00417 * digestFor);
            FAT -= (MANA - startMana) * 0.25;

            //Gains fat based on how much of what you've consumed you've digested and how many calories you had stored up
            digested = (digested - ATE) / digested;
            if (digested > 0) {
                doWeight(digested);
            }

            //Displays the relevant arrows based on wether you've gained or lost weight since the beginning of this function
            if (fatness < FAT) {
                //doArrow("FATup")
            }
            if (fatness > FAT) {
                //doArrow("FATdown")
            }

            //Prevents fat or calories from going negative
            if (FAT <= 0) {
                FAT = 0;
            }
            if (Calories <= 0) {
                Calories = 0;
            }
        }

        //Converts stored calories into fat based on how much of your stomach contents you just digested
        public function doWeight(digested:Number):void {
            var caloriesDigesting:Number = digested * Calories;
            Calories -= caloriesDigesting;
            doFat(caloriesDigesting);
        }

        //Consumes food/drink and add calories
        public function doConsume(ate:Number, drink:Number, calory:Number):void {
            Eaten += ate;
            Drank += drink;
            Calories += calory;
            updateStats();

            //Displays warnings for being overstuffed
            var eventText:* = null;
            if ((maxFUL - FUL) < 10 && eventText.htmlText.match("You feel like you'll explode if you get any fuller") == null) {
                scene("<i>(You feel like you'll explode if you get any fuller.)</i> ", false)
            }
            if ((maxFUL - FUL) < 20 && (maxFUL - FUL) >= 10 && eventText.htmlText.match("Your stomach feels painfully distended") == null) {
                scene("<i>(Your stomach feels painfully distended.)</i> ", false)
            }
            if ((maxFUL - FUL) > 20 && FUL > 100 && eventText.htmlText.match("You're so full it hurts") == null) {
                scene("<i>(You're so full it hurts.)</i> ", false)
            }
            //Displays appropriate arrows
            if (ate + drink > 0) {
                //doArrow("FULup")
            }
            if (ate + drink < 0) {
                //doArrow("FULdown")
            }
        }

        //Consumes food without displaying notices
        public function doConsumeQuiet(ate:Number, drink:Number, calory:Number):void {
            Eaten += ate;
            Drank += drink;
            Calories += calory;
            updateStats();

            if (ate + drink > 0) {
                //doArrow("FULup")
            }
            if (ate + drink < 0) {
                //doArrow("FULdown")
            }
        }

        //Get inflated by the input volume and input weight
        public function doInflate(inflate:Number, weight:Number):void {
            Inflated += inflate;
            InflatedMass += weight;
            updateStats();

            //Displays warnings for being overinflated
            var eventText:* = null;
            if ((maxFUL - FUL) < 10 && eventText.htmlText.match("You feel like you'll explode if you get any fuller") == null) {
                scene("<i>(You feel like you'll explode if you get any fuller.)</i> ", false)
            }
            if ((maxFUL - FUL) < 20 && (maxFUL - FUL) >= 10 && eventText.htmlText.match("Your stomach feels painfully distended") == null) {
                scene("<i>(Your stomach feels painfully distended.)</i> ", false)
            }
            if ((maxFUL - FUL) > 20 && FUL > 100 && eventText.htmlText.match("You're so full it hurts") == null) {
                scene("<i>(You're so full it hurts.)</i> ", false)
            }
            //Displays appropriate arrows
            if (inflate > 0) {
                //doArrow("FULup")
            }
            if (inflate < 0) {
                //doArrow("FULdown")
            }
        }

        //Executes an items effect and displays the relevant event text based on the input item
        public function doUseItem(ID:Items):void {

            //Differentiates how the scene is displayed between being in combat or not
            if (currentState != "combatInventory") {
                scene("", true);
            }
            if (currentState == "combatInventory") {
                combatDialogue();
                scene("<li><b>Item</b></li>", false);
            }

            //Executes the standard healing/eating components of the input item
            if (ID.Heal != 0) {
                doHealth(ID.Heal);
            }
            if (ID.Mana != 0) {
                doMana(ID.Mana);
            }
            if (ID.Stamina != 0) {
                doStamina(ID.Stamina);
            }
            if (ID.eat != 0 || ID.drink != 0) {
                doConsume(ID.eat, ID.drink, ID.Calories);
            }

            //Displays the text associated with using the item
            switch (ID.itemUse) {
                case "You used the item! ":
                    //Better contextualizes items with only the default itemUse scene set
                    if (ID.Food == true) {
                        scene("You ate the " + ID.Name + "! ", false);
                    }
                    if (ID.Drink == true) {
                        scene("You drank the " + ID.Name + "! ", false);
                    }
                    if (ID.Weapon == true || ID.Armor == true || ID.Top == true || ID.Bottom == true) {
                        scene("You equipped the " + ID.Name + "! ", false);
                    }
                    break;
                default:
                    //Displays scene for items that have custom itemUse descriptions
                    switch (ID.eat > 0 || ID.drink > 0) {
                        case true:
                            //Differntiate scenes on if you overate and exploded or not
                            if (!alive() && !inCombat()) {
                                scene("\n\t" + ID.overfilled, false);
                            }
                            else {
                                scene(ID.itemUse, false);
                            }
                            break;
                        default:
                            //Displays scene for any item not already covered
                            scene(ID.itemUse, false);
                            break;
                    }
                    break;
            }


            //Executes function for equipping items and displays any further relevant scenes. Also returns unequipped items if anything was previously equipped
            if (ID.Weapon == true) {
                if (WEA.Name != "fists") {
                    getItem(WEA);
                }
                WEA = ObjectUtil.copy(ID) as Items;
            }

            if (ID.Armor == true) {
                if (ARM.Name != "unarmored") {
                    getItem(ARM);
                }
                ARM = ObjectUtil.copy(ID) as Items;
            }

            if (ID.Top == true) {
                if (ID.Expand <= waistDiameter() && ID.Expand > 0) {
                    scene(ID.Toosmall, true);
                    getItem(ID);
                }
                else {
                    if (TOP.Name != "naked chest") {
                        getItem(TOP);
                    }
                    TOP = ObjectUtil.copy(ID) as Items;
                }
            }

            if (ID.Bottom == true) {
                if (ID.Expand <= waistDiameter() && ID.Expand > 0) {
                    scene(ID.Toosmall, true);
                    getItem(ID);
                }
                else {
                    if (BTM.Name != "naked legs") {
                        getItem(BTM);
                    }
                    BTM = ObjectUtil.copy(ID) as Items;
                }
            }


            //If you've overeaten to the point of hitting 0 health, sends you to the defeat event
            if (ID.eat > 0 || ID.drink > 0) {
                if (!alive() && !inCombat()) {
                    var overeating:Defeats = null;
                    defeatEvent(overeating);
                }
            }

            //update stats to reflect whatever effect the items had
            updateStats();

            //Sets up what's supposed to happen after you used an item depending on what state you're in and if using the item caused you to be defeated
            if (currentState != "combatInventory" && currentState != "defeated") {
                doNext(null);
            }
            if (currentState == "defeated") {
                nextButton();
            }
            if (currentState == "combatInventory") {
                currentState = "combat";
                scene("\n", false);
                enemyAttack();
                if (eHEA > 0 && inCombat()) {
                    nextButton();
                }
            }
        }

        //Displays an items description when you view an item
        public function itemDescribe(ID:Items):void {

            //Name
            scene("<b>" + capFirst(ID.Name) + ":</b><i>", false);

            //Physical description
            if (ID.Top || ID.Bottom) {
                switch (ID.Popped) {
                    case true:
                        scene("\n\t" + ID.PoppedDescription, false);
                        break;
                    default:
                        scene("\n\t" + ID.Description, false);
                        break;
                }
            }
            if (!ID.Top && !ID.Bottom) {
                scene("\n\t" + ID.Description, false);
            }

            //Item categories
            scene("\n\t" + buyValue(ID) + " gold", false);
            if (ID.type != "" && ID.type != "other") {
                scene(", " + ID.type, false);
            }
            if (ID.Consume) {
                if (ID.Weapon || ID.Armor || ID.Top || ID.Bottom) {
                    scene(", equippable", false);
                }
                else {
                    scene(", consumable", false);
                }
            }

            //Weapon stats
            if (ID.WEAd > 0) {
                scene("\n\tDeals " + ID.WEAd + "d" + ID.WEAr + " +" + int(ID.damageScaling * 100) + "% " + ID.damageStat + " " + ID.damageType.name + " damage. ", false);
                switch (ID.attackProc) {
                    case "stun":
                        scene("\n\tHas a " + ID.attackProcChance + "% chance to stun your enemy when you deal damage with this weapon. ", false);
                        break;
                    case "drain":
                        scene("\n\tHas a " + ID.attackProcChance + "% chance to restore " + int(ID.attackProcPower) + "% of the damage dealt by this weapon as health. ", false);
                        break;
                }
            }

            //Armor stats
            if (ID.Defense > 0) {
                scene("\n\tIncreases defense by " + ID.Defense + ". ", false);
                switch (ID.damageStat) {
                    case "AGI":
                    case "STR":
                    case "INT":
                        scene("\n\tIncreases damaging scaling of " + ID.damageStat + " based weapons by " + int(ID.damageScaling * 100) + "%. ", false);
                        break;
                }
            }

            //Stat buffs
            if (ID.agiBuff != 0 || ID.strBuff != 0 || ID.endBuff != 0 || ID.intBuff != 0 || ID.manaBuff != 0 || ID.healthBuff != 0) {
                scene("\n\t", false);
            }
            if (ID.agiBuff > 0) {
                scene(" Agi +" + ID.agiBuff, false);
            }
            if (ID.agiBuff < 0) {
                scene(" Agi " + ID.agiBuff, false);
            }
            if (ID.strBuff > 0) {
                scene(" Str +" + ID.strBuff, false);
            }
            if (ID.strBuff < 0) {
                scene(" Str " + ID.strBuff, false);
            }
            if (ID.endBuff > 0) {
                scene(" End +" + ID.endBuff, false);
            }
            if (ID.endBuff < 0) {
                scene(" End " + ID.endBuff, false);
            }
            if (ID.intBuff > 0) {
                scene(" Int +" + ID.intBuff, false);
            }
            if (ID.intBuff < 0) {
                scene(" Int " + ID.intBuff, false);
            }
            if (ID.manaBuff > 0) {
                scene(" Max Mana +" + ID.manaBuff, false);
            }
            if (ID.manaBuff < 0) {
                scene(" Max Mana " + ID.manaBuff, false);
            }
            if (ID.healthBuff > 0) {
                scene(" Max Health +" + ID.healthBuff, false);
            }
            if (ID.healthBuff < 0) {
                scene(" Max Health " + ID.healthBuff, false);
            }

            //Stat restoration
            if (ID.Heal > 0 || ID.Mana > 0 || ID.Stamina > 0) {
                scene("\n\tRestores: ", false);
                if (ID.Heal > 0) {
                    scene(ID.Heal + " health ", false);
                }
                if (ID.Mana > 0) {
                    scene(ID.Mana + " mana ", false);
                }
                if (ID.Stamina > 0) {
                    scene(ID.Stamina + " stamina ", false);
                }
            }

            scene("</i>", false);
        }

        //finds an item in your inventory and returns its location in the appropriate array
        public function itemFind(ID:Items):int {
            var hasItem:int = -1;
            switch (ID.Quest) {
                case true:
                    //searches for quest items
                    for (i = 0; i < keyInvArray.length; i++) {
                        var testKeyItem:Items = keyInvArray[i];
                        if (ID.Name == testKeyItem.Name) {
                            hasItem = i;
                        }
                    }
                    break;
                default:
                    //searches for regular items
                    for (i = 0; i < invArray.length; i++) {
                        var testItem:Items = invArray[i];
                        if (ID.Name == testItem.Name) {
                            hasItem = i;
                        }
                    }
                    break;
            }
            return hasItem;
        }

        //Tells if you have the item in your inventory or not
        public function itemOwned(ID:Items):Boolean {
            var itemFound:Boolean = false;
            if (itemFind(ID) > -1) {
                itemFound = true;
            }
            return itemFound;
        }

        //Expends a charge for an item and removes that item from your inventory if the charges hit 0
        public function expendItem(ID:Items):void {
            var expendedItem:Items = ObjectUtil.copy(ID) as Items;
            expendedItem.Charges--;
            switch (expendedItem.Charges > 0) {
                case true:
                    invArray.splice(invArray.indexOf(ID), 1, expendedItem);
                    break;
                default:
                    invArray.splice(invArray.indexOf(ID), 1);
                    break;
            }
        }

        //Removes input item from your appropriate inventory
        public function removeItem(ID:Items):void {
            if (itemOwned(ID)) {
                switch (ID.Quest) {
                    case true:
                        keyInvArray.splice(itemFind(ID), 1);
                        break;
                    default:
                        invArray.splice(invArray.indexOf(ID), 1);
                        break;
                }
            }
        }

        //Returns the index of an item you can stack the nput item on to
        public function testStackItem(ID:Items):int {
            var hasItem:int = -1;
            for (i = 0; i < invArray.length; i++) {
                var invItem:Items = invArray[i];
                if (ID.Name == invItem.Name && invItem.Charges + ID.Charges <= invItem.StackLimit) {
                    hasItem = i;
                }
            }
            return hasItem;
        }

        //Tests to see if there is somewhere in your inventory you can stack the item
        public function canStackItem(stackItem:Items):Boolean {
            var canStack:Boolean = false;
            if (testStackItem(stackItem) > -1) {
                canStack = true;
            }
            return canStack;
        }

        //Stacks the input item into your inventory wherever it's capable of stacking
        public function stackItem(ID:Items, charges:int):void {
            var stackingItem:Items = ObjectUtil.copy(ID) as Items;
            stackingItem.Charges += charges;
            invArray.splice(invArray.indexOf(ID), 1, stackingItem);
        }

        //Forces you to get an item even if your inventory is full. Mostly used to prevent players from getting stuck in the "inventory too full" dialogue if you receive an item in the middle of an event
        public function forceGetItem(ID:Items):void {
            scene("<li>You got " + ID.article + " " + ID.Name + "!</li>", false);
            switch (ID.Quest) {
                case true:
                    var keyItem:Items = ObjectUtil.copy(ID) as Items;
                    keyInvArray.push(keyItem);
                    break;
                default:
                    switch (canStackItem(ID)) {
                        case true:
                            //Stacks the item if possible
                            if (canStackItem(ID)) {
                                stackItem(invArray[testStackItem(ID)], ID.Charges);
                            }
                            break;
                        case false:
                            //Adds item to inventory if possible
                            var inventoryItem:Items = ObjectUtil.copy(ID) as Items;
                            invArray.push(inventoryItem);
                            break;
                    }
                    break;
            }
        }

        //Function that gives the player the input item
        public function getItem(ID:Items):void {
            scene("<li>You got " + ID.article + " " + ID.Name + "!</li>", false);

            switch (ID.Quest) {
                case true:
                    //Receive quest items
                    var keyItem:Items = ObjectUtil.copy(ID) as Items;
                    keyInvArray.push(keyItem);
                    break;
                default:
                    //Stacks the item in your inventory if possible
                    if (canStackItem(ID)) {
                        stackItem(invArray[testStackItem(ID)], ID.Charges);
                    }

                    //Adds item to inventory if possible
                    else if (invArray.length < maxInv) {
                        var inventoryItem:Items = ObjectUtil.copy(ID) as Items;
                        invArray.push(inventoryItem);
                    }

                    //Discard dialogue if inventory is too full
                    else {
                        clearView();
                        appView(0);
                        scene("Unfortunately you don't have room in your inventory. Do you want to discard this item or discard another item", false);
                        if (ID.Consume == false || ID.Useable == false) {
                            scene("? ", false);
                        }
                        if (ID.Consume) {
                            scene(", or use this now? ", false);
                            btntxt(13, "Use this now");
                        }
                        btntxt(11, "Discard this");
                        btntxt(12, "Discard another");
                        listen = function ():void {
                            switch (btnchc) {
                                case 11:
                                    //Causes the player to move on without the item
                                    doNext(null);
                                    break;
                                case 12:
                                    //Brings up the dialogue to choose an item to discard
                                    clearView();
                                    itemButtons();
                                    pageView();
                                    listen = function ():void {
                                        if (btnchc > 0 && btnchc < 10) {
                                            removeItem(invArray[(btnchc - 1) + ((invPage - 1) * 9)]);
                                            getItem(ID);
                                            doNext(null);
                                        }
                                        if (btnchc == 11) {
                                            if (invPage > 1) {
                                                invPage--;
                                            }
                                            itemButtons();
                                        }
                                        if (btnchc == 13) {
                                            if (invPage < invArray.length / 9) {
                                                invPage++;
                                            }
                                            itemButtons();
                                        }
                                    };
                                    break;
                                case 13:
                                    //Causes the player to immediately use the item that they just attempted to receive
                                    doUseItem(ID);
                                    break;
                            }
                        }
                    }
                    break;
            }
        }

        //Displays the key item inventory
        public function doKeyInventory():void {
            clearView();
            invView(0);
            invPage = 1;

            //Resets the selected item. selectedItem is used to tell the game which item you selected when it brings up the "Are you sure you want to use this item?" dialogue
            selectedItem = null;

            //Alphabetizes the key item inventory
            keyInvArray.sortOn("Name", Array.CASEINSENSITIVE);

            //Writes the useable key items to the buttons
            for (i = ((invPage - 1) * 9); i < invPage * 9; i++) {
                var tempKeyItemWrite:Items = keyInvArray[i];
                if (tempKeyItemWrite != null) {
                    writeItems(i, tempKeyItemWrite);
                }
            }
            btntxt(12, "Normal inventory");

            listen = function ():void {
                switch (btnchc) {
                    case 1:
                    case 2:
                    case 3:
                    case 4:
                    case 5:
                    case 6:
                    case 7:
                    case 8:
                    case 9:
                        if (keyInvArray[(btnchc - 1) + ((invPage - 1) * 9)] != null) {
                            selectedItem = keyInvArray[(btnchc - 1) + ((invPage - 1) * 9)];
                            scene("<b>" + capFirst(selectedItem.Name) + "</b>: \n\t" + selectedItem.Description, true);
                            var decision1:* = null;
                            switch (selectedItem.Useable) {
                                case true:
                                    scene("\n\nAre you sure you want to use this item? ", false);
                                    yesView(11);
                                    break;
                                default:
                                    buttonVisibledec1 = false;
                                    decision1.setStyle("icon", null);
                                    break;
                            }
                        }
                        break;
                    case 11:
                        //Displays the scene for the appropriate key item and executes whatever effect the item is supposed to cause
                        scene("\t", true);
                        switch (selectedItem.Name) {

                        }
                        break;
                    case 12:
                        //leaves the key item inventory page and returns to the normal inventory
                        keyItems = false;
                        doInventory();
                        break;
                }
            }
        }

        //Displays your inventory
        public function doInventory():void {
            updateStats();
            clearView();
            appView(0);

            //Resets the selected item. selectedItem is used to tell the game which item you selected when it brings up the "Are you sure you want to use this item?" dialogue
            selectedItem = null;

            //Alphebetizes inventory
            invArray.sortOn("Name", Array.CASEINSENSITIVE);

            //Moves you to the correct state based on wether you're in combat or not
            if (inCombat()) {
                currentState = "combatInventory";
            }
            if (!inCombat()) {
                currentState = "inventory";
            }

            invView(1);

            listen = function ():void {
                switch (discarding) {
                    case true:
                        //Discards the item you've clicked on
                        switch (btnchc) {
                            case 1:
                            case 2:
                            case 3:
                            case 4:
                            case 5:
                            case 6:
                            case 7:
                            case 8:
                            case 9:
                                if (invArray[(btnchc - 1) + ((invPage - 1) * 9)] != null) {
                                    selectedItem = invArray[(btnchc - 1) + ((invPage - 1) * 9)];
                                    if (!inCombat()) {
                                        scene("", true);
                                    }
                                    if (inCombat()) {
                                        combatDialogue();
                                    }
                                    itemDescribe(selectedItem);
                                    scene("\nAre you sure you want to discard this item? ", false);
                                    yesView(11);
                                }
                                break;
                            case 11:
                                if (selectedItem != null) {
                                    removeItem(selectedItem);
                                    doInventory();
                                }
                                break;

                        }
                        break;
                    case false:
                        //Asks if you want to use the item you clicked on
                        switch (btnchc) {
                            case 1:
                            case 2:
                            case 3:
                            case 4:
                            case 5:
                            case 6:
                            case 7:
                            case 8:
                            case 9:
                                if (invArray[btnchc - 1 + ((invPage - 1) * 9)] != null) {

                                    //Records which item you've selected so that this function now which item you attempting to use
                                    selectedItem = invArray[btnchc - 1 + ((invPage - 1) * 9)];

                                    //Properly displays the item description based on if you're in combat or not
                                    if (!inCombat()) {
                                        scene("", true);
                                    }
                                    if (inCombat()) {
                                        combatDialogue();
                                    }
                                    itemDescribe(selectedItem);

                                    if (selectedItem.Useable) {
                                        scene("\nAre you sure you want to use this item? ", false);
                                        //Displays warning before you eat something that might cause you to explode
                                        if (selectedItem.eat + selectedItem.drink > remainingCapacity() && selectedItem.eat + selectedItem.drink > 0) {
                                            scene("You're already " + hungry() + ". ", false);
                                        }
                                        yesView(11);
                                    }
                                    if (!selectedItem.Useable) {
                                        clearButton(11);
                                    }
                                }
                                break;
                            case 11:
                                if (selectedItem != null) {
                                    //Removes a charge from the item and then executes the effects of the item, if you have an item selected
                                    if (selectedItem.Consume) {
                                        expendItem(selectedItem);
                                    }
                                    doUseItem(selectedItem);
                                }
                                break;
                            case 12:
                                //Switches to the key item inventory
                                discarding = false;
                                keyItems = true;
                                doKeyInventory();
                                break;
                        }
                        break;
                }
            };


            itemButtons();

            //Displays the switch to key items only if you're not in combat
            if (!inCombat()) {
                btntxt(12, "Important items");
            }
        }

        //Writes inventory to buttons based on which page number you're on
        public function itemButtons():void {
            for (i = (invPage - 1) * 9; i < invPage * 9; i++) {
                var tempItemWrite:Items = invArray[i];
                if (tempItemWrite != null) {
                    writeItems(i, tempItemWrite);
                }
            }
        }

        //Writes the items' names and charges remaining if the item has more than 1 charge
        public function writeItems(slot:int, item:Items):void {
            slot++;
            if (slot > 9) {
                slot %= 9;
            }
            if (slot == 0) {
                slot = 9;
            }
            if (item.Charges <= 1) {
                btntxt(slot, capFirst(item.Name));
            }
            if (item.Charges > 1) {
                btntxt(slot, capFirst(item.Name) + " x" + item.Charges);
            }
            iconItems(slot, item);
        }

        //Writes button icons based on input button number and input item
        public function iconItems(slot:int, item:Items):void {
            switch (item.type) {
                case null:
                    buttonIcons(slot, null);
                    break;
                default:
                    buttonIcons(slot, null);
                    break;
            }
        }

        //Moves inventory page up based on which state you are in
        public function doPageUp():void {
            if (currentState == "storage") {
                if (invPage > 1) {
                    invPage--;
                }
                doStorage();
            }
            if (currentState == "spells" || currentState == "combatSpells") {
                if (spellPage > 1) {
                    spellPage--;
                }
                doSpells();
            }
            else {
                if (invPage > 1) {
                    invPage--
                }
                if (currentState == "inventory" || currentState == "combatInventory") {
                    doInventory();
                }
                else if (inShop == true) {
                    doVendoring();
                }
            }
        }

        //Moves inventory page down based on which state you are in
        public function doPageDown():void {
            switch (currentState) {
                case "storage":
                    if (depositing == true) {
                        if (invPage < invArray.length / 9) {
                            invPage++;
                        }
                    }
                    else {
                        if (invPage < storageArray.length / 9) {
                            invPage++;
                        }
                    }
                    doStorage();
                    break;
                case "spells":
                case "combatSpells":
                    if (spellPage < spellArray.length / 9) {
                        spellPage++;
                    }
                    doSpells();
                    break;
                default:
                    if (invPage < invArray.length / 9) {
                        invPage++;
                    }
                    if (currentState == "inventory" || currentState == "combatInventory") {
                        doInventory();
                    }
                    else if (inShop == true) {
                        doVendoring();
                    }
                    break;
            }
        }

        //Displays the unequip choices
        public function doUnequip():void {
            invView(0);

            scene("You are wearing: \n", true);
            itemDescribe(TOP);
            scene("\n", false);
            itemDescribe(BTM);
            scene("\n", false);
            itemDescribe(ARM);
            scene("\n", false);
            itemDescribe(WEA);

            clearView();

            //Displays buttons of unequippable slots
            if (WEA.Name != "fists") {
                btntxt(1, "Weapon");
            }
            if (ARM.Name != "unarmored") {
                btntxt(3, "Armor");
            }
            if (TOP.Name != "naked chest") {
                btntxt(7, "Top");
            }
            if (BTM.Name != "naked legs") {
                btntxt(9, "Bottom");
            }
            returnView(12);

            listen = function ():void {
                if (btnchc == 1) {
                    tryUnequip("WEA");
                }
                if (btnchc == 3) {
                    tryUnequip("ARM");
                }
                if (btnchc == 7) {
                    tryUnequip("TOP");
                }
                if (btnchc == 9) {
                    tryUnequip("BTM");
                }
                if (btnchc == 12) {
                    doInventory();
                }
            }
        }

        //Function attempts to unequip input item
        public function tryUnequip(ID:String):void {
            clearView();

            if (invArray.length < maxInv) {
                //If you have room in you inventory, adds the unequipped item to your inventory and replaces the unequipped slot with the "no equipment" equipment, I.E. "bare hands" etc.
                var Pantsless:* = null;
                var Shirtless:* = null;
                var Armorless:* = null;
                var Weaponless:* = null;
                switch (ID) {
                    case "WEA":
                        if (WEA.Name != "fists") {
                            WEA.Charges = 1;
                            invArray.push(WEA);
                        }
                        WEA = ObjectUtil.copy(Weaponless) as Items;
                        break;
                    case "ARM":
                        if (ARM.Name != "unarmored") {
                            ARM.Charges = 1;
                            invArray.push(ARM);
                        }
                        ARM = ObjectUtil.copy(Armorless) as Items;
                        break;
                    case "TOP":
                        if (TOP.Name != "naked chest") {
                            TOP.Charges = 1;
                            invArray.push(TOP);
                        }
                        TOP = ObjectUtil.copy(Shirtless) as Items;
                        break;
                    case "BTM":
                        if (BTM.Name != "naked legs") {
                            BTM.Charges = 1;
                            invArray.push(BTM);
                        }
                        BTM = ObjectUtil.copy(Pantsless) as Items;
                        break;
                }
                doUnequip();
            }
            else {
                //Brings up discard options if you try to unequip an item while your inventory is full
                scene("\nYou don't have enough room in your inventory. Do you want to discard this item, or keep it equipped? ", false);
                clearDecisionView();
                btntxt(11, "Discard this");
                btntxt(13, "Keep Equipped");
                listen = function ():void {
                    var Pantsless:* = null;
                    var Shirtless:* = null;
                    var Armorless:* = null;
                    var Weaponless:* = null;
                    switch (btnchc) {
                        case 11:
                            switch (ID) {
                                case "WEA":
                                    WEA = ObjectUtil.copy(Weaponless) as Items;
                                    break;
                                case "ARM":
                                    ARM = ObjectUtil.copy(Armorless) as Items;
                                    break;
                                case "TOP":
                                    TOP = ObjectUtil.copy(Shirtless) as Items;
                                    break;
                                case "BTM":
                                    BTM = ObjectUtil.copy(Pantsless) as Items;
                                    break;
                            }
                            doUnequip();
                            break;
                        case 13:
                            doUnequip();
                            break;
                    }
                }
            }
        }

        //Displays storage dialogue
        public function doStorage():void {
            currentState = "storage";
            clearView();

            //displays the appropriate UI panels
            //GoldStorage.visible = false;
            var inventoryPanel:* = true;

            scene("\n\n", false);

            //Alphebetizes store items
            storageArray.sortOn("Name", Array.CASEINSENSITIVE);

            if (depositing == false) {
                scene("What would you like to withdraw? ", false);

                //Displays stored items to the buttons
                for (i = ((invPage - 1) * 9); i < invPage * 9; i++) {
                    var strItem:Items = storageArray[i];
                    if (strItem != null) {
                        writeItems(i, strItem);
                    }
                }

                listen = function ():void {
                    if (btnchc > 0 && btnchc < 10 && storageArray[(btnchc - 1) + ((invPage - 1) * 9)] != null) {
                        if (invArray.length < maxInv) {
                            //Adds selected item to your inventory and removes it from storage
                            getItem(storageArray[(btnchc - 1) + ((invPage - 1) * 9)]);
                            storageArray.splice((btnchc - 1) + ((invPage - 1) * 9), 1);
                            doStorage();
                        }
                        else {
                            //If there's no room in your inventory then nothing gets moved
                            doStorage();
                            scene("\nThere's not enough room in your inventory. ", false);
                        }
                    }
                }
            }
            else {
                scene("What would you like to deposit? ", false);

                //Displays your inventory to the buttons
                itemButtons();

                listen = function ():void {
                    if (btnchc > 0 && invArray[(btnchc - 1) + ((invPage - 1) * 9)] != null) {
                        if (storageArray.length < maxStorage) {
                            //Removes selected item from your inventory and adds it to storage
                            storageArray.push(invArray[(btnchc - 1) + ((invPage - 1) * 9)]);
                            removeItem(invArray[(btnchc - 1) + ((invPage - 1) * 9)]);
                            doStorage();
                        }
                        else {
                            //If your storage is full, then nothing gets moved
                            doStorage();
                            scene("\nThere's not enough room in your storage chest. ", false);
                        }
                    }
                }
            }

            //Lists storage contents
            scene("\n\nStorage contents" +
                    "\n~~~~~~~~~~~~~~~~~~~~~~" +
                    "\n<li>Gold: " + storageGold + "</li>", false);
            for (i = 1; i <= storageArray.length; i++) {
                var storageItem:Items = storageArray[i - 1];
                if (storageItem != null) {
                    scene("<li>", false);
                    if (storageItem.Charges <= 1) {
                        scene(capFirst(storageItem.Name), false)
                    }
                    else {
                        scene(capFirst(storageItem.Name) + "x" + storageItem.Charges, false)
                    }
                    scene("</li>", false);
                }
            }

        }

        //Displays dialogue for gold storage
        public function doStoreGold():void {
            clearView();

            //Displays appropriate UI panels
            //GoldStorage.visible = true;
            var inventoryPanel:* = false;
            //depositAmount.text = "0";
            //depositAmount.setFocus();
            //depositAmount.selectAll();
        }

        //Adds/removes gold from storage
        public function confirmGold():void {

            //Converts the number typed by the player into an actual integer
            var depositAmount:* = null;
            var goldAmount:int = parseInt(depositAmount.text);

            if (depositing == false) {
                //Removes gold to storage and adds it to your gold total
                if (goldAmount > storageGold) {
                    goldAmount = storageGold;
                }
                GLD += goldAmount;
                storageGold -= goldAmount;
            }
            else {
                //Removes gold from your character and adds it to storage
                if (goldAmount > GLD) {
                    goldAmount = GLD
                }
                GLD -= goldAmount;
                storageGold += goldAmount;
            }
            doStorage();
        }

        //Stores or removes all gold
        public function doAllGold():void {
            if (depositing == false) {
                GLD += storageGold;
                storageGold = 0;
            }
            else {
                storageGold += GLD;
                GLD = 0;
            }
            doStorage();
        }

        //Toggles between depositing/withdrawing items/gold from storage
        public function toggleDeposit():void {
            //Toggles "depositing" tag
            depositing = !depositing;
            //Updates the label on the "depositing/withdrawing" button
            depositLabel = (depositing) ? "Depositing" : "Withdrawing";
            //Moves you to page 1 of your storage
            invPage = 1;
            doStorage();
        }

        //Toggles between discarding/using items in your inventory
        public function toggleDiscard():void {
            //Toggles "discarding" tag
            discarding = !discarding;
            //Updates the label on the "discarding/withdrawing" button
            discardLabel = (discarding) ? "Discarding" : "Using";
            //Moves you to page 1 of your inventory
            invPage = 1;
            doInventory();
        }

        //Displays a shop's buying/selling dialogue/buttons
        public function doShop():void {
            //moves you to page 1 of the stores inventory when you first enter the store
            if (!inShop) {
                invPage = 1;
            }
            //Displays the vendor's buying scene
            scene(Vendor.Buying + "\n", true);
            inShop = true;
            clearView();
            appView(0);
            //Alphebetizes the vendors inventory
            Vendor.vendArray.sortOn("Name", Array.CASEINSENSITIVE);

            //Displays item names and prices
            for (i = 0; i < Vendor.vendArray.length; i++) {
                var storeCosts:Items = Vendor.vendArray[i];
                if (storeCosts != null) {
                    scene("<li>" + capFirst(storeCosts.Name) + "......" + buyValue(storeCosts) + " gold</li>", false);
                }
            }
            scene("\n", false);

            //Displays the vendors inventory to the buttons
            for (i = 0; i < 9; i++) {
                var inventoryItem:Items = Vendor.vendArray[i + (9 * (invPage - 1))];
                if (inventoryItem != null) {
                    writeItems(i, inventoryItem);
                }
            }

            //Page rotation button
            if (Vendor.vendArray.length > 9) {
                btntxt(11, "More items");
            }

            btntxt(12, "Sell");
            leaveButton(13);

            listen = function ():void {
                switch (btnchc) {
                    case 11:
                        //Moves to the previous page of the shop's inventory
                        switch (invPage < Math.ceil(Vendor.vendArray.length / 9)) {
                            case true:
                                invPage++;
                                break;
                            default:
                                invPage = 1;
                                break;
                        }
                        doShop();
                        break;
                    case 12:
                        //Switch to "sell" mode
                        doVendoring();
                        break;
                    case 13:
                        //Leaves the store
                        leaveStore();
                        break;
                    default:
                        //Attempt to buy the item you clicked on
                        if (Vendor.vendArray[btnchc - 1 + (9 * (invPage - 1))] != null) {
                            tryBuyItem(Vendor.vendArray[btnchc - 1 + (9 * (invPage - 1))]);
                        }
                        break;
                }
            }
        }

        //Item buying confirmation
        public function tryBuyItem(ID:Items):void {
            doShop();

            itemDescribe(ID);
            scene("\n", false);
            if (invArray.length >= maxInv) {
                scene("But you have no room. ", false);
            }
            else if (GLD >= buyValue(ID)) {
                //Asks you if you want to buy the item if you have enough gold and room in your inventory
                scene("Are you sure you want to buy this? ", false);
                choiceButton();
                clrchc();
                listen = function ():void {
                    if (btnchc == 11) {
                        doBuyItem(ID);
                    }
                    if (btnchc == 13) {
                        doShop();
                        scene("\"Suit yourself.\" ", false);
                    }
                }
            }
            else if (GLD < buyValue(ID)) {
                //Stops you from buying the item if you don't have enough money and displays the vendors scene for when you're too poor
                doShop();
                scene(Vendor.NoMoney, false);
            }
        }

        //Buys the input item
        public function doBuyItem(ID:Items):void {
            doShop();
            scene("\n" + Vendor.Bought, false);
            getItem(ID);
            doGold(-buyValue(ID));
        }

        //Display sellable items
        public function doVendoring():void {
            scene(Vendor.Selling + "\n", true);

            //Writes the items you can sell to the buttons
            for (i = 1; i <= invArray.length; i++) {
                var inventoryItem:Items = invArray[i - 1];
                if (inventoryItem != null) {
                    scene("\n" + capFirst(inventoryItem.Name) + "......" + sellValue(inventoryItem) + " gold", false);
                }
            }
            clearView();
            appView(0);
            returnView(12);
            pageView();

            listen = function ():void {
                if (btnchc == 11) {
                    doPageUp();
                }
                if (btnchc == 13) {
                    doPageDown();
                }
                if (btnchc == 12) {
                    //Switches back to buying mode
                    invPage = 1;
                    doShop();
                }
                //Attempts to sell the selected item
                else if (btnchc > 0 && btnchc < 10 && invArray[(btnchc - 1) + ((invPage - 1) * 9)] != null) {
                    trySellItem(invArray[(btnchc - 1) + ((invPage - 1) * 9)]);
                }
            };
            //Displays the items you can sell
            itemButtons();
        }

        //Item selling confirmation
        public function trySellItem(ID:Items):void {
            scene("\n" + ID.Description + "Are you sure you want to sell this for " + sellValue(ID) + " gold? ", false);
            choiceButton();
            listen = function ():void {
                if (btnchc == 11) {
                    doSellItem(ID);
                }
                if (btnchc == 13) {
                    doVendoring();
                }
            }
        }

        //Sells the input item
        public function doSellItem(ID:Items):void {
            removeItem(ID);
            doVendoring();
            scene("\n" + Vendor.Sold, false);
            doGold(sellValue(ID));
        }

        //Enters a store
        public function enterStore(ID:Vendors):void {
            Vendor = ObjectUtil.copy(ID) as Vendors;
            Vendor.StoreExit = ID.StoreExit;
            doShop();
        }

        //Leaves store and displays text for leaving
        public function leaveStore():void {
            inShop = false;
            locationTravel(Vendor.StoreExit);
            scene("\t" + Vendor.Leaving, true);
        }

        //Returns the buy value of item
        public function buyValue(ID:Items):int {
            var tempValue:Number = ID.Value;
            if (ID.Charges > 0) {
                tempValue = ID.Charges * ID.Value;
            }
            return Math.ceil(tempValue);
        }

        //Returns the sell value of input item
        public function sellValue(item:Items):int {
            return Math.floor(buyValue(item) * .5);
        }

        //Tests whether the character should be alive or not
        public function alive():Boolean {
            if (HEA >= 1) {
                return true;
            }
            else {
                return false;
            }
        }

        //Tests a players skills minus opposing skills against a d100
        public function testSkill(player:Number, enemy:Number):Boolean {
            var succeeded:Boolean = false;
            if (d100() <= player - enemy) {
                succeeded = true;
            }
            return succeeded;
        }

        //Tests a player's skill with a maximum and minimum chance
        public function testSkillRange(player:Number, enemy:Number, minChance:int, maxChance:int):Boolean {
            var successChance:Number = player - enemy;
            if (successChance < minChance) {
                successChance = minChance;
            }
            if (successChance > maxChance) {
                successChance = maxChance;
            }
            return testSkill(successChance, 0);
        }

        //Brings up the options dialogue and allows the player to change options
        public function changeOptions():void {
            clearView();
            appView(0);

            currentState = "options";
            miscScene("<b>Options</b>" +
                    "\n~~~~~~~~~~~~~~~~~~~~~~", true);

            //Measurement system
            miscScene("<li>Measurement system: ", false);
            if (optionsMetric) {
                miscScene("Metric</li>", false);
            }
            if (optionsImperial) {
                miscScene("Imperial</li>", false);
            }

            //Popping
            miscScene("<li>Allow bursting: " + optionsPopping + "</li>", false);

            //Character description length
            miscScene("<li>Long player description: " + optionsDescription + "</li>", false);

            //Allowed random genders
            miscScene("<li>Allow random male NPCs: " + optionsMales + "</li>", false);
            miscScene("<li>Allow random female NPCs: " + optionsFemales + "</li>", false);

            //Goes to cheat menu
            miscScene("<li>Go to cheat menu</li>", false);


            //Buttons
            btntxt(1, "Metric/Imperial");
            btntxt(2, "Popping");
            btntxt(3, "Long player descriptions");
            btntxt(4, "Allow random males");
            btntxt(5, "Allow random females");
            btntxt(6, "Cheats");

            listen = function ():void {
                if (btnchc == 1) {
                    optionsMetric = !optionsMetric;
                    optionsImperial = !optionsImperial;
                    changeOptions();
                }
                if (btnchc == 2) {
                    optionsPopping = !optionsPopping;
                    changeOptions();
                }
                if (btnchc == 3) {
                    optionsDescription = !optionsDescription;
                    changeOptions();
                }
                if (btnchc == 4) {
                    optionsMales = !optionsMales;
                    changeOptions();
                }
                if (btnchc == 5) {
                    optionsFemales = !optionsFemales;
                    changeOptions();
                }
                if (btnchc == 6) {
                    currentState = "cheat";
                }

            }
        }

        /*        //Inputs cheat option
                public function acceptCheat():void {
                    if (cheatStrength.text != "") {
                        bSTR = parseInt(cheatStrength.text);
                    }
                    if (cheatAgility.text != "") {
                        bAGI = parseInt(cheatAgility.text);
                    }
                    if (cheatIntelligence.text != "") {
                        bINT = parseInt(cheatIntelligence.text);
                    }
                    if (cheatEndurance.text != "") {
                        bEND = parseInt(cheatEndurance.text);
                    }
                    if (cheatStomach.text != "") {
                        bSTO = parseInt(cheatStomach.text);
                    }
                    if (cheatHealth.text != "") {
                        bmaxHEA = parseInt(cheatHealth.text);
                    }
                    if (cheatFat.text != "") {
                        FAT = parseInt(cheatFat.text);
                    }
                    if (cheatGold.text != "") {
                        GLD = parseInt(cheatGold.text);
                    }
                    updateStats();
                    changeOptions();
                }*/

        //Returns your maximum surviveable fullness
        public function maximumFullness():Number {
            fixFull();
            var testFullness:int = (maxFUL / 100) * STO;
            var testHealth:int = ((maxFUL - (testFullness / STO)) / (maxFUL - 100)) * (bmaxHEA + modHealth());
            if (testHealth <= 0) {
                testFullness--;
            }
            return testFullness;
        }

        //Returns you remaining survivable capacity
        public function remainingCapacity():Number {
            return maximumFullness() - ATE;
        }

        //Inflates you to the point of floating
        public function inflateToFloating():void {
            if (weight() > 0) {
                doInflate(weight() * .5, -20 - weight());
            }
        }

        //Fills you past your maximum fullness
        public function stuffToBursting():void {
            var tempInt:Number = remainingCapacity() + 1;
            if (tempInt > 0) {
                doConsume(tempInt, 0, tempInt * .5);
            }
        }

        //Fills you just below maximum fullness
        public function stuffToAlmostBursting():void {
            var almostBursting:Number = remainingCapacity();
            if (almostBursting > 0) {
                doConsume(almostBursting, 0, almostBursting * .5);
            }
        }

        //Sleep function
        public function doSleep():void {
            doRest();
            doRest();
            doRest();
            doRest();
            doRest();
            doRest();
            doRest();
            doRest();
        }

        //Resting function
        public function doRest():void {
            doTime(60);
            doStamina(25);
            doHealth(END);
            updateStats();
            //Randomly starts a fight if you rest in a dangerous area
            var wilderness:LocationType = null;
            if (location.type == wilderness && location.enemies != null) {
                if (dXY(1, 5) == 1) {
                    appView(0);
                    combatEvent(location.enemies[dXY(0, location.enemies.length - 1)]);
                    scene("\tYou are awoken from your sleep by " + enemyt.article + " " + enemyt.name + "! ", true);
                }
            }
        }

        //Brings up the area description
        public function doArea():void {
            currentState = "surroundings";
            miscScene("\t" + location.Description, true);
        }

        //Adds gold and prevents gold from going into negative numbers
        public function doGold(ID:int):void {
            GLD += ID;
            if (ID != 0) {
                if (ID > 0) {
                    scene("<li>+" + ID + " gold!</li>", false);
                }
                if (ID < 0) {
                    scene("<li>" + ID + " gold!</li>", false);
                }
            }
            if (GLD < 0) {
                GLD = 0;
            }
        }

        //Adds XP and checks for level up
        public function doXP(gained:int):void {
            if (gained > 0) {
                scene("<li>+" + gained + " XP!</li>", false);
            }
            while (gained > 0) {
                XP += gained;
                gained = 0;
                if (XP >= XPtoLevel) {
                    scene("<li>Level up!</li>", false);
                    gained = XP - XPtoLevel;
                    XP = 0;
                    XPtoLevel = 100 + ((LVL - 1) * 10);
                    LVL++;
                    LVLup++;
                    bmaxHEA += Math.floor(bEND * .1);
                    updateStats();
                    HEA = maxHEA;
                }
            }
        }

        //Activates level up dialogue
        public function doLevel():void {
            currentState = "levelUp";
            scene("You've gained a level! Choose a stat to increase. ", true);
            clearView();
            btntxt(1, "Strength");
            btntxt(2, "Agility");
            btntxt(3, "Endurance");
            btntxt(4, "Intelligence");
            btntxt(5, "Stomach");
            listen = function ():void {
                var levelStats:Array = [0, 0, 0, 0, 0];
                levelStats.splice(btnchc - 1, 1, 5);
                chgStats(levelStats[0], levelStats[1], levelStats[2], levelStats[3], levelStats[4]);
                LVLup--;
                currentState = "default";
                general();
            }
        }

        //Returns weight of input integer as a string based on player settings
        public function sayWeight(weight:Number):String {
            if (optionsMetric == false) {
                return (int(weight) + " pounds");
            }
            else {
                return (int(weight * 0.453592) + " kilograms");
            }
        }

        //Returns distance of input number based on player settings
        public function sayDistance(inches:int):String {
            var returnDistance:String = Math.floor(inches) + " inches";
            var centimeters:int = Math.round(inches * 2.54);

            switch (optionsImperial) {
                case true:
                    if (inches == 12) {
                        returnDistance = "a foot";
                    }
                    if (inches > 24) {
                        if (inches % 12 == 0) {
                            returnDistance = Math.floor(inches / 12) + " feet";
                        }
                        if (inches % 12 != 0) {
                            returnDistance = Math.floor(inches / 12) + "'" + (inches % 12) + "\"";
                        }
                    }
                    if (inches == 1) {
                        returnDistance = "1 inch";
                    }
                    break;
                case false:
                    if (centimeters > 100) {
                        returnDistance = (centimeters / 100) + " meters";
                    }
                    else {
                        returnDistance = "" + centimeters;
                        if (centimeters == 1) {
                            returnDistance += " centimeter";
                        }
                        else {
                            returnDistance += " centimeters";
                        }
                    }
                    break;
            }
            return (returnDistance);
        }

        //Returns the description for how you walk based on your weight
        public function walk():String {
            var tempStr:String = "walk";
            var tempInt:int = ATE + (FAT * .4);
            if (tempInt > 100) {
                tempStr = "wobble";
            }
            if (tempInt > 150) {
                tempStr = "waddle";
            }
            if (tempInt > 200) {
                tempStr = "lumber";
            }
            if (testImmobileClose() == true) {
                tempStr = "slowly " + tempStr;
            }
            return tempStr;
        }

        public function walking():String {
            var tempStr:String = "walking";
            var tempInt:int = ATE + (FAT * .4);
            if (tempInt > 100) {
                tempStr = "wobbling";
            }
            if (tempInt > 150) {
                tempStr = "waddling";
            }
            if (tempInt > 200) {
                tempStr = "lumbering";
            }
            if (testImmobileClose() == true) {
                tempStr = "slowly " + tempStr;
            }
            return tempStr;
        }

        //Displays your characters appearance
        public function doAppearance():void {
            currentState = "appearance";
            updateStats();

            //Name
            miscScene("<b>" + playerName + "</b>,\n\t", true);
            //Species
            miscScene("You are a " + playerGender.name + " " + playerSpecies.name + " ", false);
            //Weight
            miscScene("that weighs " + sayWeight(weight()), false);
            //Height
            miscScene(" and is " + sayDistance(playerHeight) + " tall. ", false);
            //Physical description
            miscScene("You have " + muscles() + " muscles under your " + fatness() + " body and have " + playerSpecies.furBack + " colored " + playerSpecies.fur + ". " +
                    "Your " + playerSpecies.furBelly + " " + playerSpecies.furred + " stomach is " + waist() + " and sticks out " + sayDistance(waistDiameter()) + " and you are " + hungry() + ". ", false);


            //Equipment
            miscScene("\n~~~~~~~~~~~~~~~~~~~~~~", false);
            miscScene("\n<b>You are wearing:</b> ", false);
            miscScene("<li>", false);
            //Shirt
            miscScene(capFirst(TOP.Name) + "</li>\t\t", false);
            if (TOP.Popped == false) {
                miscScene(TOP.Description, false);
            }
            if (TOP.Popped == true) {
                miscScene(TOP.PoppedDescription, false);
            }
            miscScene("<li>", false);
            //Pants
            miscScene(capFirst(BTM.Name) + "</li>\t\t", false);
            if (BTM.Popped == false) {
                miscScene(BTM.Description, false);
            }
            if (BTM.Popped == true) {
                miscScene(BTM.PoppedDescription, false);
            }
            //Armor
            miscScene("<li>" + capFirst(ARM.Name) + "</li>" +
                    "\t\t" + ARM.Description +
                    "\n\t\t<i>" + ARM.Defense + " defense</i>", false);
            //Weapon
            var damageScaleAmount:Number = 0.4;
            var damageScaleStat:String = "STR";
            if (WEA.damageScaling != 0) {
                damageScaleAmount = WEA.damageScaling;
            }
            if (WEA.damageStat != null) {
                damageScaleStat = WEA.damageStat;
            }
            miscScene("<li>" + capFirst(WEA.Name) + "</li>" +
                    "\t\t" + WEA.Description +
                    "\n\t\t<i>Deals " + WEA.WEAd + "d" + WEA.WEAr + " +" + damageScaleAmount * 100 + "% " + damageScaleStat + " " + WEA.damageType.name + " damage ", false);
            if (WEA.damageStat == "INT" && WEA.damageScaling > 0.4) {
                miscScene("\n\t\tIncreases spell damage/healing by " + WEA.damageScaling * 100 + "% INT ", false);
            }
            miscScene("</i> ", false);

            //Status effects
            miscScene("\n~~~~~~~~~~~~~~~~~~~~~~" +
                    "\n<b>Status effects:</b> ", false);
            var statusText:String = "";
            if (STA <= 5) {
                statusText += "<li>STA low</li>";
            }
            if (Calories <= 0) {
                statusText += "<li>Calories low</li>";
            }
            if (FUL > 100) {
                statusText += "<li>Very full</li>";
            }
            if (testImmobileClose() == true) {
                "<li>Almost imobile</li>", false;
            }
            if (statusWellFed > 0) {
                statusText += "<li>Well fed</li>";
            }

            if (statusSTRBuffPower > 0) {
                statusText += "<li>STR+</li>";
            }
            if (statusSTRBuffPower < 0) {
                statusText += "<li>STR-</li>";
            }

            if (statusAGIBuffPower > 0) {
                statusText += "<li>AGI+</li>";
            }
            if (statusAGIBuffPower < 0) {
                statusText += "<li>AGI-</li>";
            }

            if (statusINTBuffPower > 0) {
                statusText += "<li>INT+</li>";
            }
            if (statusINTBuffPower < 0) {
                statusText += "<li>INT-</li>";
            }

            if (statusENDBuffPower > 0) {
                statusText += "<li>END+</li>";
            }
            if (statusENDBuffPower < 0) {
                statusText += "<li>END-</li>";
            }

            if (statusMANABuffPower > 0) {
                statusText += "<li>MANA+</li>";
            }
            if (statusMANABuffPower < 0) {
                statusText += "<li>MANA-</li>";
            }

            if (statusSTOBuffPower > 0) {
                statusText += "<li>STO+</li>";
            }
            if (statusSTOBuffPower < 0) {
                statusText += "<li>STO-</li>";
            }

            if (statusBloatVenomPower > 0 && statusBloatVenom > 0) {
                statusText += "<li>Bloat venomed</li>";
            }
            if (statusText != "") {
                miscScene(statusText, false);
            }
            if (statusText == "") {
                miscScene("<li>None!</li>", false)
            }

            //Quests
            miscScene("~~~~~~~~~~~~~~~~~~~~~~" +
                    "\n<b>Quests:</b> ", false);
            var questLog:Array = [];
            for (var j:int = 0; j < questArray.length; j++) {
                var questLogTest:Quests = questArray[j];
                if (questLogTest.visible == true && questLogTest.completed == false) {
                    questLog.push(questLogTest);
                }
            }
            if (questLog.length == 0 || questArray == null) {
                miscScene("\nNone!", false);
            }
            if (questLog.length > 0) {
                for (i = 0; i < questLog.length; i++) {
                    miscScene(questDescriptionDisplay(questLog[i]), false);
                }
            }
        }

        //Displays quest description
        public function questDescriptionDisplay(inputQuest:Quests):String {
            var questText:String = "";
            //Quest name
            questText += "<li><u>" + inputQuest.questName + "</u>";
            //Quest goal
            if (inputQuest.questTarget == null && inputQuest.questGoal > 0) {
                questText += " <i>(";
                if (inputQuest.questProgress < inputQuest.questGoal) {
                    questText += inputQuest.questProgress + "/" + inputQuest.questGoal;
                }
                if (inputQuest.questProgress >= inputQuest.questGoal) {
                    questText += "Complete!";
                }
                questText += ")</i>";
            }
            if (inputQuest.questTarget != null) {
                questText += " <i>(" + capFirst(inputQuest.questTarget.Name) + ")</i>";
            }
            //Quest description
            questText += "</li>\t\t" + inputQuest.questDescription;

            return questText;
        }

        //Calculates total body weight
        public function weight():Number {
            return (bodyMass() + Eaten + Drank + InflatedMass)
        }

        //Calculates total body weight not including what you're consumed
        public function bodyMass():Number {
            return ((bSTR * 3) + FAT + 40)
        }

        //Calculates and returns waist size in inches
        public function waistDiameter():int {
            var tempInt:int = 2 * Math.pow(((90 * (ATE + ((FAT + tenemyFATdebuff) * .21))) / (4 * Math.PI)), (1 / 3)) - 5;
            if (tempInt <= 0) {
                tempInt = 0;
            }
            return (tempInt);
        }

        //Describes how fat you are
        public function fatness():String {
            var tempStr:String = "error " + FAT;
            //you look
            if (FAT <= 1) {
                tempStr = "fatless";
            }
            else if (FAT <= 10) {
                tempStr = "lean";
            }
            else if (FAT <= 45) {
                tempStr = "average";
            }
            else if (FAT <= 60) {
                tempStr = "chubby";
            }
            else if (FAT <= 75) {
                tempStr = "pudgy";
            }
            else if (FAT <= 90) {
                tempStr = "fat";
            }
            else if (FAT <= 115) {
                tempStr = "doughy";
            }
            else if (FAT <= 140) {
                tempStr = "rotund";
            }
            else if (FAT <= 170) {
                tempStr = "squishy";
            }
            else if (FAT <= 210) {
                tempStr = "obese";
            }
            else if (FAT <= 270) {
                tempStr = "porcine";
            }
            else if (FAT <= 400) {
                tempStr = "incredibly obese";
            }
            else if (FAT <= 700) {
                tempStr = "elephantine";
            }
            else {
                tempStr = "whale-like";
            }
            return tempStr;
        }

        //Describes how strong you are
        public function muscles():String {
            var tempStr:String;
            var tempInt:int = STR - FAT;
            //your muscles are
            if (tempInt <= 5) {
                tempStr = "unnoticeable";
            }
            else if (tempInt <= 10) {
                tempStr = "barely noticeable";
            }
            else if (tempInt <= 20) {
                tempStr = "average";
            }
            else if (tempInt <= 30) {
                tempStr = "well-defined";
            }
            else if (tempInt <= 40) {
                tempStr = "impressive";
            }
            else if (tempInt <= 50) {
                tempStr = "rippling";
            }
            else if (tempInt <= 60) {
                tempStr = "tremendous";
            }
            else if (tempInt <= 70) {
                tempStr = "bodybuilderesque";
            }
            else if (tempInt <= 80) {
                tempStr = "gargantuan";
            }
            else {
                tempStr = "mountain-like";
            }
            return tempStr;
        }

        //Describes how large your waist is
        public function waist():String {
            //your waist is
            var tempStr:String;
            var tempInt:int = waistDiameter();
            if (tempInt <= 1) {
                tempStr = "flat";
            }
            else if (tempInt <= 3) {
                tempStr = "small";
            }
            else if (tempInt <= 4) {
                tempStr = "slightly rounded";
            }
            else if (tempInt <= 5) {
                tempStr = "rounded";
            }
            else if (tempInt <= 6) {
                tempStr = "swollen";
            }
            else if (tempInt <= 7) {
                tempStr = "bulging";
            }
            else if (tempInt <= 10) {
                tempStr = "basketball sized";
            }
            else if (tempInt <= 17) {
                tempStr = "beachball sized";
            }
            else if (tempInt <= 24) {
                tempStr = "too big to reach around";
            }
            else if (tempInt <= 30) {
                tempStr = "person sized";
            }
            else if (tempInt <= 55) {
                tempStr = "enormous";
            }
            else {
                tempStr = "big enough to reach the ground";
            }
            return tempStr;
        }

        //Describes how hungry you are
        public function hungry():String {
            var tempStr:String;
            fixFull();
            //you are
            if (FUL <= 10) {
                tempStr = "starving";
            }
            else if (FUL <= 25) {
                tempStr = "hungry";
            }
            else if (FUL <= 45) {
                tempStr = "not very hungry";
            }
            else if (FUL <= 55) {
                tempStr = "sated";
            }
            else if (FUL <= 65) {
                tempStr = "well fed";
            }
            else if (FUL <= 75) {
                tempStr = "pretty full";
            }
            else if (FUL <= 85) {
                tempStr = "stuffed";
            }
            else if (FUL <= 100) {
                tempStr = "bloated";
            }
            else if (FUL <= 110) {
                tempStr = "ready to pop";
            }
            else {
                tempStr = "on the verge of bursting";
            }
            return tempStr;
        }

        //Returns the name of fatness tier
        public function bodyFatTier():String {
            var tempFatTier:String = "";
            if (FAT <= 25) {
                tempFatTier = "malnourished";
            }
            else if (FAT <= 75) {
                tempFatTier = "healthy";
            }
            else if (FAT <= 150) {
                tempFatTier = "robust";
            }
            else if (FAT <= 250) {
                tempFatTier = "overweight";
            }
            else if (FAT <= 400) {
                tempFatTier = "chubby";
            }
            else if (FAT <= 600) {
                tempFatTier = "corpulent";
            }
            else if (FAT <= 900) {
                tempFatTier = "obese";
            }
            else if (FAT <= 1300) {
                tempFatTier = "morbidly obese";
            }
            else if (FAT <= 1800) {
                tempFatTier = "massive";
            }
            else if (FAT <= 2300) {
                tempFatTier = "spherical";
            }
            else if (FAT <= 3000) {
                tempFatTier = "mountainous";
            }
            else if (FAT > 3000) {
                tempFatTier = "colossal";
            }
            return tempFatTier;
        }

        //Returns name of strength tier
        public function bodyStrengthTier():String {
            var tempStrengthTier:String = "";
            var strengthTier:Number = (STR + STR + AGI + END) / 4.2;

            if (strengthTier <= 50) {
                tempStrengthTier = "regular";
            }
            else if (strengthTier <= 150) {
                tempStrengthTier = "athletic";
            }
            else if (strengthTier <= 250) {
                tempStrengthTier = "muscular";
            }
            else if (strengthTier > 250) {
                tempStrengthTier = "bodybuilder";
            }
            return tempStrengthTier;
        }

        //import org.hamcrest.collection.hasItem;

        //Returns wether your character is in combat or not. Important for how other functions work
        public function inCombat():Boolean {
            if (currentState == "combat" || currentState == "combatInventory") {
                return true;
            }
            else {
                return false;
            }
        }

        //Displays the description of your enemy and adds the page break
        public function combatDialogue():void {
            scene("\t" + enemyt.description, true);
            scene("\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n", false);
        }

        //Displays combat buttons
        public function combatButtons():void {
            clearView();

            //Attack/struggle button
            if (grapple > 0) {
                btntxt(1, "Struggle");
            }
            if (grapple <= 0) {
                btntxt(1, "Attack");
            }

            //Item button
            if (grapple <= 0) {
                btntxt(2, "Item");
            }

            //Run button (if you're capable of running)
            if (enemy.getEvasionRoll() && grapple <= 0) {
                btntxt(3, "Run");
            }

            //Spells button (if you know any spells)
            if (spellArray.length != 0 && grapple <= 0) {
                btntxt(4, "Spells");
            }

            //Wait button
            btntxt(5, "Wait");

            //Devour button (if enemy is devourable)
            if (enemyt.voreable == true && enemyt.weight <= maximumFullness() && grapple <= 0) {
                btntxt(7, "Devour");
            }

            //Submit button
            btntxt(8, "Submit");

            listen = function ():void {

                combatDialogue();
                //removeArrows();

                switch (btnchc) {
                    case 1:
                        //Fight against being grappled
                        if (grapple > 0) {
                            var highestStat:int = STR;
                            if (INT > highestStat) {
                                highestStat = INT
                            }
                            if (AGI > highestStat) {
                                highestStat = AGI
                            }
                            grapple -= highestStat;
                            if (grapple < 0) {
                                grapple = 0;
                            }

                            scene("<li><b>Struggle</b></li>", false);
                            switch (grapple) {
                                case 0:
                                    combatButtons();
                                    scene(enemyt.grappleEscapeSucceed + "\n", false);
                                    playerAttack();
                                    break;
                                default:
                                    scene(enemyt.grappleEscapeFail + "\n", false);
                                    if (enemyStunEffect() == false) {
                                        enemyAttack();
                                    }
                                    enemyBurnEffect();
                                    break;
                            }
                        }
                        //Attacks with your equipped weapon
                        else {
                            //Tests wether you or your opponent should go first
                            switch (AGI + INT >= enemyt.AGI + enemyt.INT || enemySlowEffect()) {
                                case true:
                                    if (playerStatusEffect() == false) {
                                        playerAttack();
                                    }
                                    scene("\n", false);
                                    if (eHEA > 0 && enemyStunEffect() == false) {
                                        enemyAttack();
                                    }
                                    enemyBurnEffect();
                                    break;
                                default:
                                    if (enemyStunEffect() == false) {
                                        enemyAttack();
                                    }
                                    enemyBurnEffect();
                                    scene("\n", false);
                                    if (HEA > 0 && grapple <= 0 && currentState != "defeated" && playerStatusEffect() == false) {
                                        playerAttack();
                                    }
                                    break;
                            }
                        }
                        break;
                    case 2:
                        //Displays your inventory
                        doInventory();
                        break;
                    case 3:
                        //Attempt to run from your opponent
                        scene("<li><b>Run</b></li>", false);
                        switch (enemyt.escapable) {
                            case true:
                                switch (testSkillRange(25 + AGI + INT, enemyt.AGI + enemyt.INT, 10, 75)) {
                                    case true:
                                        scene(enemyt.playerEscape, false);
                                        currentState = "default";
                                        endCombat();
                                        nextButton();
                                        break;
                                    default:
                                        scene(enemyt.playerEscapeFail + "\n", false);
                                        if (enemyStunEffect() == false) {
                                            enemyAttack();
                                        }
                                        enemyBurnEffect();
                                        break;
                                }
                                break;
                            case false:
                                scene(enemyt.playerEscape + "<i>(You can't escape this fight)</i> ", false);
                                if (enemyStunEffect() == false) {
                                    enemyAttack();
                                }
                                enemyBurnEffect();
                                break;
                        }
                        break;
                    case 4:
                        //Displays your spell menu
                        doSpells();
                        break;
                    case 5:
                        //Waits for you enemy's attack
                        scene("<li><b>Wait</b></li>", false);
                        doStamina(15);
                        playerStatusEffect();
                        if (enemyStunEffect() == false) {
                            enemyAttack();
                        }
                        enemyBurnEffect();
                        break;
                    case 7:
                        //Attempts to devour your enemy
                        scene("<li><b>Devour</b></li>", false);
                        if (playerStatusEffect() == false) {
                            playerVore();
                        }
                        enemyBurnEffect();
                        if (inCombat() && eHEA > 0 && enemyStunEffect() == false) {
                            enemyAttack();
                        }
                        break;
                    case 8:
                        //Surrender to your opponent
                        scene("<li><b>Surrender</b></li>", false);
                        surrender = true;
                        enemyAttack();
                        break;
                }
            };
            //Updates your stats after whatever events happened from that combat round
            updateStats();
        }

        //Function that starts a combat round
        public function doBattle():void {
            appView(0);
            if (!inCombat()) {
                //Does the initial combat setup (probably redundant with the startFight function)
                eHEA = enemyt.maxHEA;
                grapple = 0;
                if (enemyt.introduction != "") {
                    scene(enemyt.introduction, true);
                }
                else {
                    scene(enemyt.description, true);
                }
            }
            if (inCombat()) {
                //Once you're in combat it will just display the normal combat message
                combatDialogue();
            }
            voreing = false;
            surrender = false;
            currentState = "combat";
            combatButtons();
        }

        //Starts the initial fight setup and setups the next button that leads into the fight proper
        public function startFight():void {
            eHEA = enemyt.maxHEA;
            eMANA = enemyt.maxMANA;
            grapple = 0;
            currentState = "combat";
            clearView();
            appView(0);
            btntxt(12, "Fight!");
            listen = function ():void {
                if (btnchc == 12) {
                    doNext(null);
                }
            }
        }

        //Resets all temporary combat modifiers to their default value
        public function endCombat():void {
            surrender = false;
            voreing = false;
            grapple = 0;
            rmvTempStats();
            eStatusBurnPower = 0;
            eStatusBurnTime = 0;
            eStatusStunTime = 0;
            eStatusSlowTime = 0;
            eStatusSoakTime = 0;
        }

        //Rewards you for winning a battle and displays the inut victory text
        public function winBattle(winText:String):void {
            scene("<li><u>Victory!</u></li>", false);
            if (winText != "") {
                scene(winText, false);
            }
            currentState = "default";
            endCombat();
            doXP(enemyt.XP);
            if (enemyt.GLD > 0) {
                doGold(dXY((enemyt.GLD * 0.8) + 1, (enemyt.GLD * 1.2) - 1));
            }
            nextView();
            listen = function ():void {
                if (btnchc == 12) {
                    //If the enemy was part of a larger event, then it will activate the next step in that event, otherwise it does the default end combat function
                    if (!enemy.getEvasionRoll()) {
                        doEvent(enemy);
                    }
                    if (enemy.getEvasionRoll()) {
                        doNext(null);
                    }
                }
            };
            //Tests to see if your enemy should drop an item and gives it to the player
            if (enemyt.item != null && d100() <= enemyt.itemChance && voreing == false) {
                scene("\n\t" + enemyt.itemFound, false);
                getItem(enemyt.item);
            }

            //Advances quests where applicable
            switch (enemy) {

            }
        }

        //Starts a combat event with the input enemy
        public function combatEvent(fighting:Enemies):void {
            setEnemy(fighting);
            startFight();
        }

        //Performs all the functions that happen when the player is defeated
        public function doDefeat():void {

            //Returns player to the default state and sends them to the appropiate location depending on type of defeat
            endEvent(defeatedBy.location);
            endCombat();
            specialEvent = 0;
            subEvent = "";

            //Activates all the penalties for being defeated and removes any temporary modifiers
            if (currentState == "defeated") {
                currentState = "default";
                rmvTempBuffs();
                Eaten = 0;
                Drank = 0;
                Inflated = 0;
                InflatedMass = 0;
                Calories = 0;
                updateStats();
                doRest();
                HEA = 0;
                doHealth(maxHEA * 0.5);
                doGold(-10);
            }

            //Displays the different defeat scenes based on what type of defeat happened
            switch (defeatedBy) {
                default:
                    scene("You died ", true);
                    break;
            }
        }

        //Subpages for different combat actions
        //Calculates the damage you should do with a basic attack
        public function doDMG():void {

            //Sets your weapons scaling based on the type of weapon and your stats
            var tempStat:int = STR;
            var tempScale:Number = 0.4;
            if (WEA.damageStat != null) {
                switch (WEA.damageStat) {
                    case "AGI":
                        tempStat = AGI;
                        break;
                    case "INT":
                        tempStat = INT;
                        break;
                    default:
                        tempStat = STR;
                        break;
                }
            }
            //I don't really remember why this is here, but apparently it also adds damage scaling from your armor
            if (WEA.damageScaling > 0) {
                tempScale = WEA.damageScaling;
                if (WEA.damageStat == ARM.damageStat) {
                    tempScale += ARM.damageScaling;
                }
            }

            //Calculates the base damage you should do based on the weapon damage, scaling, your stats, and the enemy's defense
            DMG = xdy(WEA.WEAd, WEA.WEAr) + (tempStat * tempScale) - enemyt.DEF;

            //Adds weakness/resistance multipliers to your base damage
            if (WEA.damageType != null) {
                var damageMultiplier:Number = 1;
                //Damage resistance multiplier
                if (enemyt.damageResistance.length > 0) {
                    for (i = 0; i < enemyt.damageResistance.length; i++) {
                        var testResistance:DamageType = enemyt.damageResistance[i];
                        if (testResistance.name == WEA.damageType.name) {
                            damageMultiplier /= 1.5;
                        }
                    }
                }
                //Damage weakness multiplier
                if (enemyt.damageWeakness.length > 0) {
                    for (i = 0; i < enemyt.damageWeakness.length; i++) {
                        var testWeakness:DamageType = enemyt.damageWeakness[i];
                        if (testWeakness.name == WEA.damageType.name) {
                            damageMultiplier *= 1.5;
                        }
                    }
                }
                //Multiplies your damage based on previous weakness/resistance calculations
                DMG *= damageMultiplier;
            }

            //Prevents the player from doing negative damage to enemies
            if (DMG < 0) {
                DMG = 0;
            }
        }

        //Attack your enemy with your equipped weapon
        public function playerAttack():void {
            if (inCombat()) {
                scene("<li><b>Attack</b></li>", false);

                //Calculates the damage you should do
                doDMG();

                //Displays the appropriate scene for the weapon you attacked with
                if (WEA.attackDescription != "Attack error") {
                    scene(WEA.attackDescription, false);
                }
                if (WEA.attackDescription == "Attack error") {
                    scene("You hit your enemy with your " + WEA.Name + ", ", false);
                }
                scene("dealing " + DMG + " damage. ", false);

                //Tests to see if your weapon matches the enemies weaknesses/resistances
                if (WEA.damageType != null) {
                    testEffectiveness(WEA.damageType);
                }

                //Applies the weapon's special effects where applicable
                if (DMG > 0) {
                    switch (WEA.attackProc) {
                        case "stun":
                            if (d100() < WEA.attackProcChance) {
                                scene("Your opponent has becomed stunned! ", false);
                                eStatusStunTime = WEA.attackProcPower;
                            }
                            break;
                        case "drain":
                            if (d100() < WEA.attackProcChance) {
                                scene("The " + WEA.Name + " draws life from them! ", false);
                                doHealth(DMG * (WEA.attackProcPower / 100));
                            }
                            break;
                    }
                }

                //Applies the results of your attack
                doEnemyHealth(-DMG);
                doStamina(-3);
                if (eHEA <= 0) {
                    winBattle(enemyt.victory);
                }
            }
        }

        //Tests an attack's effectiveness and displays the appropriate scene for it
        public function testEffectiveness(ID:DamageType):void {
            var damageText:String = "";

            //Damage resisted message
            if (enemyt.damageResistance.length > 0) {
                for (i = 0; i < enemyt.damageResistance.length; i++) {
                    var testResistance:DamageType = enemyt.damageResistance[i];
                    if (testResistance.name == ID.name) {
                        damageText = "It's not very effective. ";
                    }
                }
            }

            //Damage weakness message
            if (enemyt.damageWeakness.length > 0) {
                for (i = 0; i < enemyt.damageWeakness.length; i++) {
                    var testWeakness:DamageType = enemyt.damageWeakness[i];
                    if (testWeakness.name == ID.name) {
                        damageText = "It's super effective! ";
                    }
                }
            }

            //displays the appropriate scene based on the precious calculations
            scene(damageText, false);
        }

        //Calculates the damage for the input spell. Some stat affecting spells use this calculation to decide how much to affect a stat
        public function doSpellDMG(ID:Spells):void {

            //Applies the intelligence modifier of your equipped weapon when applicaplble
            var castModifier:Number = 0.4;
            if (WEA.damageStat == "INT" && WEA.damageScaling > castModifier) {
                castModifier = WEA.damageScaling;
            }
            DMG = xdy(ID.damage, ID.damageRange) + (INT * castModifier);

            //Calculates damage multipliers based on weakness/resistances
            if (ID.damageType != null) {
                var damageMultiplier:Number = 1;
                //Damage resistance multiplier
                if (enemyt.damageResistance.length > 0) {
                    for (i = 0; i < enemyt.damageResistance.length; i++) {
                        var testResistance:DamageType = enemyt.damageResistance[i];
                        if (testResistance.name == ID.damageType.name) {
                            damageMultiplier /= 1.5;
                        }
                    }
                }
                //Damage weakness multiplier
                if (enemyt.damageWeakness.length > 0) {
                    for (i = 0; i < enemyt.damageWeakness.length; i++) {
                        var testWeakness:DamageType = enemyt.damageWeakness[i];
                        if (testWeakness.name == ID.damageType.name) {
                            damageMultiplier *= 1.5;
                        }
                    }
                }
                DMG *= damageMultiplier;
            }

            //Prevents damage from being negative
            if (DMG < 0) {
                DMG = 0;
            }
        }

        //Equation for healing done by the input spell
        public function doSpellHeal(ID:Spells):void {
            DMG = xdy(ID.damage, ID.damageRange) + (INT * 0.4);
            if (DMG < 0) {
                DMG = 0;
            }
        }

        //Casts a spell in combat and allows your opponent to attack for the round
        public function combatCast(ID:Spells):void {
            if (currentState == "combatSpells") {
                currentState = "combat";
            }

            //Tests who should act first in combat this round
            switch (INT >= enemyt.INT || enemySlowEffect()) {
                case true:
                    if (playerStatusEffect() == false) {
                        playerCast(ID);
                    }
                    scene("\n", false);
                    if (eHEA > 0 && enemyStunEffect() == false) {
                        enemyAttack();
                    }
                    break;
                default:
                    if (enemyStunEffect() == false) {
                        enemyAttack();
                    }
                    scene("\n", false);
                    if (grapple <= 0 && inCombat()) {
                        if (playerStatusEffect() == false) {
                            playerCast(ID);
                        }
                    }
                    break;
            }

            //If you're still in combat after the results of the case spell, then the appropriate combat buttons are displayed
            if (inCombat()) {
                combatButtons();
            }
        }

        //Casts the input spell
        public function playerCast(ID:Spells):void {
            //displays the appropriate scene based on whether you're in combat or not
            if (inCombat()) {
                combatDialogue();
                scene("<li><b>Spell: " + capFirst(ID.name) + "</b></li>", false);
            }
            if (!inCombat()) {
                scene("", true);
            }


            var LightningDamage:* = null;
            switch (ID.spellType) {
                case "attack":
                    //Activates effect of damaging spells
                    if (ID.damage > 0) {
                        doSpellDMG(ID);
                        scene(ID.descriptionCast + "dealing " + DMG + " damage. ", false);
                        doEnemyHealth(-DMG);
                        testEffectiveness(ID.damageType);
                    }

                    //Activates effect of Debuff spells
                    if (ID.damage == 0) {
                        scene(ID.descriptionCast, false);
                    }

                    //Activates effect of Status effecting spells
                    switch (ID.statusEffect) {
                        case "burn":
                            if (d100() < 25) {
                                scene("Your opponent has become burnt! ", false);
                                eStatusBurnPower = DMG * 0.2;
                                eStatusBurnTime = ID.statusTime;
                                if (eStatusSoakTime > 0) {
                                    scene("Which has unfortunately stopped them from being soaked. ", false);
                                    eStatusSoakTime = 0;
                                    enemyt.damageWeakness.splice(enemyt.damageWeakness.indexOf(LightningDamage), 1);
                                }
                            }
                            break;
                        case "stun":
                            if (d100() < 20) {
                                scene("Your opponent has becomed stunned! ", false);
                                eStatusStunTime = ID.statusTime;
                            }
                            break;
                        case "slow":
                            if (d100() < 30) {
                                scene("Your opponent has become slowed! ", false);
                                eStatusSlowTime = ID.statusTime;
                            }
                            break;
                        case "soak":
                            scene("Your opponent has become soaked with water! ", false);
                            eStatusSoakTime = ID.statusTime;
                            if (eStatusBurnPower > 0) {
                                scene("Which has unfortunately stopped them from burning. ", false);
                                eStatusBurnPower = 0;
                                eStatusBurnTime = 0;
                            }
                            enemyt.damageWeakness.push(LightningDamage);
                            break;
                    }
                    break;

                    //Activates effect of healing spells
                case "heal":
                    doSpellDMG(ID);
                    scene(ID.descriptionCast + "restoring " + DMG + " health. ", false);
                    doHealth(DMG);
                    break;

                    //Activates effect of buffing spells
                case "buff":
                    scene(ID.descriptionCast, false);
                    switch (ID.buffStat) {
                        case "STR":
                            if (tmagicSTRbuff < ID.buffAmount) {
                                scene("increasing your " + ID.buffStat + " by " + ID.buffAmount + ". ", false);
                                tmagicSTRbuff = ID.buffAmount;
                            }
                            else {
                                scene("but your " + ID.buffStat + " has already been raised by magical means. ", false);
                            }
                            break;
                        case "INT":
                            if (tmagicINTbuff < ID.buffAmount) {
                                scene("increasing your " + ID.buffStat + " by " + ID.buffAmount + ". ", false);
                                tmagicINTbuff = ID.buffAmount;
                            }
                            else {
                                scene("but your " + ID.buffStat + " has already been raised by magical means. ", false);
                            }
                            break;
                        case "END":
                            if (tmagicENDbuff < ID.buffAmount) {
                                scene("increasing your " + ID.buffStat + " by " + ID.buffAmount + ". ", false);
                                tmagicENDbuff = ID.buffAmount;
                            }
                            else {
                                scene("but your " + ID.buffStat + " has already been raised by magical means. ", false);
                            }
                            break;
                        case "AGI":
                            if (tmagicAGIbuff < ID.buffAmount) {
                                scene("increasing your " + ID.buffStat + " by " + ID.buffAmount + ". ", false);
                                tmagicAGIbuff = ID.buffAmount;
                            }
                            else {
                                scene("but your " + ID.buffStat + " has already been raised by magical means. ", false);
                            }
                            break;
                        case "STO":
                            if (tmagicSTObuff < ID.buffAmount) {
                                scene("increasing your " + ID.buffStat + " by " + ID.buffAmount + ". ", false);
                                tmagicSTObuff = ID.buffAmount;
                            }
                            else {
                                scene("but your " + ID.buffStat + " has already been raised by magical means. ", false);
                            }
                            break;
                        case "DEF":
                            if (tmagicDEFbuff < ID.buffAmount) {
                                scene("increasing your defense by " + ID.buffAmount + ". ", false);
                                tmagicDEFbuff = ID.buffAmount;
                            }
                            else {
                                scene("but your defense has already been raised by magical means. ", false);
                            }
                            break;
                        case "REGEN":
                            if (tmagicREGENbuff < ID.buffAmount) {
                                tmagicREGENbuff = ID.buffAmount;
                                tmagicREGENbuffDamage = ID.damage;
                                tmagicREGENbuffRange = ID.damageRange;
                                doSpellDMG(ID);
                                doHealth(DMG);
                            }
                            break;
                        case "DODGE":
                            if (tmagicDODGEbuff < ID.buffAmount) {
                                scene("increasing your chance of dodging by " + ID.buffAmount + "%. ", false);
                                tmagicDODGEbuff = ID.buffAmount;
                            }
                            else {
                                scene("but your evasion has already been raised by magical means. ", false);
                            }
                            break;
                    }
                    break;

                    //Activates effect of any other spells not previously covered
                case "other":
                    scene(ID.descriptionCast, false);
                    switch (ID.name) {
                    }
                    break;
            }

            //Charges you mana for casting the input spell
            MANA -= ID.manaCost;
            updateStats();

            //If your spell defeted the opponent, then you win!
            if (currentState == "combat" && eHEA <= 0) {
                winBattle(enemyt.victory);
            }
        }

        //Activates the effect of your opponent being slowed
        public function enemySlowEffect():Boolean {
            var slowed:Boolean = false;
            if (eStatusSlowTime > 0 && inCombat()) {
                slowed = true;
                //Ticks down the slow timer
                eStatusSlowTime--;
                if (eStatusSlowTime <= 0) {
                    //Removes the slow effect and displays a scene to reflect this
                    eStatusSlowTime = 0;
                    scene("<i>Your opponent is no longer slowed.</i> ", false);
                }
            }
            //Returns wether your opponent was affected by slow or not
            return slowed;
        }

        //Activates the effect of your opponent being burned. Also activates the soak effect because I'm lazy and they're both checked at the same point anyway
        public function enemyBurnEffect():void {

            if (eStatusBurnPower > 0 && eStatusBurnTime > 0 && inCombat()) {
                scene("<li><i>Burn</i></li>" +
                        "\tYour opponent burns for " + eStatusBurnPower + " damage. ", false);
                doEnemyHealth(-eStatusBurnPower);
                //ticks down the burn timer
                eStatusBurnTime--;
                if (eStatusBurnTime <= 0) {
                    //Removes the burn effect and displays a scene to reflect this
                    eStatusBurnTime = 0;
                    eStatusBurnPower = 0;
                    scene("<i>Your opponent is no longer burning.</i> ", false);
                }
                //If the burn effect defeated your opponent, then you win!
                if (eHEA <= 0) {
                    winBattle(enemyt.victory);
                }
            }

            //Activates the soak effect
            if (eStatusSoakTime > 0 && inCombat()) {
                //ticks down soak timer
                eStatusSoakTime--;
                if (eStatusSoakTime <= 0) {
                    //removes soak effect and displays a scene to reflect this
                    eStatusSoakTime = 0;
                    var LightningDamage:* = null;
                    enemyt.damageWeakness.splice(enemyt.damageWeakness.indexOf(LightningDamage), 1);
                    scene("<i>Your opponent has shaken off most of the water from your spell.</i> ", false);
                }
            }
        }

        //Does the effect of your opponent being stunned
        public function enemyStunEffect():Boolean {
            var stunned:Boolean = false;
            if (eStatusStunTime > 0 && inCombat()) {
                if (d100() < 34) {
                    scene("<li><i>Stunned</i></li>" +
                            "Your enemy is too stunned to attack! ", false);
                    eStatusStunTime--;
                    stunned = true;
                    if (eStatusStunTime <= 0) {
                        eStatusStunTime = 0;
                        scene("<i>Your opponent seems to be shaking off the effects of the stun though.</i> ", false);
                    }
                }
            }
            return stunned;
        }

        //Activates the status effects on the player
        public function playerStatusEffect():Boolean {

            //Tracks wether the player should be stunned from any of the followoing status effects
            var incapacitated:Boolean = false;

            if (inCombat()) {
                //Regeneration effect
                if (tmagicREGENbuff > 0) {
                    var tempRegen:int = xdy(tmagicREGENbuffDamage, tmagicREGENbuffRange) + (INT * 0.4);
                    scene("<li><b><i>Regeneration</i></b></li>" +
                            "Your regenerate " + tempRegen + " health! ", false);
                    doHealth(tempRegen);
                    tmagicREGENbuff--;
                    if (tmagicREGENbuff <= 0) {
                        tmagicREGENbuff = 0;
                        tmagicREGENbuffDamage = 0;
                        tmagicREGENbuffRange = 0;
                        scene("<i>The healing effects surrounding you have begun to fade though.</i> ", false);
                    }
                }

                //Stun effect
                if (pStatusStunTime > 0) {
                    if (d100() < 51) {
                        scene("<li><b><i>Stunned</i></b></li>" +
                                "You were too stunned to act! ", false);
                        pStatusStunTime--;
                        incapacitated = true;
                        if (pStatusStunTime <= 0) {
                            pStatusStunTime = 0;
                            scene("<i>You finally shake off the effects of the stun though.</i> ", false);
                        }
                    }
                }

                //Burn effect
                if (statusBurnPower > 0) {
                    scene("<li><b><i>Burn</i></b></li>" +
                            "You take " + statusBurnPower + " damage from the flames. ", false);
                    doHealth(-statusBurnPower);
                    statusBurnPower--;
                    if (statusBurnPower <= 0) {
                        statusBurn = 0;
                        statusBurnPower = 0;
                        scene("<i>You finally stop burning though.</i> ", false);
                    }
                    if (HEA <= 0) {
                        incapacitated = true;
                    }
                }

                //Bloat venom effect
                if (statusBloatVenomPower > 0) {
                    scene("<li><b><i>Bloat Venom</i></b></li>" +
                            "Your stomach gurgles as you feel pressure as if you had just eaten a meal. ", false);
                    doInflate(statusBloatVenomPower, 0);
                    statusBloatVenomPower--;
                    if (statusBloatVenomPower <= 0) {
                        statusBloatVenom = 0;
                        statusBloatVenomPower = 0;
                        scene("<i>Fortunately, your head no longer feels fuzzy and it seems you're finally over the effect's of the bloat venom.</i> ", false);
                    }
                    if (HEA <= 0) {
                        incapacitated = true;
                    }
                }
            }

            return incapacitated;
        }

        //Attempts to devour your enemy
        public function playerVore():void {
            //Skill check to see if you succeed in hitting your enemy with the vore attack
            switch (testSkillRange(AGI + STR + INT + 50, enemyt.AGI + enemyt.STR + enemyt.INT + (eHEA * .5), 0, 90)) {
                case false:
                    //Vore attempt missed
                    voreing = false;
                    scene("Vore attempt missed. ", false);
                    scene("\n", false);
                    break;

                    /*default vore template
                    enemy name
                        scene describing your attemp to eat the enemy
                            game tests to see if you survived consuming the enemy
                                if you survive, you win the fight and gain calories for devouring your enemy
                                if you explode, you lose the fight
                    */

                case true:
                    //Consumes the enemy without displaying any fullness descriptions or gaining any calories.
                    //Used to test if you can survive eating the enemy without exploding before continuing with the description
                    doConsumeQuiet(enemyt.weight, 0, 0);
                    voreing = true;

                    //The list of enemy voreing descriptions goes here
                    switch (enemy) {

                    }
                    break;

                    //End of voreing descriptions
            }
        }

        //Displays the input spell's description
        public function spellDescription(ID:Spells):void {

            //Displays spell's basic description
            scene("<b>" + capFirst(ID.name) + ":</b> " +
                    "\n\t" + ID.description +
                    "\n\t<i>" + ID.manaCost + " mana. ", false);

            //Says when a spell is castable
            if (ID.castableCombat && ID.castableOOC == false) {
                scene("Castable in combat. ", false);
            }
            if (ID.castableOOC && ID.castableCombat == false) {
                scene("Castable out of combat. ", false);
            }
            if (ID.castableCombat && ID.castableOOC) {
                scene("Castable in or out of combat. ", false);
            }

            //Says much damage the spell does
            var spellScaling:Number = 0.4;
            if (WEA.damageStat == "INT" && WEA.damageScaling > spellScaling) {
                spellScaling = WEA.damageScaling;
            }
            switch (ID.spellType) {
                case "attack":
                    scene("\n\t", false);
                    if (ID.damage > 0) {
                        scene("Deals " + ID.damage + "d" + ID.damageRange + " +" + spellScaling * 100 + "% INT damage. ", false);
                    }

                    //lists the spell's special effects
                    switch (ID.statusEffect) {
                        case "burn":
                            scene("Has a chance to burn your enemy, causing damage over time for " + ID.statusTime + " turn(s). Cancels out the soak effect. ", false);
                            break;
                        case "stun":
                            scene("Has a chance to stun your enemy, causing it to sometimes be unable to attack " + ID.statusTime + " turn(s). ", false);
                            break;
                        case "slow":
                            scene("Has a chance to slow your enemy, causing it to act last in combat for " + ID.statusTime + " turn(s). ", false);
                            break;
                        case "soak":
                            scene("Soaks your enemy in water, causing them to be weak to lightning attacks for " + ID.statusTime + " turn(s). Cancels out the burn effect. ", false);
                            break;
                    }
                    break;
                case "heal":
                    scene("\n\tHeals " + ID.damage + "d" + ID.damageRange + " +" + spellScaling + "% INT damage. ", false);
                    break;
                case "buff":
                    //lists the spell's special effects
                    switch (ID.buffStat) {
                        case "REGEN":
                            scene("\n\tRegenerates " + ID.damage + "d" + ID.damageRange + " +" + spellScaling + "% INT health for " + ID.buffAmount + " rounds/" + ID.buffAmount + "0 minutes. ", false);
                            break;
                        case "DODGE":
                            scene("\n\tIncreases your chance of you dodging attacks by " + ID.buffAmount + "%. ", false);
                            break;
                        default:
                            scene("\n\tIncreases " + ID.buffStat + " by " + ID.buffAmount + ". ", false);
                            break;
                    }
                    break;
            }
            scene("</i>", false);
        }

        //Displays your known spells
        public function doSpells():void {
            updateStats();
            clearView();
            appView(0);

            //Stores which spell you've selected to cast
            var tempSpell:Spells;

            //Sorts your spell list alphabetically
            spellArray.sortOn("name", Array.CASEINSENSITIVE);

            //Moves you to the correct state based on wether you're in combat or not
            if (currentState == "combat") {
                currentState = "combatSpells";
            }
            if (currentState != "combat" && currentState != "combatSpells") {
                currentState = "spells";
            }
            invView(1);

            listen = function ():void {
                if (btnchc > 0 && btnchc < 10 && spellArray[(btnchc - 1) + ((spellPage - 1) * 9)] != null) {

                    //Selects the spell you've clicked on and asks if you want to cast the spell
                    tempSpell = spellArray[(btnchc - 1) + ((spellPage - 1) * 9)];
                    if (currentState == "combatSpells") {
                        combatDialogue();
                        if (tempSpell.castableCombat) {
                            btntxt(11, "Cast");
                        }
                        else {
                            clearDecisionView();
                        }
                    }
                    if (currentState == "spells") {
                        scene("", true);
                        if (tempSpell.castableOOC) {
                            btntxt(11, "Cast");
                        }
                        else {
                            clearDecisionView();
                        }
                    }
                    spellDescription(tempSpell);
                }
                if (btnchc == 11 && tempSpell != null) {
                    //Casts the spell you've selected
                    clrchc();
                    if (tempSpell.manaCost <= MANA) {
                        if (currentState != "combatSpells") {
                            playerCast(tempSpell);
                        }
                        else {
                            combatCast(tempSpell);
                        }
                    }
                    else {
                        var eventText:* = null;
                        if (eventText.htmlText.match("Not enough mana") == null) {
                            scene("\nNot enough mana! ", false);
                        }
                    }
                }
            };
            spellButtons();
        }

        //Writes spells to buttons based on page number
        public function spellButtons():void {
            for (i = ((spellPage - 1) * 9) + 1; i <= spellPage * 9; i++) {
                var tempSpell:Spells = spellArray[i - 1];
                if (tempSpell != null) {
                    buttonIcons(i, null);
                    writeSpells(i, tempSpell);
                }
            }
        }

        //Writes the spells' names
        public function writeSpells(slot:int, ID:Spells):void {
            if (slot > 9) {
                slot %= 9
            }
            if (slot == 0) {
                slot = 9
            }
            btntxt(slot, capFirst(ID.name));
        }

        //Adds the input spell to your spell book if you don't know it already
        public function spellLearn(ID:Spells):void {
            if (spellFind(ID) == -1) {
                var spellReceived:Spells = ObjectUtil.copy(ID) as Spells;
                spellArray.push(spellReceived);
            }
        }

        //Returns wether you know a spell a not
        public function spellKnown(ID:Spells):Boolean {
            if (spellFind(ID) > -1) {
                return true;
            }
            else {
                return false;
            }
        }

        //Returns the index of the input spell. If you don't knwo the spell then it returns an index of -1
        public function spellFind(ID:Spells):Number {
            var spellIndex:int = -1;
            for (i = 0; i < spellArray.length; i++) {
                var testSpell:Spells = spellArray[i];
                if (testSpell.name == ID.name) {
                    spellIndex = i;
                }
            }
            return spellIndex;
        }

        //Displays spell teacher buttons/dialogue
        public function doTeaching(ID:Vendors):void {
            Vendor = ObjectUtil.copy(ID) as Vendors;
            Vendor.StoreExit = ID.StoreExit;
            scene(Vendor.Buying + "\n", true);
            clearView();
            leaveButton(12);

            //Removes known spells from spells you can try to learn
            for (var j:int = Vendor.vendArray.length; j > 0; j--) {
                var tempRemoveSpell:Spells = Vendor.vendArray[j - 1];
                if (spellFind(tempRemoveSpell) != -1) {
                    Vendor.vendArray.splice(j - 1, 1);
                }
            }

            //Removes spells you're too dumb to learn
            Vendor.vendArray.sortOn("requirementINT", Array);
            for (i = 1; i <= 9 && i <= Vendor.vendArray.length; i++) {
                var tempVendSpell:Spells = Vendor.vendArray[i - 1];
                if (tempVendSpell.requirementINT <= bINT) {
                    btntxt(i, capFirst(tempVendSpell.name));
                }
                scene("\n", false);
                spellDescription(tempVendSpell);
                scene("\n\t" + tempVendSpell.Value + " gold, " + tempVendSpell.requirementINT + " INT", false)
            }

            //Response based on what spells your character knows
            if (buttonVisible1 == false) {
                scene("\n\n", false);
                if (Vendor.vendArray.length == 0) {
                    scene(Vendor.allKnown, false);
                }
                else {
                    scene(Vendor.lowINT, false);
                }
            }

            //Creates buttons for you to click on to learn that spell.
            listen = function ():void {
                if (btnchc > 0 && btnchc < 10) {
                    var tempLearnSpell:Spells = Vendor.vendArray[btnchc - 1];
                    if (GLD > tempLearnSpell.Value) {
                        spellLearn(tempLearnSpell);
                        doTeaching(Vendor);
                        scene("\n" + Vendor.Bought, false);
                        doGold(-tempLearnSpell.Value);
                        doTime(30);
                    }
                    else {
                        doTeaching(Vendor);
                        scene("\n" + Vendor.NoMoney, false);
                    }
                }
                if (btnchc == 12) {
                    doEvent(Vendor.StoreExit);
                    scene(Vendor.Leaving, true);
                }
            }

        }

        //Rolls up how much damage the opponent should do with an attack
        //(note that the damage is not dealt, the variable is just set for how much damage should be dealt)
        public function doeDMG():void {
            var damageStat:int = 0;
            switch (enemyt.attackStat) {
                case "AGI":
                    damageStat = enemyt.AGI;
                    break;
                case "INT":
                    damageStat = enemyt.INT;
                    break;
                default:
                    damageStat = enemyt.STR;
                    break;
            }
            eDMG = dXY(damageStat * .8, damageStat * 1.2) - ARM.Defense - tmagicDEFbuff;
            if (eDMG < 0) {
                eDMG = 0;
            }
        }

        //Rolls up the damage for an enemy casting the input spell
        public function doeSpellDMG(ID:Spells):void {
            eDMG = xdy(ID.damage, ID.damageRange) + (enemyt.INT * 0.4);
            if (eDMG < 0) {
                eDMG = 0;
            }
        }

        //Causes the enemy to cast the input spell
        public function enemyCast(ID:Spells):void {
            switch (ID.spellType) {
                case "attack":
                    doSpellDMG(ID);
                    doHealth(-eDMG);
                    break;
                case "heal":
                    doSpellDMG(ID);
                    doEnemyHealth(eDMG);
                    break;
            }
            eMANA -= ID.manaCost;
            updateStats();
        }

        //Rolls up your character's dodge chance and returns whether they succeeded in dodging or not
        public function dodge():Boolean {
            return testSkillRange(AGI + INT + modDodge(), enemyt.AGI + enemyt.INT, 5, 75);
        }

        //Calculates any modifiers to your dodge chance from buffs
        public function modDodge():Number {
            var tempDodge:Number = 0;
            tempDodge += tmagicDODGEbuff;
            return tempDodge;
        }

        //Enemy's attack AI//////////////////////////////////
        public function enemyAttack():void {
            if (inCombat()) {

                //Records starting health. Used at the end of the function to see if the player gained or lost health and displays the appropriate health arrow on screen
                var startingHEA:int = HEA;

                //Rolls up the damage an enemy's attack is going to do (although not all attacks will event use this number)
                doeDMG();

                //Records whether the enemy attacked or not. Used for various enemies who have multiple "attacks" in a row
                var enemyAttacked:Boolean = false;

                //Based on who the enemy is, this looks for that enemy's AI and runs it
                //Enemies are listed alphabetically
                switch (enemy) {

                        /*Default enemy AI structure:
                        Enemy name
                            Test whether the player is surrendering or not
                            If not surrendering; tests wether the enemy is grappled or not
                                If grappled; then does the grapple attack
                                If not grappled; then does a nongrapple attack
                                    If an attack can be dodged; the game checks wether you dodge or not and resolves the attack accordingly
                            Once attacks are completed; checks if the player/enemy is defeated and runs an event if appropriate
                        */

                        //Default monster attack if it's actual AI hasn't been added in yet
                    default:
                        scene("The " + enemyt.name + " attacks you, dealing " + eDMG + " damage. ", false);
                        doHealth(-eDMG);
                        if (!alive()) {
                            scene("\n\tYou're vision fades to black as you fall unconscious. ", false);
                            var battle:Defeats = null;
                            defeatEvent(battle);
                        }
                        break;

                }
            }

            //Resets the surrender tag in case surrendering doesn't actually end the fight for whatever reason
            surrender = false;

            //If the attack didn't end the combat, then this displays the normal combat options
            if (inCombat()) {
                combatButtons();
            }

            //Displays health arrows based on if/how your health changed from the attack
            if (startingHEA > HEA) {
                //doArrow("HEAdown");
            }
            if (startingHEA < HEA) {
                //doArrow("HEAup");
            }

            //Prevents health from going negative as that can easily mess up several calculations
            if (player.HP < 0) {
                player.HP = 0;
            }
        }

        //Returns an integer representing which random event to do next from the input array
        //This system is a bit complicated, basically an array is made with twice as many indexes as you have categories of events you want to do
        //The odd indexes are added to the previous index, and then whichever even index is the highest is returned
        //The odd indexes represent how fast you want it's associated index's event to happen
        //Once an even index is pulled up, it's reset to 0 and must tick back up again
        //For instance you might want an array like [random fight,random fight rate,random event,random event rate,random item,random item rate]
        //Which could be something like [0,2,0,1,0,3]
        //which would cause the "random item" event to tick up 3 times, and the "random fight" event to tick up 2 times, and the "random event" event to tick up 1 time every time the array is run through the function
        //So the first several times you ran that index through this function it would look like;
        //[0,2,0,1,0,3] - the array you start with before applying the function
        //[2,2,1,1,3,3] - the 3rd even index is highest, so the function would return "3" and then reset the 3rd even index to 0
        //[4,2,2,1,3,3] - the 1st even index is highest, so the function would return "1" and then reset the 1st even index to 0
        //[2,2,3,1,6,3] - the 3rd even index is highest, so the function would return "3" and then reset the 3rd even index to 0
        //[4,2,4,1,3,3] - the 1st even index is highest, so the function would return "1" and then reset the 1st even index to 0
        //[2,2,5,1,6,3] - the 3rd even index is highest, so the function would return "3" and then reset the 3rd even index to 0
        //[4,2,6,1,3,3] - the 2nd even index is highest, so the function would return "2" and then reset the 2nd even index to 0
        //[6,2,1,1,6,3] - the 1st and 3rd index are tied for highest so the function returns the last highest even index, which is "3", and then resets that index to 0
        public function eventRandomization(ID:Array):int {
            //Represents which of the even events is the highest
            var caseNumber:int = 0;
            //represents the actual index of the highest event
            var highestEvent:int = 0;

            //Adds the odd indexes to the even index that precedes them
            for (i = 0; i < ID.length - 1; i += 2) {
                ID[i] += ID[i + 1];
            }

            //Goes through the array and tests to see which index is highest
            for (i = 0; i < ID.length - 1; i += 2) {
                if (ID[i] >= ID[highestEvent]) {
                    //Records which index needs to be reset
                    highestEvent = i;
                    //Converts the selected highest even index to what the function will return
                    //(So "0" would be even index "1", "2" would be even index "2", "4" would be even index "3", etc.)
                    caseNumber = (i * .5) + 1;
                }
            }

            //Resets the selected index to 0
            ID[highestEvent] = 0;

            //Returns which even index was the highest
            return caseNumber;
        }

        //Changes game location and background image
        public function locationUpdate(ID:Locations):void {
            var blank:Locations = null;
            var wall:Locations = null;
            if (ID != wall && ID != null && ID != blank) {

                //Records where you came from, in case an event cares about it
                cameFrom = location;

                //Changes your location to the input location
                location = ID;

                //Creates a new array containing the surrounding areas of the input location
                //This is done so you can change the surroundings based on different criteria rather than always being stuck with what's set with the location object
                surroundingsArray = [];
                for (i = 0; i < 9; i++) {
                    surroundingsArray[i] = location.Surroundings[i];
                }

                updateStats();

                //Updates background image
                //updateBackground();
            }
        }

        //Updates background image based on your location and the time of day
        public function updateBackground():void {
            if (dayTime()) {
                backgroundImageSource = location.locationZone.dayBackground;
            }
            else {
                backgroundImageSource = location.locationZone.nightBackground;
            }
        }

        //Walks to input location, removing stamina and advancing time, and does the event at that location
        public function locationTravel(ID:Locations):void {
            //Checks to make sure the input location actually exists, and is not impassable (ie not a wall)
            var impassable:Zones = null;
            if (ID != null && ID.locationZone != impassable) {
                //Does walking calculations if you're traveling to a new place
                if (location != ID) {
                    doWalk(3);
                }
                //Changes your location to the input location
                locationUpdate(ID);
                //does the event at the input location
                doEvent(ID);
            }
        }

        //Tests if you are immobile after multiplying by the input ration
        //(for instance if you ran the function testImmobile(1.5), it would test whether you'd be immobile at 1.5x your current weight)
        public function testImmobile(ratio:Number):Boolean {
            var tempBool:Boolean = false;
            if ((FAT + (ATE * 2)) * ratio > STR * 12) {
                tempBool = true;
            }
            return tempBool;
        }

        //Tests if you're close to being immobile. Used as the default ratio that you'd consider "close" to being immobile
        public function testImmobileClose():Boolean {
            return testImmobile(1.3);
        }

        //Displays travleable locations
        public function explore():void {
            //Removes previous buttons
            clearView();

            //Creates buttons for you to travel to and adds the relevant icon if it exists
            for (i = 0; i < 9; i++) {
                var exploreLocation:Locations = surroundingsArray[i];
                if (exploreLocation != null) {
                    if (exploreLocation.Name != "") {
                        btntxt(i + 1, capFirst(exploreLocation.Name));
                    }
                    if (exploreLocation.icon != null) {
                        buttonIcons(i + 1, exploreLocation.icon);
                    }
                }
            }

            //Out of stamina warning. Doesn't work very well
            if (STA <= 0) {
                var eventText:* = null;
                if (eventText.htmlText.match("Out of stamina.") == null) {
                    scene("\n\n<i>Out of stamina.</i> ", false);
                }
            }

            //Causes the buttons to make you travel somewhere if you click on it
            listen = function ():void {
                if (STA > 0) {
                    locationTravel(surroundingsArray[btnchc - 1]);
                }
            }
        }

        //Ends special event, resets special event tracking variable, travels you to the input location, and brings up the default travel buttons for that location
        public function endEvent(traveling:Locations):void {
            specialEvent = 0;
            subEvent = "";
            appView(0);
            locationUpdate(traveling);
            general();
        }

        //Does the input defeat event
        public function defeatEvent(defeated:Defeats):void {
            defeatedBy = defeated;
            currentState = "defeated";
            nextButton();
        }


        //Adds the quest to your quest log if you don't already have the quest
        public function getQuest(ID:Quests):void {
            if (!hasQuest(ID)) {
                var questReceived:Quests = ObjectUtil.copy(ID) as Quests;
                questArray.push(questReceived);
            }
        }

        //Returns wether you have a quest and have not completed it yet
        public function questActive(ID:Quests):Boolean {
            var doingQuest:Boolean = false;
            if (hasQuest(ID) && !questCompleted(ID)) {
                doingQuest = true;
            }
            return doingQuest;
        }

        //Returns index of input quest, or -1 if quest doesn't exist in your quest log
        public function questFind(quest:Quests):int {
            var questIndex:int = -1;
            for (i = 0; i < questArray.length; i++) {
                var testQuest:Quests = questArray[i];
                if (quest.questName == testQuest.questName) {
                    questIndex = i;
                }
            }
            return questIndex;
        }

        //Returns which stage of a quest you're on. Returns -1 if you're not on that quest
        public function questStage(ID:Quests):int {
            var stage:int = -1;
            if (hasQuest(ID)) {
                var testQuest:Quests = questArray[questFind(ID)];
                stage = testQuest.questProgress;
            }
            return stage;
        }

        //Returns wether or not you have a quest
        public function hasQuest(ID:Quests):Boolean {
            var hasQuest:Boolean = false;
            if (questFind(ID) > -1) {
                hasQuest = true;
            }
            return hasQuest;
        }

        //Progresses the input quest by one
        public function questAdvance(ID:Quests):void {
            if (hasQuest(ID)) {
                var advancingQuest:Quests = ObjectUtil.copy(questArray[questFind(ID)]) as Quests;
                if (advancingQuest.questProgress < advancingQuest.questGoal) {
                    advancingQuest.questProgress++;
                }
                questArray.splice(questFind(ID), 1, advancingQuest);
            }
        }

        //Tests to see if you're ready to turn in a quest
        public function questReady(ID:Quests):Boolean {
            var testQuest:Quests;
            var completed:Boolean = false;
            if (hasQuest(ID)) {
                testQuest = questArray[questFind(ID)];
                if (testQuest.questProgress >= testQuest.questGoal) {
                    completed = true;
                }
            }
            return completed;
        }

        //Tests to see if a test is marked as completed
        public function questCompleted(ID:Quests):Boolean {
            var completed:Boolean = false;
            if (hasQuest(ID)) {
                var testQuest:Quests = questArray[questFind(ID)];
                if (testQuest.completed == true) {
                    completed = true;
                }
            }
            return completed;
        }

        //Completes quest and gives you rewards
        public function questReward(inputQuest:Quests):void {
            if (hasQuest(inputQuest)) {
                var ID:Quests = questArray[questFind(inputQuest)];
                scene("<li>Quest complete!</li>", false);

                //Grants quest rewards
                doXP(ID.questXP);
                doGold(ID.questGold);
                if (ID.questItem != null) {
                    forceGetItem(ID.questItem);
                }

                //Flags quest as completed and hides it from the quest log
                ID.questProgress = ID.questGoal;
                ID.completed = true;
                ID.visible = false;
            }
        }

        //Removes quests. Note, not used normally. When quests are completed they are marked as hiddin so the game can still keep track of what quests you have completed
        public function questRemove(quest:Quests):void {
            if (hasQuest(quest)) {
                questArray.splice(questFind(quest), 1);
            }
        }

        public function doEvent(ID:*):void {
//Default event for uncoded area
            scene("", true);
            general();

            //Automatically hides or shows the miscellaneous buttons based on whether it's safe for those buttons to be there or not
            if (ID.Surroundings.length == 0) {
                appView(0);
            }
            if (ID.Surroundings.length > 0) {
                appView(1);
            }

            //Events are broken up into sub pages so it's easier to navigate through events
            //This is where you include those sub pages
            var YourHouse:Locations = null;
            switch (ID) {

                    //Your house/////////////////////////////
                case YourHouse:
                    clearView();
                    switch (specialEvent) {
                        case 0:
                            scene("You step into your sparsely furnished living room. ", true);
                            leaveButton(13);
                            btntxt(1, "Bedroom");
                            btntxt(3, "Storage");
                            listen = function ():void {
                                var exampleCenter:Locations = null;
                                var YourHouse:Locations = null;
                                switch (btnchc) {
                                    case 1:
                                        specialEvent = 1;
                                        doEvent(YourHouse);
                                        break;
                                    case 3:
                                        depositing = true;
                                        invPage = 1;
                                        doStorage();
                                        break;
                                    case 13:
                                        scene("You " + walk() + " out of your house and onto the city's central square. ", true);
                                        endEvent(exampleCenter);
                                        break;
                                }
                            };
                            break;
                        case 1:
                            scene("You " + walk() + " into your small bedroom. ", true);
                            btntxt(1, "Save");
                            btntxt(2, "Load");
                            btntxt(3, "Sleep");
                            leaveButton(13);
                            listen = function ():void {
                                var YourHouse:Locations = null;
                                switch (btnchc) {
                                    case 1:
                                        trySave();
                                        break;
                                    case 2:
                                        tryLoad();
                                        break;
                                    case 3:
                                        doSleep();
                                        break;
                                    case 13:
                                        specialEvent = 0;
                                        doEvent(YourHouse);
                                        break;
                                }
                            };
                            break;
                    }
                    break;

                    //end events
            }


            //Ambient descriptions used to go here, but they were removed
            var store:LocationType = null;
            var exampleCenter:Locations = null;
            if (ID == exampleCenter) {
                general();
            }

            //Store events
            else if (ID.type == store && ID.locationVendor != null) {
                enterStore(ID.locationVendor);
            }

            //Automatic location descriptions for when nothing got displayed from the rest of this function
            var eventText:* = null;
            if (eventText.htmlText == "") {
                if (ID.Description == "") {
                    scene("You traveled to " + ID.Name, true);
                }
                else {
                    scene("\t" + ID.Description, true);
                }
            }
        }

        public function noonesContent() {

        }
    }
}
