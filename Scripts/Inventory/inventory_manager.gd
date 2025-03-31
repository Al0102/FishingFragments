extends Node

const SAVE_DIR = "user://inventory_saves/"

var inventory_files: Dictionary = {
	"bucket": "bucket.tres"
}

func _ready():
	if !DirAccess.dir_exists_absolute(SAVE_DIR):
		DirAccess.make_dir_absolute(SAVE_DIR)

func _save(name: String, inventory_data: Inventory) -> Error:
	assert(name in inventory_files, "Inventory: " + name + "does not exist")
		
	return ResourceSaver.save(inventory_data, SAVE_DIR+inventory_files[name])
	
func _load(name: String) -> Inventory:
	assert(name in inventory_files, "Inventory: " + name + "does not exist")
	return load(SAVE_DIR + inventory_files[name])
