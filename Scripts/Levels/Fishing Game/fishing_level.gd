extends Level

@export var rod: Node2D

@export var actionUI: Control

func enter():
	super()
	actionUI.animation_player.play("RESET")
	rod.state_machine.stop()
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
	if Input.is_action_just_pressed("cancel"):
		GameManager.PopupClose.emit()
	elif Input.is_action_just_pressed("bucket_open"):
		GameManager.PopupOpen.emit("world_ui", "Bucket")

		
func _on_fish_hooked(fish: ItemObject):
	print("hookedalert")
	actionUI.play_alert()

func _on_fish_captured(fish: ItemObject):
	if fish:
		actionUI.play_captured(fish.data.texture)
		InventoryManager.add_to_inventory("bucket", fish.data, 1)
		if fish.data not in ProgressManager._load().collected_fish:
			ProgressManager._load().collected_fish.append(fish.data)
			ProgressManager._save()
		
