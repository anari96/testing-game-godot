extends Node3D

var parent : Player
@onready var waist_raycast = $WaistRaycast
@onready var front_raycast = $FrontRaycast

func _physics_process(delta):
	mantle()

func mantle():
	if waist_raycast.is_colliding() and front_raycast.is_colliding() and Input.is_action_pressed("move_forward"):
		parent.velocity.y = 0
		var tween = create_tween()
		tween.tween_property(parent,"global_position", parent.global_position + Vector3(0,0.9, -0.6).rotated(Vector3.UP,global_rotation.y), 0.3)
