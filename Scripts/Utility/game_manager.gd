extends Node

func pause_node(node: Node):
	if node is Node2D:
		node.visible = false
	node.process_mode = Node.PROCESS_MODE_DISABLED
	
func unpause_node(node: Node):
	if node is Node2D:
		node.visible = true
	node.process_mode = Node.PROCESS_MODE_INHERIT

# SIGNALS
# Game signals
signal SetPlayerPosition
signal ChangeLevel
signal PopupOpen(popup_world: String, popup_level: String)
signal PopupClose(index: int)

# Interactable signals
signal can_interact_with_me
signal cannot_interact_with_me 
