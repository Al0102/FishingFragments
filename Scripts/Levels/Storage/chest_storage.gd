extends StorageLevel

func _ready() -> void:
	spawn_x_range = Vector2(250, 750)
	spawn_y_range = Vector2(64,400)
	super()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("cancel"):
		GameManager.PopupClose.emit()
	if Input.is_action_just_pressed("bag_open"):
		InventoryManager.PlayerBagOpen(inventory_name)
