extends Control

@export var help_message: Control

func _ready():
	set_default()
	
func set_default():
	show()
	if help_message:
		help_message.visible = true



func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_H and help_message:
			help_message.visible = !help_message.visible
		if event.keycode == KEY_CAPSLOCK:
			visible = !visible
