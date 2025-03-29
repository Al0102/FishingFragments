extends Node2D

@export var animation_tree: AnimationTree
@export var state_machine: StateMachine

@onready var animation_states = animation_tree["parameters/playback"]

signal fish_captured(fish_item: FishObject)

var hooked_fish: FishObject = null

func _ready() -> void:
	if Debug.debug_on: print("Rod init")
