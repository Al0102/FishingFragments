extends Node2D

@export var animation_tree: AnimationTree
@export var state_machine: StateMachine

@onready var animation_states = animation_tree["parameters/playback"]

signal fish_captured(fish_item: Fish)

var hooked_fish: Fish = null

func _ready() -> void:
	print("Rod init")

func _process(delta: float) -> void:
	if hooked_fish:
		print(hooked_fish)
