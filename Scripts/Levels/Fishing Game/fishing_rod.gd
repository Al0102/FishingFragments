extends Node2D

@export var animation_tree: AnimationTree
@export var state_machine: StateMachine

@onready var animation_states = animation_tree["parameters/playback"]

signal fish_hooked(fish_item: ItemObject)
signal fish_captured(fish_item: ItemObject)

var hooked_fish: ItemObject = null

func _ready() -> void:
	print("Rod init")
