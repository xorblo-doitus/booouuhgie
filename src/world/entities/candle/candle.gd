extends CharacterBody2D


var test_push_collision := KinematicCollision2D.new()


func push(x: float, delta: float) -> void:
	var ini := velocity
	velocity.x = x
	velocity.y = 0
	
	if test_move(transform, Vector2(velocity.x * delta + 2, 0), test_push_collision, -0.5):
		if test_push_collision.get_collider().has_method(&"push"):
			test_push_collision.get_collider().push(velocity.x, delta)
	
	move_and_slide()
	velocity = ini


func _process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
		move_and_slide()
