extends CharacterBody2D


var test_push_collision := KinematicCollision2D.new()



func _process(delta: float) -> void:
	if is_on_floor():
		velocity.x = move_toward(velocity.x, 0, delta * 9000)
	else:
		velocity += get_gravity() * delta
	
	
	move_and_slide()
