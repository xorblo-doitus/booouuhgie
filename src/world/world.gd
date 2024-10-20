class_name World
extends Node2D


const LEVEL_1 = preload("res://src/world/levels/level_1.tscn")

@onready var level_change: AudioStreamPlayer2D = $LevelChange

func _ready():
	change_level(LEVEL_1)


func change_level(scene: PackedScene, origin: Door = null) -> void:
	if origin:
		level_change.global_position = origin.global_position
		level_change.play()
	
	if has_node(^"CurrentLevel"):
		$CurrentLevel.queue_free()
		while has_node(^"CurrentLevel"):
			await get_tree().physics_frame
	
	var new_level: Level = scene.instantiate()
	new_level.name = "CurrentLevel"
	add_child(new_level)
	
	for door: Door in get_tree().get_nodes_in_group(&"door"):
		door.travel_to.connect(change_level.bind(door))
