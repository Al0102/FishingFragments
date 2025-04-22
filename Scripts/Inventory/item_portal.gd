extends Area2D
class_name ItemPortal

@export var inventory_to: String = "_delete"

signal item_teleported(item: ItemObject)

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	set_collision_mask_value(1,false)
	set_collision_mask_value(GameManager.MASK_ITEM_PORTAL,true)
	

func _on_body_entered(body: Node2D):
	print("eeeee")
	if body is ItemObject:
		InventoryManager.add_to_inventory(
			inventory_to,body.data,1)
		item_teleported.emit(body)
