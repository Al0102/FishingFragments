extends PickableObject
class_name ItemObject

@export var data: Item = null
@export var sprite: Sprite2D = Sprite2D.new()
@export var collision_shape: CollisionPolygon2D = CollisionPolygon2D.new()

func _init() -> void:
	super()
	add_child(sprite)
	add_child(collision_shape)

func _ready():
	super()
	if data == null:
		push_warning("Item: "+ name +"has no data")

func scale(new_scale: Vector2):
	sprite.apply_scale(new_scale)
	collision_shape.apply_scale(new_scale)
	
