extends CharacterBody2D
class_name Player

@export var anim_player: AnimationPlayer
@export var sprite: AnimatedSprite2D

enum State {IDLE, WALK}

var state = State.IDLE

const SPEED = 3500

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		print(direction)
		state = State.WALK
		if direction == -1:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
		velocity.x = direction * SPEED * delta
	else:
		state = State.IDLE
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	state_update()
	move_and_slide()
	
func state_update():
	match state:
		State.IDLE:
			if !anim_player.is_playing():
				anim_player.play("idle")
		State.WALK:
			anim_player.play("walk")
