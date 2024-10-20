extends Node2D


const LEVEL_1 = preload("res://src/world/levels/level_1.tscn")


func _ready():
	change_level(LEVEL_1)



func change_level(new: PackedScene) -> void:
	if has_node(^"CurrentLevel"):
		$CurrentLevel.queue_free()
	
	var new_level: Level = new.instantiate()
	new_level.name = "CurrentLevel"
	add_child(new_level)
