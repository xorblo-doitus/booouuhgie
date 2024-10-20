class_name Level
extends Node2D


var initial_positions = {}


func _ready() -> void:
	for node: Node2D in get_tree().get_nodes_in_group(&"reset_pos"):
		initial_positions[node] = node.position
	
	for player: Player in get_tree().get_nodes_in_group(&"player"):
		player.killed.connect(reset)



func reset() -> void:
	for node in initial_positions:
		node.position = initial_positions[node]
