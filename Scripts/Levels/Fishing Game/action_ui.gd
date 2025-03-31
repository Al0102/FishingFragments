extends Control

@export var fish_captured: TextureRect
 
@onready var animation_player = $AnimationPlayer
@onready var alert = $FishHookedAlert

func _ready() -> void:
	animation_player.animation_finished.connect(_on_animation_finished)
	_on_animation_finished()

func play_alert():
	animation_player.play("fish hooked alert")
	print("play catch")

func play_captured(fish_texture: Texture = preload("res://Resources/Atlas_Resources/default.tres")):
	fish_captured.texture = fish_texture
	animation_player.play("fish captured")
	print("play catch")
	
func _on_animation_finished():
	animation_player.play("RESET")
	fish_captured.texture = null
