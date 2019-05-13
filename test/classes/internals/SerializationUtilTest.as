package classes.internals
{
	import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	import org.hamcrest.collection.*;
	
	import classes.internals.Serializable;
	
	public class SerializationUtilTest
	{
		private static const TEST_INSTANCES:int = 5;
		private static const SERIAL_VERSION:int = 2;
		private static const SERIAL_VERSION_V2:int = 7;
		private static const SERIAL_UUID:String = "11111111-2222-3333-4444-555555555555";
		
		private var testObject:Array;
		private var testVector:Vector.<Serializable>;
		private var deserializedVector:Vector.<*>;
		private var serializedObject:*;
		private var dummy:SerializationDummy;
		
		private function buildVector(instances:int):void
		{
			for (var i:int = 0; i < instances; i++)
			{
				testVector.push(new SerializationDummy(i, i + 1));
			}
		}
		
		private function getTestObject():* {
			return SerializationUtils.serializeVector(testVector as Vector.<*>);
		}
		
		[Before]
		public function setUp():void
		{
			testObject = null;
			testVector = new Vector.<Serializable>();
			deserializedVector = new Vector.<*>();
			
			serializedObject = [];
			serializedObject.serializationVersion = SERIAL_VERSION;
			serializedObject.serializationVersionDictionary = [];
			serializedObject.serializationVersionDictionary[SERIAL_UUID] = SERIAL_VERSION_V2;
			
			dummy = new SerializationDummy();
			
			buildVector(TEST_INSTANCES);
		}
		
		[Test]
		public function serializeVectorObjectSize():void
		{
			testObject = getTestObject();
			
			assertThat(testObject, arrayWithSize(TEST_INSTANCES));
		}
		
		[Test]
		public function serializeVectorLastObjectValue():void
		{
			testObject = getTestObject();
			
			assertThat(testObject[TEST_INSTANCES - 1], hasProperties({foo: TEST_INSTANCES - 1, bar: TEST_INSTANCES}));
		}
		
		[Test]
		public function deserializeVectorSize():void {
			testObject = getTestObject();
			
			SerializationUtils.deserializeVector(deserializedVector, testObject, SerializationDummy);
			
			assertThat(deserializedVector, arrayWithSize(TEST_INSTANCES));
		}
		
		[Test]
		public function deserializeVectorType():void {
			testObject = getTestObject();
			
			SerializationUtils.deserializeVector(deserializedVector,testObject, SerializationDummy);
			
			assertThat(deserializedVector[TEST_INSTANCES - 1], instanceOf(SerializationDummy));
		}
		
		[Test]
		public function deserializeVectorLastElementProperties():void {
			testObject = getTestObject();
			
			SerializationUtils.deserializeVector(deserializedVector, testObject, SerializationDummy);
			
			assertThat(deserializedVector[TEST_INSTANCES - 1], hasProperties({foo: 42}));
			assertThat((deserializedVector[TEST_INSTANCES - 1] as SerializationDummy).getBar(), equalTo(TEST_INSTANCES));
		}
		
		[Test(expected="ArgumentError")]
		public function deserializeWithNonSerializableType():void {
			SerializationUtils.deserializeVector(new Vector.<*>(), new Array(), String);
		}
				
		[Test(expected="ArgumentError")]
		public function deserializeWithNullDestination():void {
			SerializationUtils.deserializeVector(null, new Array(), SerializationDummy);
		}
		
		[Test(expected="ArgumentError")]
		public function deserializeWithNullSource():void {
			SerializationUtils.deserializeVector(new Vector.<*>(), null, SerializationDummy);
		}
		
		[Test]
		public function castVectorCheckProperties():void {
			var destinationVector:Vector.<SerializationDummy> = new Vector.<SerializationDummy>();
			
			SerializationUtils.castVector(destinationVector, testVector, SerializationDummy);
			
			assertThat(destinationVector[TEST_INSTANCES - 1], hasProperties({foo: TEST_INSTANCES - 1}));
			assertThat(destinationVector[TEST_INSTANCES - 1].getBar(), equalTo(TEST_INSTANCES));
		}
		
		[Test]
		public function castVectorCheckType():void {
			var destinationVector:Vector.<SerializationDummy> = new Vector.<SerializationDummy>();
			
			SerializationUtils.castVector(destinationVector, testVector, SerializationDummy);
			
			assertThat(destinationVector[TEST_INSTANCES - 1], instanceOf(SerializationDummy));
		}
		
		[Test]
		public function legacySerializationVersionWithNoProperty():void {
			serializedObject = [];
			
			assertThat(SerializationUtils.legacySerializationVersion(serializedObject), equalTo(0));
		}
		
		[Test]
		public function legacySerializationVersionWithProperty():void {
			assertThat(SerializationUtils.legacySerializationVersion(serializedObject), equalTo(SERIAL_VERSION));
		}
		
		[Test]
		public function serializationVersionWithNoProperty():void {
			serializedObject = [];
			
			assertThat(SerializationUtils.serializationVersion(serializedObject, dummy), equalTo(0));
		}
		
		[Test]
		public function serializationVersionWithProperty():void {
			assertThat(SerializationUtils.serializationVersion(serializedObject, dummy), equalTo(SERIAL_VERSION_V2));
			}
		
		[Test]
		public function serializedVersionCheckSerializedGreater():void {
			assertThat(SerializationUtils.serializedVersionCheck(serializedObject, 1, dummy), equalTo(false));
		}
		
		[Test]
		public function serializedVersionCheckSerializedEqual():void {
			assertThat(SerializationUtils.serializedVersionCheck(serializedObject, 7, dummy), equalTo(true));
		}
		
		[Test]
		public function serializedVersionCheckSerializedLess():void {
			assertThat(SerializationUtils.serializedVersionCheck(serializedObject, 8, dummy), equalTo(true));
		}
		
		[Test(expected="RangeError")]
		public function serializedVersionCheckThrowErrorGreater():void {
			SerializationUtils.serializedVersionCheckThrowError(serializedObject, 1, dummy);
		}
		
		[Test]
		public function serializedVersionCheckThrowErrorEqual():void {
			SerializationUtils.serializedVersionCheckThrowError(serializedObject, 7, dummy);
		}
		
		[Test]
		public function serializedVersionCheckThrowErrorLess():void {
			SerializationUtils.serializedVersionCheckThrowError(serializedObject, 8, dummy);
		}
		
		[Test]
		public function deserializeClass():void {
			serializedObject['foo'] = 1;
			serializedObject['bar'] = 2;
			
			SerializationUtils.deserialize(serializedObject, dummy);
			
			assertThat(serializedObject, hasProperties({foo: 42}));
		}
		
		[Test(expected="ArgumentError")]
		public function deserializeWithInvalidRootObject():void {
			SerializationUtils.deserialize(undefined, dummy);
		}
				
		[Test(expected="ArgumentError")]
		public function deserializeWithInvalidClassInstance():void {
			SerializationUtils.deserialize(serializedObject, undefined);
		}

		[Test(expected="RangeError")]
		public function deserializeFromNewerVersion():void {
			serializedObject["serializationVersion"] = int.MAX_VALUE;
			
			SerializationUtils.deserialize(serializedObject, dummy);
		}
		
		[Test(expected = "ArgumentError")]
		public function serializeWithInvalidRootObject():void {
			SerializationUtils.serialize(null, dummy);
		}
		
		
		[Test(expected = "ArgumentError")]
		public function serializeWithInvalidClassInstance():void {
			SerializationUtils.serialize(serializedObject, null);
		}
		
		[Test]
		public function serialize():void {
			SerializationUtils.serialize(serializedObject, dummy);
			
			assertThat(serializedObject, hasProperties({foo: -1, bar: -1, serializationVersion: SERIAL_VERSION}));
		}
		
		[Test]
		public function objectIsUsingV1Serialization():void {
			assertThat(SerializationUtils.isUsingV1Serialization(serializedObject), true);
		}
		
		[Test]
		public function objectIsNotUsingV1Serialization():void {
			assertThat(SerializationUtils.isUsingV1Serialization([]), false);
		}
		
		[Test]
		public function serializationVersionV2WithEntry():void {
			serializedObject = [];
			serializedObject.serializationVersionDictionary = [];
			serializedObject.serializationVersionDictionary[SERIAL_UUID] = SERIAL_VERSION_V2;
			
			
			assertThat(SerializationUtils.serializationVersion(serializedObject,dummy), SERIAL_VERSION_V2);
		}
		
		[Test]
		public function serializationVersionV2WithoutEntry():void {
			serializedObject = [];
			serializedObject.serializationVersionDictionary = [];
			serializedObject.serializationVersionDictionary["abc"] = SERIAL_VERSION_V2;
			
			
			assertThat(SerializationUtils.serializationVersion(serializedObject,dummy), 0);
		}
		
		[Test]
		public function serializationVersionUpgradeCopiesVersion():void {
			serializedObject['foo'] = 1;
			serializedObject['bar'] = 2;
			
			SerializationUtils.deserialize(serializedObject, dummy);
			
			//TODO using the UUID variable gets interpreted as literal, is there a way to use variables?
			assertThat(serializedObject.serializationVersionDictionary, hasProperties({"11111111-2222-3333-4444-555555555555": 2}));
		}
		
		[Test]
		public function serializationVersionUpgradeRemovesV1SerializationVersion():void {
			serializedObject['foo'] = 1;
			serializedObject['bar'] = 2;
			
			SerializationUtils.deserialize(serializedObject, dummy);
			
			assertThat(serializedObject, not(hasProperty("serializationVersion")));
		}
	}
}

import classes.internals.Serializable;
import flash.errors.IllegalOperationError;

class SerializationDummy implements Serializable
{
	public var foo:int;
	private var bar:int;
	
	public function SerializationDummy(foo:int = -1, bar:int = -1)
	{
		this.foo = foo;
		this.bar = bar;
	}
	
	public function getBar():int {
		return this.bar;
	}
	
	public function serialize(relativeRootObject:*):void
	{
		relativeRootObject.foo = foo;
		relativeRootObject.bar = bar;
	}
	
	public function deserialize(relativeRootObject:*):void
	{
		this.foo = relativeRootObject.foo;
		this.bar = relativeRootObject.bar;
	}
	
	public function upgradeSerializationVersion(relativeRootObject:*, serializedDataVersion:int):void 
	{
		switch(serializedDataVersion) {
			case 2:
				relativeRootObject.foo = 42;
		}
	}
	
	public function currentSerializationVerison():int 
	{
		return 2;
	}
	
	public function serializationUUID():String 
	{
		return "11111111-2222-3333-4444-555555555555"
	}
}
