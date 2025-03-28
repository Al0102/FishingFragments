extends StateRod
class_name State_Rod_Idle_In

@export var cast_state: State

func _ready():
	print(name,"initialised")
	
func enter():
	super()
	rod.animation_states.travel("idle in")
	
func process(delta) -> State:
	if Input.is_action_just_pressed("interact"):
		return cast_state
	return null
	
func input(event: InputEvent) -> State:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_LEFT:
				return cast_state
	return null
