class_name Door
extends Node2D


signal travel_to(target: PackedScene)


@export var target: PackedScene


@onready var area_2d: Area2D = $Area2D


func _ready() -> void:
	if target == null:
		push_warning("No target for door %s in %s" % [owner.get_path_to(self), owner.scene_file_path])
	
	area_2d.input_pickable = OS.is_debug_build()
	
	area_2d.body_entered.connect(_on_player_touched)


func trigger() -> void:
	if target == null:
		return
	
	travel_to.emit(target)


func _on_player_touched(_body) -> void:
	trigger()


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton && event.is_pressed() && event.button_index == MOUSE_BUTTON_LEFT:
		trigger()
