extends Level

@export var rod: Node2D

func enter():
	super()
	rod.state_machine.start()

func exit():
	super()
	rod.state_machine.stop()

func _ready() -> void:
	print("Fishing level")
	enter()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		GameManager.PopupClose.emit()
