extends StateRod
class_name State_Rod_Cast

@export var idle_out_state: State

var anim_length: float

func enter():
	super()
	rod.animation_states.travel("cast")

func process(delta) -> State:
	anim_length = rod.animation_states.get_current_length()
	if (rod.animation_states.get_current_play_position()) >= (
			anim_length):
		return idle_out_state
	return null
