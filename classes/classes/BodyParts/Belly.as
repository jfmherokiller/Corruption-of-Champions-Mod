package classes.BodyParts {
    public class Belly extends BaseBodyPart {
        public var fullness:int;
        public var MaxFullness:int;
        public var Calories:int;

        public function restore():void {
            fullness = 0;
            MaxFullness = 50;
            Calories = 0;
        }
        public function setProps(p:Object):void
        {
            if (p.hasOwnProperty('fullness'))  fullness  = p.fullness;
            if (p.hasOwnProperty('MaxFullness')) MaxFullness = p.MaxFullness;
            if (p.hasOwnProperty('Calories')) Calories = p.Calories;
        }
        public function setAllProps(p:Object):void
        {
            restore();
            setProps(p);
        }
    }
}
