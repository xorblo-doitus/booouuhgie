@tool
extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var height: int = 5:
	set(new):
		height = new
		$CollisionShape2D.shape.size.y = 20 * height


#func _ready() -> void:
	#set_process(Engine.is_editor_hint())
#
#
#func _process(delta: float) -> void:
	#self.
