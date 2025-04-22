extends Control

signal UI_hints_off
signal UI_hints_on

@export var help_message: Control

func _ready():
	set_default()
	
func set_default():
	show()
	if help_message:
		help_message.visible = true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("hide_hints"):
		if visible:
			UI_hints_off.emit()
			visible = false
		else:
			UI_hints_on.emit()
			visible = true
	

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_H and help_message:
			help_message.visible = !help_message.visible
