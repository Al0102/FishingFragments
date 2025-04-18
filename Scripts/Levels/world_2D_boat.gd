extends Level

@export var interactables: Node2D

var interacting_with: Array[InteractArea] = []

func _ready():
	GameManager.can_interact_with_me.connect( _can_interact)
	GameManager.cannot_interact_with_me.connect(_cannot_interact)


func _can_interact(interactable: InteractArea) -> void:
	if !interacting_with.is_empty():
		interacting_with[-1].hideLabel()
	interacting_with.append(interactable)
	interactable.showLabel()
	print(interacting_with)
	
func _cannot_interact(interactable: InteractArea) -> void:
	interactable.hideLabel()
	interacting_with.erase(interactable)
	if !interacting_with.is_empty():
		interacting_with[-1].showLabel()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("bag_open"):
		InventoryManager.PlayerBagOpen()
	
	if Input.is_action_just_pressed("interact"):
		if interacting_with.is_empty():
			print("null")
			return
		print("interact:"+str(interacting_with))
		if interacting_with[-1].TYPE == "portal":
			interactables.interact_portal(interacting_with[-1].name)
		elif interacting_with[-1].TYPE == "ui":
			interactables.interact_ui(interacting_with[-1].name)
