extends StorageLevel

func _ready() -> void:
	super()
	spawn_x_range = Vector2(320, 800)
	spawn_y_range = Vector2(128,548)
	
	InventoryManager.player_bag_open.connect(_on_bag_open)
	item_portals[0].inventory_to = "_delete"

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("bag_open") or (
		Input.is_action_just_pressed("escape")):
		InventoryManager.PlayerBagClose()

func _on_bag_open(_inventory_name):
	item_portals[0].inventory_to = _inventory_name
	
func exit():
	super()
	item_portals[0].inventory_to = "_delete"
