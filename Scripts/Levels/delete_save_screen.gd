extends Level


@export var confirm_button: BaseButton
@export var reject_button: BaseButton

func enter():
	if camera:
		super()

func _ready() -> void:
	confirm_button.pressed.connect(_on_confirm)
	reject_button.pressed.connect(_on_cancel)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("cancel"):
		_on_cancel()

func _on_confirm():
	GameManager.reset_save()
	GameManager.ReloadGame.emit()
	
func _on_cancel():
	GameManager.PopupClose.emit()
