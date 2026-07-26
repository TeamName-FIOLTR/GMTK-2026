extends Control



func _on_quit_button_up() -> void:
	get_tree().quit()

func _on_main_menu_button_up() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scene/main.tscn")

func unpause():
	print('unpausing')
	self.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false

func _on_resume_button_up() -> void:
	unpause()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		event.is_echo()
		get_viewport().set_input_as_handled()
		unpause()
