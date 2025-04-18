extends Node

const SAVE_DIR = "user://"

var progress = ProgressData.new()

func _ready():
	if !DirAccess.dir_exists_absolute(SAVE_DIR):
		DirAccess.make_dir_absolute(SAVE_DIR)
	if !FileAccess.file_exists(SAVE_DIR+"progress.tres"):
		_save()
	progress = load(SAVE_DIR+"progress.tres")
	for fish in progress.collected_fish:
		print(fish.name)
		
func _save() -> Error:
	return ResourceSaver.save(progress, SAVE_DIR+"progress.tres")
	
func _load() -> ProgressData:
	return progress
	
func reset_all():
	progress = ProgressData.new()
	_save()
	
	
