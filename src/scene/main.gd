extends Control


@export var level_selector : SpinBox

func _ready() -> void:
	level_selector.max_value = Glboals.unlocked_levels - 2
	level_selector.value = level_selector.max_value
	#MusicTheMusic.volume_db = -99
	MusicTheMusic.stop()

func _on_button_pressed() -> void:
	Glboals.load_level(Glboals.unlocked_levels)
	MusicTheMusic.target_volume = -12
	MusicTheMusic.play()
	get_tree().change_scene_to_file("res://scenes/world.tscn")
	

func _on_button_2_pressed() -> void:
	Glboals.load_level(int(level_selector.value) + 2)
	MusicTheMusic.target_volume = -12
	MusicTheMusic.play()
	get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_btn_quit_button_up() -> void:
	get_tree().quit()
