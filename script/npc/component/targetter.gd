extends Node

var _target
@export var target_raycast : RayCast3D

func _process(delta):
	if _target != null:
		target_raycast.look_at(target_raycast.global_position)
