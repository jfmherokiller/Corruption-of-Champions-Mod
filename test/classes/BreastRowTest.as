package classes{
    import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	
	import classes.BreastRow;
	import classes.lists.BreastCup;
	import classes.internals.SerializationUtils;
	
	public class BreastRowTest {
		private static const DEFAULT_NUMBER_OF_BREASTS:Number = 2;
		private static const DEFAULT_NIPPLES_PER_BREAST:Number = 1;
		private static const DEFAULT_BREAST_RATING:Number = BreastCup.FLAT;
		private static const DEFAULT_LACTATION_MULTIPLIER:Number = 0;
		private static const DEFAULT_MILK_FULLNESS:Number = 0;
		private static const DEFAULT_FULLNESS:Number = 0;
		private static const DEFAULT_FUCKABLE:Boolean = false;
		private static const DEFAULT_NIPPLE_COCKS:Boolean = false;
		
		private static const DESERIALIZE_NUMBER_OF_BREASTS:Number = 3;
		private static const DESERIALIZE_NIPPLES_PER_BREAST:Number = 4;
		private static const DESERIALIZE_BREAST_RATING:Number = BreastCup.C;
		private static const DESERIALIZE_LACTATION_MULTIPLIER:Number = 2;
		private static const DESERIALIZE_MILK_FULLNESS:Number = 3;
		private static const DESERIALIZE_FULLNESS:Number = 4;
		private static const DESERIALIZE_FUCKABLE:Boolean = true;
		private static const DESERIALIZE_NIPPLE_COCKS:Boolean = true;
		
		private var cut:BreastRow;
		private var toSerialize:BreastRow;
		private var deserialized:BreastRow;

		
		private var serializedClass:*;


		[Before]
		public function setUp():void {
			cut = new BreastRow();
			toSerialize = new BreastRow();
			deserialized = new BreastRow();
			
			serializedClass = [];

			buildSerializedclass();
			
			SerializationUtils.serialize(serializedClass, toSerialize);
			SerializationUtils.deserialize(serializedClass, deserialized);
		}
		
		private function buildSerializedclass():void
		{
			toSerialize.breasts = DESERIALIZE_NUMBER_OF_BREASTS;
			toSerialize.nipplesPerBreast = DESERIALIZE_NIPPLES_PER_BREAST;
			toSerialize.breastRating = DESERIALIZE_BREAST_RATING;
			toSerialize.lactationMultiplier = DESERIALIZE_LACTATION_MULTIPLIER;
			toSerialize.milkFullness = DESERIALIZE_MILK_FULLNESS;
			toSerialize.fullness = DESERIALIZE_FULLNESS;
			toSerialize.fuckable = DESERIALIZE_FUCKABLE;
			toSerialize.nippleCocks = DESERIALIZE_NIPPLE_COCKS;
		}
		
		[Test]
		public function defaultNumberOfBreasts():void
		{
			assertThat(cut.breasts, equalTo(DEFAULT_NUMBER_OF_BREASTS));
		}
		
		[Test]
		public function defaultNumberOfNipples():void
		{
			assertThat(cut.nipplesPerBreast, equalTo(DEFAULT_NIPPLES_PER_BREAST));
		}
		
		[Test]
		public function defaultBreastRating():void
		{
			assertThat(cut.breastRating, equalTo(DEFAULT_BREAST_RATING));
		}
		
		[Test]
		public function defaultLactationMultiplier():void
		{
			assertThat(cut.lactationMultiplier, equalTo(DEFAULT_LACTATION_MULTIPLIER));
		}
		
		[Test]
		public function defaultMilkFullness():void
		{
			assertThat(cut.milkFullness, equalTo(DEFAULT_MILK_FULLNESS));
		}
		
		[Test]
		public function defaultFullness():void
		{
			assertThat(cut.fullness, equalTo(DEFAULT_FULLNESS));
		}
		
		[Test]
		public function defaultFuckableBreasts():void
		{
			assertThat(cut.fuckable, equalTo(DEFAULT_FUCKABLE));
		}
		
		[Test]
		public function defaultNippleCocks():void
		{
			assertThat(cut.nippleCocks, equalTo(DEFAULT_NIPPLE_COCKS));
		}
		
		/**
		 * Serialization Tests
		 */
		
		[Test]
		public function serializeNumberOfBreasts():void
		{
			assertThat(serializedClass, hasProperty('breasts', DESERIALIZE_NUMBER_OF_BREASTS));
		}
		
		[Test]
		public function serializeNumberOfNipples():void
		{
			assertThat(serializedClass, hasProperty('nipplesPerBreast', DESERIALIZE_NIPPLES_PER_BREAST));
		}
		
		[Test]
		public function serializeBreastRating():void
		{
			assertThat(serializedClass, hasProperty('breastRating', DESERIALIZE_BREAST_RATING));
		}
		
		[Test]
		public function serializeLactationMultiplier():void
		{
			assertThat(serializedClass, hasProperty('lactationMultiplier', DESERIALIZE_LACTATION_MULTIPLIER));
		}
		
		[Test]
		public function serializeMilkFullness():void
		{
			assertThat(serializedClass, hasProperty('milkFullness', DESERIALIZE_MILK_FULLNESS));
		}
		
		[Test]
		public function serializeFullness():void
		{
			assertThat(serializedClass, hasProperty('fullness', DESERIALIZE_FULLNESS));
		}
		
		[Test]
		public function serializeFuckableBreasts():void
		{
			assertThat(serializedClass, hasProperty('fuckable', DESERIALIZE_FUCKABLE));
		}
		
		[Test]
		public function serializeNippleCocks():void
		{
			assertThat(serializedClass, hasProperty('nippleCocks', DESERIALIZE_NIPPLE_COCKS));
		}
		
		/**
		 * Deserialization Tests
		 */
		
		[Test]
		public function deserializeNumberOfBreasts():void
		{
			assertThat(deserialized.breasts, equalTo(DESERIALIZE_NUMBER_OF_BREASTS));
		}
		
		[Test]
		public function deserializeNumberOfNipples():void
		{
			assertThat(deserialized.nipplesPerBreast, equalTo(DESERIALIZE_NIPPLES_PER_BREAST));
		}
		
		[Test]
		public function deserializeBreastRating():void
		{
			assertThat(deserialized.breastRating, equalTo(DESERIALIZE_BREAST_RATING));
		}
		
		[Test]
		public function deserializeLactationMultiplier():void
		{
			assertThat(deserialized.lactationMultiplier, equalTo(DESERIALIZE_LACTATION_MULTIPLIER));
		}
		
		[Test]
		public function deserializeMilkFullness():void
		{
			assertThat(deserialized.milkFullness, equalTo(DESERIALIZE_MILK_FULLNESS));
		}
		
		[Test]
		public function deserializeFullness():void
		{
			assertThat(deserialized.fullness, equalTo(DESERIALIZE_FULLNESS));
		}
		
		[Test]
		public function deserializeFuckableBreasts():void
		{
			assertThat(deserialized.fuckable, equalTo(DESERIALIZE_FUCKABLE));
		}
		
		[Test]
		public function deserializeNippleCocks():void
		{
			assertThat(deserialized.nippleCocks, equalTo(DESERIALIZE_NIPPLE_COCKS));
		}
		
		[Test]
		public function breastRowFixNoNipples():void
		{
			serializedClass.serializationVersionDictionary = [];
			serializedClass.nipplesPerBreast = 0;
			
			SerializationUtils.deserialize(serializedClass, deserialized);
			
			assertThat(deserialized.nipplesPerBreast, equalTo(1));
		}
		
		[Test]
		public function breastRowFixNegativeLactationMultiplier():void
		{
			serializedClass.serializationVersionDictionary = [];
			serializedClass.lactationMultiplier = -42;
			
			SerializationUtils.deserialize(serializedClass, deserialized);
			
			assertThat(deserialized.lactationMultiplier, equalTo(0));
		}
		
		[Test]
		public function breastRowFixNegativeBreastRating():void
		{
			serializedClass.serializationVersionDictionary = [];
			serializedClass.breastRating = -42;
			
			SerializationUtils.deserialize(serializedClass, deserialized);
			
			assertThat(deserialized.breastRating, equalTo(BreastCup.FLAT));
		}
	}
}
