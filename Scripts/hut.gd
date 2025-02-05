extends Node2D


@export var outer_hut: Sprite2D

@onready var room_area = $RoomArea

@onready var animation_player = $AnimationPlayer


func _on_room_area_body_entered(_body):
	animation_player.play("Entered")

func _on_room_area_body_exited(_body):
	animation_player.play_backwards("Entered")
