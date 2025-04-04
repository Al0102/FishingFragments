extends StorageLevel

func _ready():
	spawn_x_range = Vector2(192, 960)
	spawn_y_range = Vector2(192,320)
	super()

func enter():
	super()
	for object in spawned_objects:
		object.lock_rotation = true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("bucket_open") or (
		Input.is_action_just_pressed("escape")):
		GameManager.PopupClose.emit()
	if Input.is_action_just_pressed("bag_open"):
		InventoryManager.PlayerBagOpen(inventory_name)

func _physics_process(delta: float) -> void:
	if randf() < 0.02:
		for object in spawned_objects:
			object.apply_central_impulse(
				Vector2(randi_range(-10,10),randi_range(-10,10)))
	
