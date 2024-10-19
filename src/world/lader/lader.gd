@tool
extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D


@export var height: int = 5:
	set(new):
		height = new
		update_height()


func update_height() -> void:
	if collision_shape_2d == null:
		update_height.call_deferred()
		return
	
	collision_shape_2d.shape.size.y = 60 * height
	sprite_2d.region_rect.end.y = 60 * height
	
	var y_offset: float = 0 if height%2 else 30
	collision_shape_2d.position.y = y_offset
	sprite_2d.position.y = y_offset
