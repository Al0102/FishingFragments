extends Node

const RESOURCE_DIR = "res://Resources/Items"


var fish_resources: Dictionary = {
	"placeholder": preload("res://Resources/Items/Fish/placeholder_fish.tres"),
	"swordfish": "swordfish_fish.tres",
} # String: Resource


func new_fish(type: String):
	assert(fish_resources.has(type), "Fish: <"+type+"> does not exist")
	var fish = FishItem.new()
	fish.data = get_fish_data(type)
	return fish
	
func get_fish_data(type: String):
	assert(fish_resources.has(type), "Fish: <"+type+"> does not exist")
	if fish_resources[type] is String:
		fish_resources[type] = load(RESOURCE_DIR + "/Fish/"+ fish_resources[type])
	return fish_resources[type]
