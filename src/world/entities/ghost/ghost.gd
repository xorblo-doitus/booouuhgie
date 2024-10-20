extends CharacterBody2D


const SPEED = 300.0


var test_push_collision := KinematicCollision2D.new()

var _falling: bool = false



@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var light_detector: Area2D = $LightDetector
@onready var sight: Area2D = $Sight


func push(x: float, delta: float) -> void:
	if not _falling:
		return
	
	var ini := velocity
	velocity.x = x
	velocity.y = 0
	
	if test_move(transform, Vector2(velocity.x * delta + 2, 0), test_push_collision, -0.5):
		if test_push_collision.get_collider().has_method(&"push"):
			test_push_collision.get_collider().push(velocity.x, delta)
	
	move_and_slide()
	velocity = ini


func _physics_process(delta: float) -> void:
	_falling = not light_detector.get_overlapping_areas().is_empty()
	
	if _falling:
		fall(delta)
	else:
		track_player(delta)


func fall(delta: float) -> void:
	if is_on_floor():
		velocity.x = move_toward(velocity.x, 0, delta * 9000)
	else:
		velocity += get_gravity() * delta
	
	move_and_slide()


@warning_ignore("unused_parameter")
func track_player(delta: float) -> void:
	if sight.has_overlapping_bodies():
		var player: Player = sight.get_overlapping_bodies()[0]
		velocity = (player.global_position - global_position).normalized() * SPEED
	else:
		velocity = Vector2.ZERO
	
	sprite_2d.flip_h = velocity.x < 0

	move_and_slide()
