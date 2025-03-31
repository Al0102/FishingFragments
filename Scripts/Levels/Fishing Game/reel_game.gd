extends Control
class_name ReelGame

@export var control_node:  Control
@export var progress_bar: VSlider

enum STATUS {HOOKED, ESCAPED, CAPTURED}

# progress is percent (Failure) 0 - 100 (Success)
var progress: float:
	set(value):
		progress_bar.value = 100-round(value)
		progress = value

var fish_strength: float
var pull_strength: float
const MIN_PULL_STRENGTH = 0.5
const ENERGY_DEPLETE_FACTOR = 0.15

func _ready():
	exit()

func start(
		_fish_strength: float = 20.0,
		_pull_stength: float = 5.5,
		_start_progress: float = 30.0):
	fish_strength = _fish_strength
	pull_strength = _pull_stength
	progress = _start_progress
	
	# Game complete already, don't want to flash ui
	if progress >= 100:
		return
	
	show()
	process_mode = Node.PROCESS_MODE_INHERIT

func exit():
	hide()
	process_mode = Node.PROCESS_MODE_DISABLED
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Fish tug
	progress -= fish_strength*delta
	# Energy depletion
	pull_strength = max(
		MIN_PULL_STRENGTH,
		pull_strength-pull_strength*ENERGY_DEPLETE_FACTOR*delta)
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				progress += pull_strength

# enum of reeling progress
func check_success():
	# Fish escaped
	if progress <= 0:
		return STATUS.ESCAPED
	# Fish caught
	if progress >= 100:
		return STATUS.CAPTURED
	return STATUS.HOOKED
	
