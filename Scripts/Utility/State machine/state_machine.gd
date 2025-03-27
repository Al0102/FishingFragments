extends Node2D
class_name StateMachine

@export
var states: Array[State]

var current_state: State
var prev_state: State

func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED

func start():
	if states.size() > 0: 
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT

func stop():
	process_mode = Node.PROCESS_MODE_DISABLED

func _process(delta: float) -> void:
	change_state(current_state.process(delta))

func _physics_process(delta: float) -> void:
	change_state(current_state.physics(delta))
	
func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.input(event))
	
func change_state(new_state: State):
	if new_state == null or new_state == current_state:
		return

	if current_state:
		current_state.exit()

	prev_state = current_state
	current_state = new_state

	current_state.enter()
	
	
