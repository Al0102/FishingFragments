extends StateRod
class_name State_Rod_Reel

@export var idle_in_state: State
@export var idle_out_state: State

# progress is percent (Failure) 0% - 100% (Success)
var progress: float = 0
const START_PROGRESS = 0.5

# Delete once fish difficulty is added
var fish_strength = 0.2

var pull_strength: float = 0.1

# user alternates up and down to reel in fish
var up_pressed: bool = false

func enter():
	super()
	rod.animation_states.travel("reel")
	
	progress = START_PROGRESS
	
func exit():
	rod.hooked_fish = null

func process(delta) -> State:
	# Input
	if (up_pressed and Input.is_action_just_pressed("down")) or (!up_pressed and Input.is_action_just_pressed("up")):
		progress += pull_strength
		up_pressed = !up_pressed
		
	# Fish swim away (decrease in progress)
	progress -= fish_strength*delta
	print(progress)
	
	# Check success status
	
	# Fish escaped
	if progress <= 0:
		return idle_out_state
		
	# Fish caught
	if progress >= 1 or rod.hooked_fish == null:
		rod.animation_states.travel("reel success")
		return idle_in_state
	return null
