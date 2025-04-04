extends Node2D

class_name InteractArea

@onready var area = $interactArea2D/CollisionShape2D
@export var label: Sprite2D

func showLabel():
	label.modulate.a = 255
func hideLabel():
	label.modulate.a = 0
	
func _ready():
	hideLabel()

func _on_interact_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GameManager.can_interact_with_me.emit(self)
		print("player in")

func _on_interact_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		GameManager.cannot_interact_with_me.emit(self)
		print("player out")
