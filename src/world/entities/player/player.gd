extends CharacterBody2D


const SPEED = 300.0
const CLIMB_VELOCITY = -200.0


func _physics_process(delta: float) -> void:
	var on_lader: bool = get_gravity().is_equal_approx(Vector2.ZERO)
	
	if on_lader:
		var vertical_direction: float = Input.get_axis("down", "up")
		if vertical_direction:
			velocity.y = CLIMB_VELOCITY * vertical_direction
		else:
			velocity.y *= 0.5
		
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
