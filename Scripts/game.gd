extends Node2D

@export var level_Outside: Level
@export var level_Inside: Level
@onready var levels = {
	"Outside":level_Outside,
	"Inside":level_Inside}

@onready var player = $Player

var current_level: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# connect signals
	GameManager.connect("ChangeLevel", _on_change_level)
	GameManager.connect("SetPlayerPosition", _on_set_player_position)
	
	for level_name: String in levels:
		remove_child(get_node(level_name))
		
	current_level = "Outside"
	add_child(level_Outside)

func switch_level(new_level):
	remove_child(levels[current_level])
	current_level = new_level
	add_child(levels[current_level])


func _on_change_level(new_level: String) -> void:
	switch_level(new_level)

func _on_set_player_position(position: Vector2) -> void:
	player.position = position
