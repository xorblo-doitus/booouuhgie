extends CharacterBody2D


var test_push_collision := KinematicCollision2D.new()

#@onready var blow: Area2D = $PointLight2D/Blow
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var light_collider: Area2D = $PointLight2D/LightCollider
@onready var flame: ColorRect = $PointLight2D/Flame
@onready var light_collision_shape: CollisionShape2D = $PointLight2D/LightCollider/LightCollisionShape



func _process(delta: float) -> void:
	if is_on_floor():
		velocity.x = move_toward(velocity.x, 0, delta * 9000)
	else:
		velocity += get_gravity() * delta
	
	
	move_and_slide()


func reset() -> void:
	flame.show()
	point_light_2d.show()
	point_light_2d.texture_scale = 10
	light_collision_shape.set_deferred(&"disabled", false)
	#light_collider.set_deferred(&"monitoring", true)
	#light_collider.set_deferred(&"monitorable", true)


func blow() -> void:
	flame.hide()
	create_tween().tween_property(
		point_light_2d,
		^"texture_scale",
		0.01,
		0.1
	).finished.connect(point_light_2d.hide)
	light_collision_shape.set_deferred(&"disabled", true)
	#light_collider.set_deferred(&"monitoring", false)
	#light_collider.set_deferred(&"monitorable", false)
