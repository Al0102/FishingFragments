extends Level
class_name StorageLevel

@export var inventory: Inventory = null
@export var inventory_name: String = ""
@export var controls_ui: Control
@export var item_portals: Array[ItemPortal]

@export_group("spawn area")
@export var spawn_x_range: Vector2
@export var spawn_y_range: Vector2


@export var spawned_objects: Array[PickableObject]
var is_spawned = false

var held_object = false

func _ready():
	super()
	# Inventory
	inventory = InventoryManager._load(inventory_name)
	InventoryManager.item_added.connect(_on_item_added)
	
	if controls_ui:
		controls_ui.UI_hints_on.connect(_on_hints_on)
		controls_ui.UI_hints_off.connect(_on_hints_off)
	for portal in item_portals:
		portal.item_teleported.connect(_on_item_teleported)
	for item_stack in inventory.items:
		var item = item_stack.item
		print("name: ", item.name,"\namount: ",item_stack.quantity)
		for i in range(item_stack.quantity):
			spawn_item(item)

func enter():
	super()
	inventory = InventoryManager._load(inventory_name)
	if is_spawned:
		return
	is_spawned = true

	#for node in get_tree().get_nodes_in_group("pickable"):

func exit():
	if held_object:
		held_object.drop(Input.get_last_mouse_velocity())
		held_object = null
	InventoryManager._save(inventory_name, inventory)
	#for object in spawned_objects:
		#object.queue_free()
	#spawned_objects.clear()
	is_spawned = false


func spawn_item(item: Item):
	var _item = ItemManager.new_item(item)
	add_child(_item)
	_item.clicked.connect(_on_pickable_clicked)
	_item.position = Vector2(
	randi_range(spawn_x_range.x,spawn_x_range.y),
	randi_range(spawn_y_range.x,spawn_y_range.y))
	spawned_objects.append(_item)

func _on_item_teleported(item: ItemObject):
	spawned_objects.erase(item)
	inventory.drop_item(item.data)
	item.queue_free()

func _on_item_added(_inventory_name, item: Item):
	if inventory_name == _inventory_name:
		spawn_item(item)

func _on_hints_on():
	for portal in item_portals:
		print("POR",portal)
		portal.monitoring = true
func _on_hints_off():
	for portal in item_portals:
		print("PR",portal)
		portal.monitoring = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("cancel"):
		GameManager.PopupClose.emit()
	if Input.is_action_just_pressed("interact"):
		inventory.add_item(ItemManager.get_fish_data("placeholder"), 3)
	if Input.is_action_just_pressed("down"):
		inventory.drop_item(ItemManager.get_fish_data("placeholder"), 1)
	
func _on_pickable_clicked(object):
	if !held_object:
		object.pickup()
		held_object = object

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if held_object and !event.is_pressed():
			held_object.drop(Input.get_last_mouse_velocity())
			
			held_object.set_collision_layer_value(GameManager.MASK_ITEM_PORTAL,true)
			await get_tree().create_timer(.01).timeout
			if held_object:
				held_object.set_collision_layer_value(GameManager.MASK_ITEM_PORTAL,false)
			
			held_object = null
			
