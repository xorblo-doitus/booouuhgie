extends CharacterBody2D


const SPEED = 100.0


var _falling: bool = false


@onready var light_detector: Area2D = $LightDetector


func push(x: float) -> void:
	if not _falling:
		return
	
	var ini := velocity
	velocity.x = x
	velocity.y = 0
	move_and_slide()
	velocity = ini


func _physics_process(delta: float) -> void:
	_falling = not light_detector.get_overlapping_areas().is_empty()
	
	if _falling:
		fall(delta)
	else:
		track_player(delta)


func fall(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
		move_and_slide()


func track_player(delta: float) -> void:
	var player: CharacterBody2D = get_tree().get_first_node_in_group(&"player")
	if player == null:
		return
	
	velocity = (player.global_position - global_position).normalized() * SPEED

	move_and_slide()
