extends GPUParticles2D
class_name Rocticles

@export var particle_textures : Array[Texture]

static func get_rocticles() -> Rocticles:
	var rocts = Rocticles.new()
	return rocts

func _ready() -> void:
	var choice = randi_range(0,particle_textures.size()-1)
	texture = particle_textures[choice]
	modulate = Glboals.roc_colur


func _on_finished() -> void:
	queue_free()
	pass # Replace with function body.
