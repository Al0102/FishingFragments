extends Node

func pause_node(node: Node, hide: bool=true):
	if node is Node2D and hide:
		node.visible = false
	node.process_mode = Node.PROCESS_MODE_DISABLED
	
func unpause_node(node: Node):
	if node is Node2D:
		node.visible = true
	node.process_mode = Node.PROCESS_MODE_INHERIT

func reset_save():
	InventoryManager.reset_all()
	ProgressManager.reset_all()
	
func quit_game():
	ProgressManager._save()
	InventoryManager.save_all()
	get_tree().quit()


# SIGNALS
# Game signals
signal SetPlayerPosition
signal ChangeLevel
signal PopupOpen(popup_world: String, popup_level: String)
signal PopupClose(index: int)
signal WorldChanged(new_world: String)

signal ReloadGame

# Interactable signals
signal can_interact_with_me
signal cannot_interact_with_me 
