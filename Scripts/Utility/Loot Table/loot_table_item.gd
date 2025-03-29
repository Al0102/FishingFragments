extends Resource
class_name LootTableItem

@export var item: Item

@export_range(0, 10.0, 0.1, "or_greater")
var weight: float
