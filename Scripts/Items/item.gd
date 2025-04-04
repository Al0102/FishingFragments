extends Resource
class_name Item

@export var id: int = 0
@export var name: String = ""
@export var texture: Texture2D = AtlasTexture.new()

@export var pickable_object: PickableObjectData = PickableObjectData.new()
