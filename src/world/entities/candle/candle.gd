extends CharacterBody2D


func push(x: float) -> void:
	var ini := velocity
	velocity.x = x
	velocity.y = 0
	move_and_slide()
	velocity = ini


func _process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
		move_and_slide()
