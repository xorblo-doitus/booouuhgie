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
	if _blow_tween:
		_blow_tween.kill()
		_blow_tween = null


var _blow_tween: Tween
func blow() -> void:
	if _blow_tween:
		return
	flame.hide()
	_blow_tween = create_tween()
	_blow_tween.tween_property(
		point_light_2d,
		^"texture_scale",
		0.01,
		0.1
	)
	_blow_tween.finished.connect(point_light_2d.hide)
	light_collision_shape.set_deferred(&"disabled", true)
