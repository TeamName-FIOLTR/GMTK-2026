@tool
extends Label


func _ready() -> void:
	RenderingServer.connect("frame_pre_draw",sync_labels)

func sync_labels():
	$Label.text = text
	$Label.horizontal_alignment = horizontal_alignment
	$Label.vertical_alignment = vertical_alignment
	$Label.autowrap_mode = autowrap_mode
	$Label.autowrap_trim_flags = autowrap_trim_flags
	$Label.justification_flags = justification_flags
	$Label.paragraph_separator = paragraph_separator
	$Label.clip_text = clip_text
	$Label.ellipsis_char = ellipsis_char
	$Label.uppercase = uppercase
	$Label.tab_stops = tab_stops
	$Label.lines_skipped = lines_skipped
	$Label.max_lines_visible = max_lines_visible
	$Label.visible_characters = visible_characters
	$Label.visible_characters_behavior = visible_characters_behavior
	$Label.visible_ratio = visible_ratio
