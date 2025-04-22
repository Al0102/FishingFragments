extends ItemObject
class_name FishObject

@export var v: Vector2 = Vector2(1,1)

func _physics_process(delta: float) -> void:
	super(delta)
	if randf() < 0.02:
		v = Vector2(randi_range(-10,10),randi_range(-10,10))
		apply_central_impulse(v)
		if linear_velocity.x > 0:
			sprite.flip_h = true
			if collision_shape.scale.x > 0:
				collision_shape.apply_scale(Vector2(-1,1))
		else:
			sprite.flip_h = false
			if collision_shape.scale.x <= 0:
				collision_shape.apply_scale(Vector2(-1,1))
	
