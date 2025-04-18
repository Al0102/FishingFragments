extends Level

@export var anim_player: AnimationPlayer
@export var page_left: Node
@export var page_right: Node

@export var num_left: RichTextLabel
@export var num_right: RichTextLabel

@export var page_contents: Array[PageData]

@export_range(0,14) var current_flipped_page: int = 0

signal page_flipped(new_page: int)
signal edge_reached(edge: BookArrow.EDGE)


func enter():
	super()
	anim_player.play("RESET")
	anim_player.play("bob arrow")
	
	current_flipped_page = -1
	flip_page(-get_max_flips())
	

func flip_page(flip_amount: int):
	if !flip_amount:
		return
	var new_page = min(
		max(0,current_flipped_page + flip_amount),
		get_max_flips())
	if current_flipped_page == new_page:
		return
	current_flipped_page = new_page
	
	anim_player.play(
		"page flip left" if flip_amount > 0
		else "page flip right")
	page_flipped.emit(new_page)
	
	if new_page == 0:
		edge_reached.emit(BookArrow.EDGE.LEFT)
	if new_page == get_max_flips():
		edge_reached.emit(BookArrow.EDGE.RIGHT)

func display_current_page():
	if page_contents.is_empty():
		return
		
	num_left.text = str(get_index_left()+1)
	num_right.text = str(get_index_right()+1)
	page_left.texture = page_contents[get_index_left()].texture
	if (
			ItemManager.get_fish_data(
				page_contents[get_index_left()].content)) in (
			ProgressManager._load().collected_fish):
		page_left.show()
	if get_index_right() < len(page_contents):
		page_right.texture = page_contents[get_index_right()].texture
		if (
			ItemManager.get_fish_data(
				page_contents[get_index_right()].content)) in (
			ProgressManager._load().collected_fish):
			page_right.show()
	else:
		page_right.texture = null
	

func get_max_flips():
	return floor(len(page_contents)/2)
	
func get_index_left():
	return current_flipped_page*2

func get_index_right():
	return current_flipped_page*2+1

func _ready() -> void:
	enter()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("book_open") or (
			Input.is_action_just_pressed("cancel")):
		GameManager.PopupClose.emit()
	if Input.is_action_just_pressed("right"):
		flip_page(1)
	if Input.is_action_just_pressed("left"):
		flip_page(-1)
		
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_released() and event.button_index == MOUSE_BUTTON_LEFT:
			var v = Input.get_last_mouse_velocity().x
			if v != 0 and abs(v)>80:
				flip_page(-v/abs(v))
				
				
