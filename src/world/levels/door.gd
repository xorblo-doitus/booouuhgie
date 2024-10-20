class_name Door
extends Node2D


signal travel_to(target: PackedScene)


@export var target: PackedScene


@onready var area_2d: Area2D = $Area2D


func _ready() -> void:
	if target == null:
		push_warning("No target for door %s in %s" % [owner.get_path_to(self), owner.scene_file_path])
	
	area_2d.body_entered.connect(_on_player_touched)


func _on_player_touched(_body) -> void:
	if target == null:
		return
	
	travel_to.emit(target)
