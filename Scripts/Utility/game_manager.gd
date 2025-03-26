extends Node

enum Scenes {FISHING}
var current_scene: Scenes

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
signal PopupOpen
signal PopupClose

# Interactable signals
signal can_interact_with_me
signal cannot_interact_with_me 
