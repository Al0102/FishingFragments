extends Level

@export var rod: Node2D

func _ready() -> void:
	print("In here")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		GameManager.PopupClose.emit()
	if Input.is_action_just_pressed("interact"):
		rod.animation_states.travel("cast")
