extends Node3D

var parent : Player
@export var move:Node3D
@export var camera:Camera3D

func _physics_process(delta):
	view_roll(move.input_dir.x,delta)

func view_roll(input_x,delta):
	if camera :
		camera.rotation.z = lerp(camera.rotation.z, -input_x * 0.03, 2.0 * delta)
