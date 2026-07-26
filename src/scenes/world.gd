extends Node2D


@export var player: CharacterBody2D

var mouse_x : float = 0
var player_y : float = 0

var rng : RandomNumberGenerator
var gravity : float = 4500
var jump_v : float = 700
var depth_speed : float = 1000

var roc_count : int = 0

var rocticles_scene = preload("res://scenes/rocticles.tscn")

var shake_freq : float = 15
var shake_amp : float = 0.0
var shake_t : float = 0.0

var level_limits : float = -1

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	rng = RandomNumberGenerator.new()
	rng.seed = Glboals.level_seed
	
	mouse_x = get_viewport_rect().size.x/2.0
	spawn_all_thi_hits()
	Engine.physics_ticks_per_second = 120

func spawn_roc():
	var roc : Roc = preload("res://scenes/roc.tscn").instantiate()
	$rocs.add_child(roc)
	roc.position.x = rng.randf_range(0.1,0.9)*get_viewport_rect().size.x
	roc.position.y = -$rocs.position.y+rng.randf_range(1.00,2.0)*get_viewport_rect().size.y
	pass

func spawn_all_thi_hits():
	var end_y = 0
	for h in Glboals.hit_positions:
		var roc : Roc = preload("res://scenes/roc.tscn").instantiate()
		$rocs.add_child(roc)
		roc.position.x = rng.randf_range(0.1,0.9)*get_viewport_rect().size.x
		roc.position.y = -$rocs.position.y+get_viewport_rect().size.y*h#*60/323
		end_y = max(roc.position.y,end_y)
		pass
	pass
	roc_count = len(Glboals.hit_positions)
	$CanvasLayer/Control/Label.text = "%s rocs left" % roc_count
	level_limits = end_y+4*get_viewport_rect().size.y

@export var hit_sound : AudioStream

func test_click() -> bool:
	# me when raycaset node
	if not is_instance_valid(player.get_collider()): return false
	var roc : Roc = player.get_collider().get_parent()
	var hit : Vector2 = player.get_collision_point()
	if hit.y - player_y > 300: return false
	player_y = hit.y
	#var proportion : float = pow(player_y/get_viewport_rect().size.y,1/3.0)
	
	v = -jump_v #*proportion
	var sfx = SoundEffecticle.get_sound_effect_node(hit_sound)
	add_child(sfx)
	sfx.global_position = roc.global_position
	sfx.pitch_scale = pow(2.0,randf_range(-0.05,0.05)-1)
	sfx.play()

	roc_count = $rocs.get_child_count() - 1 #queue free takes a moment to take effect
	roc.queue_free()
	var rocticles : Rocticles = rocticles_scene.instantiate()
	add_child(rocticles)
	rocticles.emitting = true
	rocticles.global_position = roc.global_position

	print_debug(roc_count)
	shake_amp = 10
	$CanvasLayer/Control/Label.text = "%s rocs left" % roc_count
	
	#$CanvasLayer/Control/Label/Label.text = $CanvasLayer/Control/Label.text
	return true
	#var global_pos = player.global_position
	#var tolarence : float = 50
	#var hi_david : float = 100
	#var hi_max : float = 102
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
		mouse_x = clamp(mouse_x,0,get_viewport_rect().size.x)
	if event is InputEventMouseButton:
		if (event.button_index == MOUSE_BUTTON_LEFT or event.button_index == MOUSE_BUTTON_RIGHT) and event.is_pressed():
			print(test_click())
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()
	if passed and event.is_action_pressed("continue"):
		Glboals.generate_new_level()
		get_tree().reload_current_scene()
	

var next_t : float = 0
var t = 999990.0

var v = 0

var judged : bool = false
var passed : bool = false

func judge_my_vow_shynx_of_black_quartz():
	#generate_new_level()
	if $rocs.get_child_count() > 0:
		$CanvasLayer.add_child(Glboals.LEVEL_FAILED_SCREEN.instantiate())
	else:
		$CanvasLayer.add_child(Glboals.LEVEL_PASSED_SCREEN.instantiate())
		passed = true
	judged = true

func _physics_process(delta: float) -> void:
	
	player.position.x = mouse_x
	player_y += v*delta
	#print(player_y)
	player.position.y = player_y
	v += gravity*delta
	t += delta
	var camera_pos = $Camera2D.position.y
	$Camera2D.position.y = clamp(lerp(camera_pos,player_y,10*delta),-1000,level_limits)
	$Camera2D.offset.x = shake_amp*cos(2*PI*shake_freq*shake_t)
	shake_t += delta
	shake_amp = lerp(shake_amp,0.0,10.0*delta)
	$CanvasLayer/Control/Label2.text = "Altitude: %s" % int(-$Camera2D.position.y/100.0)
	#$rocs.position.y += -delta*depth_speed
	if t > next_t:
		#spawn_roc()
		t = 0
		next_t = rng.randf_range(0,1.0)
	pass
	
	#error term for aproximations resulting from lerping
	if $Camera2D.position.y >= level_limits - 0.01 and not judged:
		judge_my_vow_shynx_of_black_quartz()


#var hit_things_test : PackedFloat64Array = [0.0, 4.0, 8.0, 12.0, 14.0, 16.0, 20.0, 21.0, 22.0, 22.5, 23.0, 24.0, 28.000001907348633, 29.000001907348633, 30.000001907348633, 30.500001907348633, 32.0, 34.0, 36.0, 36.5, 38.0, 40.0, 41.0, 42.0, 43.0, 44.0, 44.5, 45.0, 45.5, 46.0, 47.0, 48.0, 48.5, 49.0, 50.0, 50.5, 51.0, 52.0, 52.5, 53.0, 53.5, 54.0, 54.5, 55.0, 55.5, 56.0, 57.0, 57.5, 58.0, 60.0, 60.5, 61.0, 62.0]
