extends Node
class_name Game


@export_group("levels")
@export var level_Outside: Level
@export var level_Inside: Level
@export var level_Storage: Level
@export var level_Fishing: Level

@onready var levels = {
	"Outside":level_Outside,
	"Inside":level_Inside,
	"Cupboard": level_Storage,
	"Fishing": level_Fishing}


@export_group("worlds")
@export var world_2D: Node
@export var world_ui: Node

@onready var worlds = {
	"world_2D": {
		"node": world_2D,
		"levels": ["Outside", "Inside"]},
	"world_ui": {
		"node": world_ui,
		"levels": [
			"Cupboard",
			"Fishing"
		]
	}
}

@export_group("")
@export var player: CharacterBody2D


var current_level: String:
	get():
		return current_level
	set(value):
		assert(
			value in worlds[current_world]["levels"],
			"level doesn't exist in current_world")
		current_level = value
var current_world: String:
	get():
		return current_world
	set(value):
		assert(
			value in worlds,
			"world doesn't exist")
		current_world = value
var popups = [] # {"world": Node2D world, "level": Level}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# connect signals
	GameManager.connect("PopupOpen", _on_popup_open)
	GameManager.connect("PopupClose", _on_popup_close)
	
	GameManager.connect("ChangeLevel", _on_change_level)
	GameManager.connect("ChangeWorld", _on_change_world)
	GameManager.connect("SetPlayerPosition", _on_set_player_position)
	
	# Clear up every level so only the starting one exists
	for world: Dictionary in worlds.values():
		for level_name: String in world["levels"]:
			world["node"].remove_child(levels[level_name])
		remove_child(world["node"])
		
		
	# Startup world
	current_world = "world_2D"
	current_level = "Outside"
	add_child(worlds[current_world]["node"])
	worlds[current_world]["node"].add_child(levels[current_level])


func switch_level(new_level: String):
	levels[current_level].exit()
	worlds[current_world]["node"].remove_child(levels[current_level])
	current_level = new_level
	worlds[current_world]["node"].add_child(levels[current_level])
	levels[current_level].enter()

func switch_world(new_world: String, new_level: String):
	remove_child(worlds[current_world]["node"])
	current_world = new_world
	add_child(worlds[current_world]["node"])
	switch_level(new_level)

func _on_change_level(new_level: String) -> void:
	switch_level(new_level)
func _on_change_world(new_world: String, new_level: String) -> void:
	switch_level(new_level)

func _on_popup_open(popup_world: String, popup_level: String) -> void:
	assert((
			popup_world in worlds and (
			popup_level in worlds[popup_world]["levels"])),
			"popup world or level doesn't exist")
	
	# Pause and destroy lower
	GameManager.pause_node(levels[current_level])
	GameManager.pause_node(worlds[current_world]["node"])
	if not popups.is_empty():
		GameManager.pause_node(popups[-1]["world"])
		GameManager.pause_node(popups[-1]["level"])

	# Open new popup
	popups.append({
		"world": worlds[popup_world]["node"],
		"level": levels[popup_level]})
	# Actual opening of the level
	add_child(popups[-1]["world"])
	popups[-1]["world"].add_child(popups[-1]["level"])
	popups[-1]["level"].enter()

# Closes popup of popups[index] and everything after as well
func _on_popup_close(index: int=-1) -> void:
	# Errors
	if popups.is_empty():
		print("tried to close non-existant popup")
		return
	var size = popups.size()
	if index >= size:
		print("index out of bounds of popups")
		return
		
	# Main Code
	if index < 0:
		index = size + index
	for i in range(size-1,index-1,-1):
		GameManager.unpause_node(popups[i]["world"])
		GameManager.unpause_node(popups[i]["level"])
		
		popups[i]["level"].exit()
		popups[i]["world"].remove_child(popups[i]["level"])
		if popups[i]["world"] != worlds[current_world]["node"]:
			remove_child(popups[i]["world"])
		popups.pop_back()
		
	if popups.is_empty():
		GameManager.unpause_node(worlds[current_world]["node"])
		GameManager.unpause_node(levels[current_level])
		levels[current_level].enter()
	else:
		GameManager.unpause_node(popups[index-1]["world"])
		GameManager.unpause_node(popups[index-1]["level"])
		popups[index-1]["level"].enter()

# sets global pos of player (e.g. for portals/switching levels)
func _on_set_player_position(position: Vector2) -> void:
	player.global_position = position
