extends StorageLevel

func _ready():
	spawn_x_range = Vector2(192, 960)
	spawn_y_range = Vector2(64,400)
	super()

func enter():
	super()
	for object in spawned_objects:
		object.lock_rotation = true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("cancel"):
		GameManager.PopupClose.emit()
	if Input.is_action_just_pressed("bag_open"):
		InventoryManager.PlayerBagOpen(inventory_name)
