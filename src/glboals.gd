extends Node
#class_name Glboals
@export var roc_colur : Color = Color.from_hsv(randf(),1.0,1.0)
@export var level_seed : int = 3

@export var hit_positions : PackedFloat64Array = [1]

@export var LEVEL_FAILED_SCREEN : PackedScene = preload("res://scene/level_failed_screen.tscn")
@export var LEVEL_PASSED_SCREEN : PackedScene = preload("res://scene/level_passed_screen.tscn")


func generate_new_level():
	Glboals.level_seed += 1
	seed(Glboals.level_seed)

	Glboals.roc_colur = Color.from_hsv(randf(),1,1)
	self.hit_positions = [1]
	for i in range(int(randf()*5) + Glboals.level_seed*3):
		self.hit_positions.append(self.hit_positions[-1] + randf()*0.3 + 0.1)
