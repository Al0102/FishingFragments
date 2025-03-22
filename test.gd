extends Node2D

@export var player: CharacterBody2D

var paused = false

func _ready() -> void:
	for i in range(8,5,-1):
		print(i)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if not paused:
			$interactArea.process_mode = Node.PROCESS_MODE_DISABLED
		else:
			$interactArea.process_mode = Node.PROCESS_MODE_INHERIT
		paused = not paused
