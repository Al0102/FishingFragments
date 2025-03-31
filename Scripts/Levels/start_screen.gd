extends Level

@export var start_button: BaseButton

signal game_start


func _ready() -> void:
	start_button.pressed.connect(_on_start_button_pressed)

func _on_start_button_pressed():
	game_start.emit()
