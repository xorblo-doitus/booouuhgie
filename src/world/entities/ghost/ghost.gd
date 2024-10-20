extends CharacterBody2D


const SPEED = 300.0


var test_push_collision := KinematicCollision2D.new()

var _falling: bool = false



@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var light_detector: Area2D = $LightDetector
@onready var sight: Area2D = $Sight



func _physics_process(delta: float) -> void:
	_falling = not light_detector.get_overlapping_areas().is_empty()
	
	if _falling:
		fall(delta)
		add_to_group(&"pushable")
	else:
		track_player(delta)
		remove_from_group(&"pushable")


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
	
	for i in get_slide_collision_count():
		var collider := get_slide_collision(i).get_collider()
		if collider is Player:
			collider.kill()
