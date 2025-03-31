extends StorageLevel

func _ready() -> void:
	print("hi")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		print("pressed")
		GameManager.PopupClose.emit(-1)
