extends CanvasLayer

@export var world_name: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.WorldChanged.connect(_on_world_changed)

func _on_world_changed(new_world):
	if new_world != world_name:
		hide()
	else:
		show()
