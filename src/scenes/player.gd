extends CharacterBody2D


func get_collider() -> Object:
	var c1 : Object = $RayCast2D.get_collider()
	var c2 : Object = $RayCast2D2.get_collider()
	var c3 : Object = $RayCast2D3.get_collider()
	
	var p1 : Vector2 = $RayCast2D.get_collision_point() if $RayCast2D.is_colliding() else Vector2(0,INF)
	var p2 : Vector2 = $RayCast2D2.get_collision_point() if $RayCast2D2.is_colliding() else Vector2(0,INF)
	var p3 : Vector2 = $RayCast2D3.get_collision_point() if $RayCast2D3.is_colliding() else Vector2(0,INF)
	
	if p1.y <= p2.y and p1.y <= p3.y:
		return c1
	if p2.y <= p1.y and p2.y <= p3.y:
		return c2
	if p3.y <= p2.y and p3.y <= p1.y:
		return c3
	
	return c1


func get_collision_point() -> Vector2:
	var p1 : Vector2 = $RayCast2D.get_collision_point() if $RayCast2D.is_colliding() else Vector2(0,INF)
	var p2 : Vector2 = $RayCast2D2.get_collision_point() if $RayCast2D2.is_colliding() else Vector2(0,INF)
	var p3 : Vector2 = $RayCast2D3.get_collision_point() if $RayCast2D3.is_colliding() else Vector2(0,INF)
	
	if p1.y <= p2.y and p1.y <= p3.y:
		return p1
	if p2.y <= p1.y and p2.y <= p3.y:
		return p2
	if p3.y <= p2.y and p3.y <= p1.y:
		return p3
	
	return p1
	

func is_colliding() -> bool:
	return $RayCast2D.is_colliding() or $RayCast2D2.is_colliding() or $RayCast2D3.is_colliding()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT or event.button_index == MOUSE_BUTTON_RIGHT:
			$AudioStreamPlayer2D.play()
