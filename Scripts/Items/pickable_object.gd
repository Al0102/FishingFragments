extends RigidBody2D

class_name PickableObject

signal clicked

var held = false
const MOUSE_DRAG_FORCE = 115

func _init():
	add_to_group("pickable")
	input_event.connect(_on_input_event)
	held = false
	
	input_pickable = true
	
	set_collision_mask_value(3, true)
	var pm = PhysicsMaterial.new()
	pm.bounce = 0.4
	physics_material_override = pm

func _ready():
	add_to_group("pickable")
	input_event.connect(_on_input_event)
	held = false

func _on_input_event(viewport, event, shape_idx):
	print("inputevent")
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			print("clicked")
			clicked.emit(self)
			
func _physics_process(delta: float) -> void:
	if held:
		var canvas = get_canvas_transform()
		var topleft = -canvas.origin / canvas.get_scale()-Vector2(50,50)
		var canvas_size = get_viewport_rect().size / canvas.get_scale()+Vector2(50,50)
		var mouse_pos = get_global_mouse_position()
		
		mouse_pos.x = clamp(mouse_pos.x,topleft.x,topleft.x+canvas_size.x)
		mouse_pos.y = clamp(mouse_pos.y,topleft.y,topleft.y+canvas_size.y)
		var dir_force: Vector2 = (mouse_pos-global_position-linear_velocity)*MOUSE_DRAG_FORCE*delta
		apply_central_force(dir_force)

		
func pickup():
	if held:
		return
	z_index = 1000
	# container collisions false but window border still true
	set_collision_mask_value(1,false)
	set_collision_layer_value(1, false)
	# force applied to object too weak to overcome gravity, so set to 0 while held
	gravity_scale = 0
	held = true
	
func drop(impulse=Vector2.ZERO):
	if held:
		z_index = 1
		set_collision_mask_value(1,true)
		set_collision_layer_value(1, true)
		gravity_scale = 1
		
		# Throwing the object
		apply_central_force(impulse.normalized()*MOUSE_DRAG_FORCE)
		held = false
		
