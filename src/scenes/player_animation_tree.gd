extends AnimatedSprite2D


func _ready() -> void:
	self.animation_finished.connect(self.on_anim_finished)

func on_anim_finished(anim)->void:
	if anim != 'fall':
		self.play('fall')
