extends Node


signal item_added(inventory_name: String, item: Item)
signal player_bag_open(inventory_name: String)
signal player_bag_close()


const SAVE_DIR = "res://inventory_saves/"

var inventory_files: Dictionary = {
	"player_bag": "player_bag.tres",
	"bucket": "bucket.tres"
}

var inventories_cache: Dictionary = {}

func _ready():
	if !DirAccess.dir_exists_absolute(SAVE_DIR):
		DirAccess.make_dir_absolute(SAVE_DIR)
		
func _notification(event):
	if event == MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT or event == MainLoop.NOTIFICATION_PREDELETE:
		for inventory_name in inventories_cache:
			_save(inventory_name, inventories_cache[inventory_name])

func _save(name: String, inventory_data: Inventory) -> Error:
	assert(name in inventory_files, "Inventory: " + name + "does not exist")
	inventory_data.update()
		
	return ResourceSaver.save(inventory_data, SAVE_DIR+inventory_files[name])
	
func _load(name: String) -> Inventory:
	assert(name in inventory_files, "Inventory: " + name + "does not exist")

	var inventory = inventories_cache.get_or_add(
		name, load(SAVE_DIR + inventory_files[name]))
	inventory.update()
	
	return inventory


func add_to_inventory(inventory_name: String, item: Item, amount: int):
	if inventory_name == "_delete":
		return
	var inventory = _load(inventory_name)
	inventory.add_item(item, amount)
	item_added.emit(inventory_name, item)
	
func PlayerBagOpen(inventory_name: String = ""):
	if inventory_name not in inventory_files:
		inventory_name = "_delete"
	GameManager.PopupOpen.emit("world_ui", "PlayerBag")
	player_bag_open.emit(inventory_name)
	
func PlayerBagClose():
	GameManager.PopupClose.emit()
	player_bag_close.emit()
