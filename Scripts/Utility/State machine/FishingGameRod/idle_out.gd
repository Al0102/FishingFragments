extends StateRod
class_name State_Rod_Idle_Out

@export var reel_state: State
@export var bobber_sink_state: State

@export_range(0.0,1.0)
var chance_per_second: float:
	set(value):
		chance_per_second = value/60.0

func enter():
	super()
	rod.animation_states.travel("idle out")

func process(delta) -> State:
	if Input.is_action_just_pressed("interact"):
		return reel_state
	return null

func physics(delta) -> State:
	if roll_is_fish_hooked():
		return bobber_sink_state
	return null

func roll_is_fish_hooked() -> bool:
	var x = randf()
	print(x)
	return x <= chance_per_second
