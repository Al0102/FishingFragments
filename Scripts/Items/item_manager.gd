extends Node

const RESOURCE_DIR = "res://Resources/Items"


var fish_resources: Dictionary = {
	"placeholder": preload("res://Resources/Items/Fish/placeholder_fish.tres"),
	"swordfish": "swordfish_fish.tres",
	"seastar": "seastar_fish.tres",
	"jellyfish": "jellyfish_fish.tres",
	"sunfish": "sunfish_fish.tres",
	"flounder": "flounder_fish,tres",
	"anchovy": "anchovy_fish.tres",
	"redfish": "redfish_fish.tres",
	"pompano": "pompano_fish.tres",
	"bonefish": "bonefish_fish.tres",
	"tuna": "tuna_fish.tres",
	"cobia": "cobia_fish.tres",
	"mahimahi": "mahimahi_fish.tres",
	"pufferfish": "pufferfish_fish.tres",
	"grouper": "grouper_fish.tres"
} # String: Resource

var OBJECT_TYPES: Dictionary = {
	"FISH": FishObject
}
var pickable_object = preload("res://Scenes/pickable_object.tscn")

func new_item(data: Item):
	var item: ItemObject
	if data.get("TYPE"):
		#item = OBJECT_TYPES[data.TYPE].new()
		item = FishObject.new()
	else: 
		item = ItemObject.new()
	item.data = data
	item.sprite.texture = data.texture
	item.collision_shape.polygon = data.pickable_object.shape_points.polygon
	item.scale(data.pickable_object.scale)
	return item

func new_fish(type: String):
	assert(fish_resources.has(type), "Fish: <"+type+"> does not exist")
	return new_item(get_fish_data(type))

	
func get_fish_data(type: String):
	assert(fish_resources.has(type), "Fish: <"+type+"> does not exist")
	if fish_resources[type] is String:
		fish_resources[type] = load(RESOURCE_DIR + "/Fish/"+ fish_resources[type])
	return fish_resources[type]
