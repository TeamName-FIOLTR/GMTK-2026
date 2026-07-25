extends AnimatedSprite2D


func _ready() -> void:
	self.animation_finished.connect(self.on_anim_finished)
	self.play("fall")

func on_anim_finished()->void:
	if self.animation != 'fall':
		self.play('fall')
