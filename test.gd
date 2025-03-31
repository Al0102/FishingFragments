extends Node2D

@export var player: CharacterBody2D
@export_range(0,10, 1, "or_greater")
var i: int

var paused = false

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		i -= 1
		print(i)
		#if not paused:
			#$interactArea.process_mode = Node.PROCESS_MODE_DISABLED
		#else:
			#$interactArea.process_mode = Node.PROCESS_MODE_INHERIT
		#paused = not paused
