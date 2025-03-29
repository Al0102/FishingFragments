extends Node

@export var debug_on: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_toggle"):
		debug_on = !debug_on
