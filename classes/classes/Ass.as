package classes
{
	import classes.internals.Serializable;
	import classes.internals.Utils;

	public class Ass implements Serializable
	{
		private static const SERIALIZATION_VERSION:int = 1;
		private static const SERIALIZATION_UUID:String = "0a3bd267-6ce0-4fed-a81b-53a4ccd6c17d";
		
		public static const WETNESS_DRY:int            =   0;
		public static const WETNESS_NORMAL:int         =   1;
		public static const WETNESS_MOIST:int          =   2;
		public static const WETNESS_SLIMY:int          =   3;
		public static const WETNESS_DROOLING:int       =   4;
		public static const WETNESS_SLIME_DROOLING:int =   5;

		public static const LOOSENESS_VIRGIN:int       =   0;
		public static const LOOSENESS_TIGHT:int        =   1;
		public static const LOOSENESS_NORMAL:int       =   2;
		public static const LOOSENESS_LOOSE:int        =   3;
		public static const LOOSENESS_STRETCHED:int    =   4;
		public static const LOOSENESS_GAPING:int       =   5;
		
		//data
		//butt wetness
		public var analWetness:Number = 0;
		/*butt looseness
		0 - virgin
		1 - normal
		2 - loose
		3 - very loose
		4 - gaping
		5 - monstrous*/
		public var analLooseness:Number = 0;
		//Used to determine thickness of knot relative to normal thickness
		//Used during sex to determine how full it currently is.  For multi-dick sex.
		public var fullness:Number = 0;
		public var virgin:Boolean = true; //Not used at the moment.
		
		public function validate():String {
			var error:String = "";
			error += Utils.validateNonNegativeNumberFields(this, "Ass.validate",[
					"analWetness", "analLooseness", "fullness"
			]);
			return error;
		}
		
		public function serialize(relativeRootObject:*):void 
		{
			relativeRootObject.analLooseness = this.analLooseness;
			relativeRootObject.analWetness = this.analWetness;
			relativeRootObject.fullness = this.fullness;
		}
		
		public function deserialize(relativeRootObject:*):void 
		{
			this.analLooseness = relativeRootObject.analLooseness;
			this.analWetness = relativeRootObject.analWetness;
			this.fullness = relativeRootObject.fullness;
		}
		
		public function upgradeSerializationVersion(relativeRootObject:*, serializedDataVersion:int):void 
		{
			// nothing to upgrade yet
		}
		
		public function currentSerializationVerison():int 
		{
			return SERIALIZATION_VERSION;
		}
		
		public function serializationUUID():String 
		{
			return SERIALIZATION_UUID;
		}
	}
}
