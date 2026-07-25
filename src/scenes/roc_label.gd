@tool
extends Label
class_name RocLable

@export var label: Label


func _ready() -> void:
	RenderingServer.connect("frame_pre_draw",sync_labels)
	label_settings.font_color = Glboals.roc_colur.lightened(0.5)
	label_settings.set_stacked_outline_color(1,Glboals.roc_colur.darkened(0.5))
	label.label_settings.font_color = Glboals.roc_colur.darkened(0.1)

func sync_labels():
	
	#if not is_instance_valid(label): return
	label.text = text
	label.horizontal_alignment = horizontal_alignment
	label.vertical_alignment = vertical_alignment
	label.autowrap_mode = autowrap_mode
	label.autowrap_trim_flags = autowrap_trim_flags
	label.justification_flags = justification_flags
	label.paragraph_separator = paragraph_separator
	label.clip_text = clip_text
	label.ellipsis_char = ellipsis_char
	label.uppercase = uppercase
	label.tab_stops = tab_stops
	label.lines_skipped = lines_skipped
	label.max_lines_visible = max_lines_visible
	label.visible_characters = visible_characters
	label.visible_characters_behavior = visible_characters_behavior
	label.visible_ratio = visible_ratio
