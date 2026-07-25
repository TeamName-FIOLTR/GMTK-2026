extends Node2D
class_name Roc

@export var health : int = 1

func _ready() -> void:
	var rand = randf_range(0,2*PI)
	$Sprite2D.rotate(rand)
	$Sprite2D2.rotate(rand)
	
	$Sprite2D2.modulate = Glboals.roc_colur
