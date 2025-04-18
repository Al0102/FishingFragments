extends Item
class_name FishData

enum RARITY {DEFAULT,COMMON = 100, UNCOMMON = 60, RARE=10, LEGENDARY=5, MYTHICAL=1}

@export_range(0.0,100.0, 0.5,"or_greater")
var strength: float = 25

@export var rarity: RARITY = RARITY.COMMON

@export_range(0.1, 100, 0.1, "or_greater", "suffix:lbs")
var weight: float:
	set(value):
		weight = max(0.01,abs(value))

@export_range(0, 50, 0.1, "or_greater", "suffix:lbs")
var weight_deviation: float = 5:
	set(value):
		weight_deviation = abs(value)

func get_weight():
	return weight+randf_range(0,weight_deviation)
