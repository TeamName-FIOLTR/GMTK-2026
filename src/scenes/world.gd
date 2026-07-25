extends Node2D


@export var player: CharacterBody2D

var mouse_x : float = 0
var player_y : float = 0

var rng : RandomNumberGenerator

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	rng = RandomNumberGenerator.new()
	rng.seed = 3
	
	mouse_x = get_viewport_rect().size.x/2.0

func spawn_roc():
	var roc : Roc = preload("res://scenes/roc.tscn").instantiate()
	$rocs.add_child(roc)
	roc.position.x = rng.randf_range(0.1,0.9)*get_viewport_rect().size.x
	roc.position.y = -$rocs.position.y+rng.randf_range(1.00,2.0)*get_viewport_rect().size.y
	pass

func test_click() -> bool:
	# me when raycaset node
	if not $Player/RayCast2D.is_colliding(): return false
	var roc : Roc = $Player/RayCast2D.get_collider().get_parent()
	var hit : Vector2 = $Player/RayCast2D.get_collision_point()
	player_y = hit.y
	v = -300
	roc.queue_free()
	
	return true
	#var global_pos = player.global_position
	#var tolarence : float = 50
	#var hi_david : float = 100
	#for roc : Roc in $rocs.get_children():
		#var roc_pos = roc.global_position
		#if abs(roc_pos.x-global_pos.x) > tolarence: continue
		#if roc_pos.y - global_pos.y > 0 and roc_pos.y - global_pos.y <= hi_david:
			#
	#return false
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_x += event.relative.x
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			print(test_click())
	if event.is_action_pressed("ui_cancel"):
		get_tree().reload_current_scene()

var next_t : float = 0
var t = 0.0

var v = 0

func _physics_process(delta: float) -> void:
	
	player.position.x = mouse_x
	player.position.y += v*delta
	v += 1000.0*delta
	t += delta
	$rocs.position.y += -delta*1000.0
	if t > next_t:
		spawn_roc()
		t = 0
		next_t = rng.randf_range(0,1)
	pass
