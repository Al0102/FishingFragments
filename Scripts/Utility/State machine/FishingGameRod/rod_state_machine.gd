extends StateMachine
class_name RodStateMachine

@export var rod: Node2D

func _ready():
	super()
	StateRod.rod = rod

func start():
	if states.size() > 0: 
		rod.animation_states.start("Start")
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT

func stop():
	change_state(states[0])
	rod.animation_states.start("End")
	process_mode = Node.PROCESS_MODE_DISABLED
	super()

func _process(delta: float) -> void:
	super(delta)

func _physics_process(delta: float) -> void:
	super(delta)
	
func _input(event: InputEvent) -> void:
	super(event)
