package classes
{
	import classes.internals.Serializable;
	
	/**
	 * Tracks item type and quantity. 
	 */
	public class ItemSlot extends Object implements Serializable
	{
		private static const SERIALIZATION_VERSION:int = 2;
		private static const SERIALIZATION_UUID:String = "6c697f95-8c00-4082-9d28-39c1d6c147cd";
		
		private static const LEGACY_SHORTNAME_GROPLUS:String = "Gro+";
		private static const LEGACY_SHORTNAME_SPECIAL_HONEY:String = "Sp Honey";
		
		private var _quantity:int = 0;
		private var _itype:ItemType = ItemType.NOTHING;
		private var _unlocked:Boolean = false;
		private var _damage:int = 0; //Used for durability
		
		/**
		 * Set the type of item and quantity of items in this slot.
		 * 
		 * @param	itype type of item in this slot. If null, the slot will be empty
		 * @param	quant amount of the item in this slot, must be greater than zero or the slot will be empty
		 */
		public function setItemAndQty(itype:ItemType, quant:int):void
		{
			if (itype == null) itype = ItemType.NOTHING;
			if (quant == 0 && itype == ItemType.NOTHING) {
				emptySlot();
				return;
			}
			if (quant<0 || quant == 0 && itype != ItemType.NOTHING || quant>0 && itype == ItemType.NOTHING){
				CoC_Settings.error("Inconsistent setItemAndQty call: "+quant+" "+itype);
				quant = 0;
				itype = ItemType.NOTHING;
			}
			this._quantity = quant;
			this._itype = itype;
		}
		
		/**
		 * Clears this slot, removing all items contained in it.
		 */
		public function emptySlot():void
		{
			this._quantity = 0;
			this._itype = ItemType.NOTHING;
		}

		/**
		 * Removes one item from the stack of items in this slot.
		 * The item count in this slot will be decremented and if the last item is removed the slot will
		 * be set to empty.
		 * Will output an error if trying to remove an item from an empty slot.
		 */
		public function removeOneItem():void
		{
			if (this._quantity == 0)
				CoC_Settings.error("Tried to remove item from empty slot!");
			if (this._quantity > 0)
				this._quantity -= 1;

			if (this._quantity == 0)
				this._itype = ItemType.NOTHING;
		}

		/**
		 * Get the number of items in this slot.
		 * @return the number of items / size of the item stack. Returns 0 if empty.
		 */
		public function get quantity():int {
			return _quantity;
		}
		
		/**
		 * Set the number of items in this slot / item stack size.
		 * @param value the size of the item stack
		 */
		public function set quantity(value:int):void {
			if (value > 0 && _itype == null) CoC_Settings.error("ItemSlot.quantity set with no item; use setItemAndQty instead!");
			if (value == 0) _itype = ItemType.NOTHING;
			_quantity = value;
		}

		/**
		 * Get the item type that is stored in this slot.
		 * @return the item type in the slot. Returns ItemType.NOTHING if empty.
		 */
		public function get itype():ItemType {
			return _itype;
		}
		
		/**
		 * Check if this slot has been unlocked.
		 * 
		 * @return true if the slot has been unloked and is available
		 */
		public function get unlocked():Boolean {
			return _unlocked;
		}
		
		/**
		 * Set the unlocked state of the slot, which is used to determine if items can be stored in the slot.
		 * @param value if true, the slot is unlocked
		 */
		public function set unlocked(value:Boolean):void {
			if (_unlocked != value){
				emptySlot();
			}
			_unlocked = value;
		}
		
		/**
		 * Check if the slot is empty, i.e. contains no items.
		 * @return true if empty
		 */
		public function isEmpty():Boolean
		{
			return _quantity<=0;
		}
		
		public function serialize(relativeRootObject:*):void 
		{
			relativeRootObject.quantity = this._quantity;
			relativeRootObject.id = this.itype.id;
			relativeRootObject.unlocked = this._unlocked;
			relativeRootObject.damage = this._damage;
		}
		
		public function deserialize(relativeRootObject:*):void 
		{
			this._quantity = relativeRootObject.quantity;
			this._itype = ItemType.lookupItem(relativeRootObject.id);
			this._unlocked = relativeRootObject.unlocked;
			this._damage = relativeRootObject.damage;
		}
		
		public function upgradeSerializationVersion(relativeRootObject:*, serializedDataVersion:int):void 
		{
			switch (serializedDataVersion) {
				case 0:
					convertLegacyShortNameToId(relativeRootObject);
				
				case 1:
					setZeroQuantitySlotToEmpty(relativeRootObject);
					
				default:
					/*
					 * The default block is left empty intentionally,
					 * this switch case operates by using fall through behavior.
					 */
			}
		}
		
		private function convertLegacyShortNameToId(relativeRootObject:*):void
		{
			if (!relativeRootObject.shortName) {
				return;
			}
			
			if (relativeRootObject.shortName.indexOf("Gro+") != -1) {
				relativeRootObject.id = "GroPlus";
			} else if (relativeRootObject.shortName.indexOf("Sp Honey") != -1) {
				relativeRootObject.id = "SpHoney";
			} else {
				relativeRootObject.id = ItemType.lookupItemByShort(relativeRootObject.shortName).id;
			}
		}
		
		private function setZeroQuantitySlotToEmpty(relativeRootObject:*):void
		{
			if (relativeRootObject.quantity === 0) {
				relativeRootObject.id = "NOTHING!";
			}
		}
		
		public function currentSerializationVerison():int 
		{
			return SERIALIZATION_VERSION;
		}
		
		public function serializationUUID():String 
		{
			return SERIALIZATION_UUID;
		}
		
		/**
		 * Set the damage of the item(s)? Used for item degredation?
		 * @param value unknown what range value this should be, or how the value reflects damage
		 */
		public function set damage(value:int):void {
			this._damage = value;
		}
		
		/**
		 * Get the damage of the item(s)? Used for item degredation?
		 * @return unknown what range value this should be, or how the value reflects damage
		 */
		public function get damage():int {
			return this._damage;
		}
	}
}
