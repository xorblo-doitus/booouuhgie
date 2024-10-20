class_name Level
extends Node2D


var initial_positions = {}


func _ready() -> void:
	for node: Node2D in get_tree().get_nodes_in_group(&"reset_pos"):
		initial_positions[node] = node.position
	
	for player: Player in get_tree().get_nodes_in_group(&"player"):
		player.killed.connect(reset)
		move_child(player, -1)



func reset() -> void:
	for node in initial_positions:
		if node is CharacterBody2D:
			node.set_physics_process(false)
			node.velocity = Vector2.ZERO
	
	await get_tree().physics_frame
	for node in initial_positions:
		node.position = initial_positions[node]
	get_tree().call_group(&"reset", &"reset")
	await get_tree().physics_frame
	
	for node in initial_positions:
		if node is CharacterBody2D:
			node.velocity = Vector2.ZERO
			node.set_physics_process.call_deferred(true)
