package classes.StatusEffects.Combat 
{
	import classes.StatusEffectType;
	
	public class IceBreathDebuff extends CombatBuff
	{
		public static const TYPE:StatusEffectType = register("Ice Breath", IceBreathDebuff);
		public function IceBreathDebuff() {
			super(TYPE, 'spe');
		}

		override protected function apply(firstTime:Boolean):void {
			buffHost('spe', -25);
		}
	}

}