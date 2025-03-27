extends StateMachine
class_name RodStateMachine

@export var rod: Node2D

func _ready():
	super()
	StateRod.rod = rod

func start():
	if states.size() > 0: 
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT

func _process(delta: float) -> void:
	super(delta)

func _physics_process(delta: float) -> void:
	super(delta)
