extends Resource
class_name PickableObjectData

@export var shape_points: Vector2ArrayResource

@export_custom(PROPERTY_HINT_LINK, "scale.x:scale.y")
var scale: Vector2 = Vector2(1.0,1.0)
