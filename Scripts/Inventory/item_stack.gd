extends Resource
class_name ItemStack

@export var item: Item
@export_range(0,100,1,"or_greater") var quantity: int:
	set(value):
		quantity = max(0, value)
		
func _init(_item: Item = null, _quantity: int = 0):
	item = _item
	quantity = _quantity
