extends Node2D

@export var animation_tree: AnimationTree
@export var state_machine: StateMachine

@onready var animation_states = animation_tree["parameters/playback"]

func _process(delta: float) -> void:
	state_machine.process()
