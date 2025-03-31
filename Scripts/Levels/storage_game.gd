extends Level
class_name StorageLevel

@export var inventory: Inventory = Inventory.new([])
@export var inventory_name: String = ""
var spawned_objects: Array[PickableObject]

var held_object = false

func _ready():
	# Inventory
	inventory = InventoryManager._load(inventory_name)
	
	# Pickables
	for node in get_tree().get_nodes_in_group("pickable"):
		print("hi")
		node.clicked.connect(_on_pickable_clicked)

func enter():
	super()
	for item_stack in inventory.items:
		print("name: ", item_stack.item,"\namount: ",item_stack.quantity)

func exit():
	InventoryManager._save(inventory_name, inventory)
	for object in spawned_objects:
		object.queue_free()

func _process(delta: float) -> void:
	print("processing")
	if Input.is_action_just_pressed("escape"):
		GameManager.PopupClose.emit()
		
	
func _on_pickable_clicked(object):
	if !held_object:
		object.pickup()
		held_object = object

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if held_object and !event.pressed:
			held_object.drop(Input.get_last_mouse_velocity())
			held_object = null
