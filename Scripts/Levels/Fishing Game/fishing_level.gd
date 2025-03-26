extends Level

@export var rod: Node2D

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		GameManager.PopupClose.emit()
	if Input.is_action_just_pressed("interact"):
		rod.animation.play("cast")
