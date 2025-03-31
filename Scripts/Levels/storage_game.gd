extends Level

@export var inventory: Inventory

var held_object = false

func _ready():
	for node in get_tree().get_nodes_in_group("pickable"):
		print("hi")
		node.clicked.connect(_on_pickable_clicked)
		
func _process(delta: float) -> void:
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
