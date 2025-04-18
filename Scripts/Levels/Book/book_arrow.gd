extends Control
class_name BookArrow

enum EDGE {LEFT, RIGHT}

@export var book: Node
@export var side: EDGE

func _ready() -> void:
	hide()
	book.edge_reached.connect(_on_edge_reached)
	book.page_flipped.connect(_on_page_flipped)

func _on_edge_reached(edge: EDGE):
	if edge == side:
		hide()
		
func _on_page_flipped(new_page):
	show()
