extends Node2D

class_name Level

@export var camera: Camera2D

func enter():
	print(name, "entered")
	camera.make_current()

func exit():
	print(name, "exited")

func _ready():
	pass

func reload():
	pass
