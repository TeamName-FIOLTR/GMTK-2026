extends AudioStreamPlayer2D
class_name SoundEffecticle

static func get_sound_effect_node(for_stream : AudioStream) -> SoundEffecticle:
	var thing : SoundEffecticle = SoundEffecticle.new()
	thing.stream = for_stream
	return thing
	


func _on_finished() -> void:
	queue_free()
	pass # Replace with function body.
