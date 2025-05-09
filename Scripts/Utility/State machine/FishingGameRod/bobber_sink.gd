extends StateRod
class_name State_Rod_Bobber_Sink

@export var reel_state: State
@export var idle_out_state: State

@export var loot_table: LootTable

var anim_length: float
var anim_position: float
var anim: String

func enter():
	super()
	hook_fish()
	rod.fish_hooked.emit(rod.hooked_fish)
	rod.animation_states.travel("bobber sink")

func process(delta) -> State:
	anim_length = rod.animation_states.get_current_length()
	anim_position = rod.animation_states.get_current_play_position()
	anim = rod.animation_states.get_current_node()
	
	if Input.is_action_just_pressed("interact"):
		return reel_state

	if anim_position >= anim_length and anim == "bobber sink": 
			rod.animation_states.travel("bobber float")
			return null
	# Extra time and makes empty reels less likely
	if anim_position >= anim_length/2 and anim == "bobber float":
		rod.hooked_fish = null
		return idle_out_state
	return null

func input(event: InputEvent) -> State:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_LEFT:
				hook_fish()
				return reel_state
	return null

# TODO
func hook_fish():
	rod.hooked_fish = ItemManager.new_fish(loot_table.random_item().name)
	print("hooked")
	
