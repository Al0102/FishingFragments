extends Node2D

@export var animation_tree: AnimationTree
@export var state_machine: StateMachine

@onready var animation_states = animation_tree["parameters/playback"]

signal fish_hooked(fish_item: FishItem)
signal fish_captured(fish_item: FishItem)

var hooked_fish: FishItem = null

func _ready() -> void:
	if Debug.debug_on: print("Rod init")
