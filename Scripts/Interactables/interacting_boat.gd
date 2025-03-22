extends Node

var portals = {
	"door_inside":{
		"level_to": "Inside"},
	"door_outside":{
		"level_to": "Outside"},
}

var storage_levels = {
	"cupboard": "Cupboard"
}

func _ready():
	# Portal Destinations
	for portal in portals.keys():
		var portal_node =  get_node(portal)
		if portal_node:
			portals[portal]["player_pos"] = portal_node.destination.global_position

func interact_portal(name: String):
	GameManager.ChangeLevel.emit(portals[name]["level_to"])
	
	var new_pos = portals[name].get_or_add("player_pos", Vector2(0,0))
	GameManager.SetPlayerPosition.emit(portals[name]["player_pos"])

func interact_storage(name: String):
	print(name)
	GameManager.PopupOpen.emit("world_ui", storage_levels[name])
