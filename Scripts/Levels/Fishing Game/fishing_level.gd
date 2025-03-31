extends Level

@export var rod: Node2D

@export var actionUI: Control

func enter():
	super()
	rod.state_machine.start()

func exit():
	super()
	rod.state_machine.stop()
	rod.hooked_fish = null

func _ready() -> void:
	rod.fish_hooked.connect(_on_fish_hooked)
	rod.fish_captured.connect(_on_fish_captured)
	
	enter()

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("escape"):
		GameManager.PopupClose.emit()
		
func _on_fish_hooked(fish: FishItem):
	print("hookedalert")
	actionUI.play_alert()

func _on_fish_captured(fish: FishItem):
	if fish:
		actionUI.play_captured(fish.data.texture)
