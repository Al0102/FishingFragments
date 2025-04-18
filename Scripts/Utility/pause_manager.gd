extends CanvasLayer

@export var pause_screen: Node

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		pause_screen.visible = !pause_screen.visible
