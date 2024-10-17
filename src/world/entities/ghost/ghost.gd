extends CharacterBody2D


const SPEED = 100.0


func _physics_process(delta: float) -> void:
	track_player(delta)


func track_player(delta: float) -> void:
	var player: CharacterBody2D = get_tree().get_first_node_in_group(&"player")
	if player == null:
		return
	
	velocity = (player.global_position - global_position).normalized() * SPEED

	move_and_slide()
