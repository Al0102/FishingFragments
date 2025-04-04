extends Level

@export var start_button: BaseButton

signal game_start


func _ready() -> void:
	start_button.pressed.connect(_on_start_button_pressed)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		game_start.emit()
		
func _on_start_button_pressed():
	game_start.emit()
