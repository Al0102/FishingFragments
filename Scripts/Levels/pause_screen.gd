extends Control

@export var resume_button: BaseButton
@export var home_button: BaseButton
@export var quit_button: BaseButton


func _ready() -> void:
	hide()
	resume_button.pressed.connect(_on_resume_button_pressed)
	home_button.pressed.connect(_on_home_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)

		
func _on_resume_button_pressed():
	get_tree().paused = !get_tree().paused
	hide()

func _on_home_button_pressed():
	get_tree().paused = !get_tree().paused
	GameManager.ReloadGame.emit()
	
func _on_quit_button_pressed():
	GameManager.quit_game()
