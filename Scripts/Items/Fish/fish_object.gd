extends Node2D
class_name FishObject

@export var data: FishData = null

func _ready():
	if data == null:
		push_warning("Fish: "+ name +"has no data")
