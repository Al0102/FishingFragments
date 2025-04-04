extends Node

const PATH = "res://Resources/Loot Tables/fish_loot_table.tres"

func _ready() -> void:
	var table = LootTable.new()
	for fish in ItemManager.fish_resources:
		var loot_item = LootTableItem.new()
		loot_item.item = ItemManager.get_fish_data(fish)
		table.itemList.append(loot_item)
	ResourceSaver.save(table, PATH)
		
