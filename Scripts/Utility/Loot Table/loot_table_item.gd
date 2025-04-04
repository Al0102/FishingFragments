extends Resource
class_name LootTableItem

@export_range(0, 10.0, 0.1, "or_greater")
var weight: float

@export var item: Item:
	set(value):
		if !value:
			print("LootTableItem: "+str(self)+" has no item")
			return
		item = value
		if value.get("rarity"):
			weight = value.rarity
