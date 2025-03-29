extends Control

@export var help_message: Control

func _ready():
	set_default()
	
func set_default():
	show()
	help_message.visible = false
	
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_H:
			help_message.visible = !help_message.visible
		if event.keycode == KEY_CAPSLOCK:
			visible = !visible
