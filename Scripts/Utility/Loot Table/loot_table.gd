extends Resource
class_name LootTable

@export var itemList: Array[LootTableItem]

func random_item() -> Item:
	var total_weight = 0
	var cumululative_weights = []
	
	for item in itemList:
		print(item.item.get("rarity"))
		total_weight += item.weight
		cumululative_weights.append([item.item,total_weight])
	
	var chance_roll = randf_range(0,total_weight)
	for weight in cumululative_weights:
		if chance_roll < weight[1]:
			return weight[0]
	
	return null
