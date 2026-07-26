extends Node
#class_name Glboals
@export var roc_colur : Color = Color.from_hsv(randf(),1.0,1.0)
@export var hit_positions : PackedFloat64Array = [1]
@export var level_seed : int = 3

@export var LEVEL_FAILED_SCREEN : PackedScene = preload("res://scene/level_failed_screen.tscn")
@export var LEVEL_PASSED_SCREEN : PackedScene = preload("res://scene/level_passed_screen.tscn")
