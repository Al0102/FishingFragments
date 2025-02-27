extends Node

var portals = {
	"door_inside":{
		"level_to": "Inside"},
	"door_outside":{
		"level_to": "Outside"},
}
func _ready():
	for portal in portals.keys():
		var portal_node =  get_node(portal)
		if portal_node:
			portals[portal]["player_pos"] = portal_node.destination.global_position

func interact_portal(name: String):
	GameManager.SetPlayerPosition.emit(Vector2(100000,100000))
	GameManager.ChangeLevel.emit(portals[name]["level_to"])
	for i in range(100000):
		continue
	GameManager.SetPlayerPosition.emit(portals[name]["player_pos"])
