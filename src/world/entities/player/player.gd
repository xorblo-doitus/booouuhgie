class_name Player
extends CharacterBody2D


signal killed


const SPEED = 400.0
const DAMPING = 9000.0
const CLIMB_VELOCITY = -600.0


var test_push_collision := KinematicCollision2D.new()

@onready var sprite_2d: Sprite2D = $Sprite2D


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed(&"respawn"):
		killed.emit()
		return
	
	
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
		sprite_2d.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, DAMPING * delta)
	
	if test_move(transform, Vector2(velocity.x * delta + 1, 0), test_push_collision):
		if test_push_collision.get_collider().is_in_group(&"pushable"):
			velocity.x = clamp(velocity.x, SPEED/-2.0, SPEED/2.0)
			var to_push: Array[PhysicsBody2D] = [test_push_collision.get_collider()]
			
			while to_push[-1].test_move(to_push[-1].transform, Vector2(velocity.x * delta + 1, 0), test_push_collision):
				if not test_push_collision.get_collider().is_in_group(&"pushable") or to_push.size() > 10:
					to_push.clear()
					break
				to_push.append(test_push_collision.get_collider())
			
			for pushed in to_push:
				pushed.position.x += velocity.x * delta
	
	move_and_slide()


func kill() -> void:
	killed.emit()
