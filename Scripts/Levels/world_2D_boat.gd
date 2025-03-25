extends Level

@export var interactables: Node2D

var interacting_with: InteractArea

func _ready():
	GameManager.connect("can_interact_with_me", _can_interact)
	GameManager.connect("cannot_interact_with_me", _cannot_interact)

func _can_interact(interactable: InteractArea) -> void:
	print("poop")
	interacting_with = interactable
	
func _cannot_interact() -> void:
	interacting_with = null

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if interacting_with == null:
			print("null")
			return
		print("interact:"+interacting_with.name)
		if interacting_with.TYPE == "portal":
			interactables.interact_portal(interacting_with.name)
		elif interacting_with.TYPE == "ui":
			interactables.interact_ui(interacting_with.name)
