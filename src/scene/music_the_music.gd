extends AudioStreamPlayer

@export var target_volume : float = -99
@export var volume_speed : float = 1

func _process(delta: float) -> void:
	volume_db = lerp(volume_db,target_volume,delta*volume_speed)
	pass
