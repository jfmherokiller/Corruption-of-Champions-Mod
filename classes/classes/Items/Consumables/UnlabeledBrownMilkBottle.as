package classes.Items.Consumables {
    import classes.Items.Consumable;

    public class UnlabeledBrownMilkBottle extends Consumable {
        public function UnlabeledBrownMilkBottle() {
            super("UBMBottle","UBM Bottle" ,"Unlabled Brown Milk Bottle" , 1000,"" );
        }
        override public function useItem():Boolean {
            clearOutput();
            if(player.udder.HasUdder == false) {
                outputText("an udder grows on your lower body");
                player.udder.HasUdder = true;
            } else {
                outputText("you feel your udder lightly gurgle and fill with a small amount of milk");
                player.udder.fullness += 10;
            }

        }
    }
}
