extends Node

enum Scenes {FISHING}
var current_scene: Scenes

# SIGNALS

# Game signals
signal SetPlayerPosition
signal ChangeLevel

# Interactable signals
signal can_interact_with_me
signal cannot_interact_with_me 
