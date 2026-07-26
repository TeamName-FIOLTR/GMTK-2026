extends Node
#class_name Glboals
@export var roc_colur : Color = Color.from_hsv(randf(),1.0,1.0)
@export var level_seed : int = 3
@export var unlocked_levels : int = 3

@export var hit_positions : PackedFloat64Array = [1]

@export var LEVEL_FAILED_SCREEN : PackedScene = preload("res://scene/level_failed_screen.tscn")
@export var LEVEL_PASSED_SCREEN : PackedScene = preload("res://scene/level_passed_screen.tscn")

@export var total_altitude : float = 0

func _ready() -> void:
	var file = FileAccess.open('user://save.txt',FileAccess.READ)
	if file:
		unlocked_levels = file.get_64()

func generate_new_level():
	load_level(level_seed + 1)

func load_level(seed_to_load : int)->void:
	if seed_to_load > self.unlocked_levels:
		self.unlocked_levels = seed_to_load
		var file = FileAccess.open('user://save.txt',FileAccess.WRITE)
		if file:
			file.store_64(unlocked_levels)
			file.close()

	level_seed = seed_to_load
	seed(level_seed)

	Glboals.roc_colur = Color.from_hsv(randf(),1,1)
	self.hit_positions = [1]

	if seed_to_load == 3: return #ensure tutorial level only ever has 1 roc

	for i in range(int(randf()*5) + Glboals.level_seed*3):
		self.hit_positions.append(self.hit_positions[-1] + randf()*0.3 + 0.1)
