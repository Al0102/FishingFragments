extends Area2D
class_name ItemPortal

@export var inventory_to: String = "_delete"

signal item_teleported(item: ItemObject)

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D):
	if body is ItemObject:
		InventoryManager.add_to_inventory(
			inventory_to,body.data,1)
		item_teleported.emit(body)
