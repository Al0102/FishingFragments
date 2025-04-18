extends StateRod
class_name State_Rod_Reel

@export var idle_in_state: State
@export var idle_out_state: State
@export var reel_game: ReelGame

# user alternates up and down to reel in fish
var up_pressed: bool = false

func enter():
	super()
	rod.animation_states.travel("reel")
	if rod.hooked_fish == null:
		reel_game.start(0,100,100)
	else:
		# TODO replace arguments with fish data
		reel_game.start(
			rod.hooked_fish.data.strength,
			reel_game.START_PULL_STRENGTH+10/rod.hooked_fish.data.get_weight())
		print(rod.hooked_fish.data.name)
		print(rod.hooked_fish.data.strength)

func exit():
	rod.hooked_fish = null
	reel_game.exit()

func process(delta) -> State:
	# Check success status
	match reel_game.check_success():
		# Fish escaped
		reel_game.STATUS.ESCAPED:
			return idle_out_state
		# Fish caught
		reel_game.STATUS.CAPTURED:
			print("success")
			
			rod.animation_states.travel("reel success")
			rod.fish_captured.emit(rod.hooked_fish)
			return idle_in_state
		# Default
		_:
			return null
