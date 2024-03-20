extends Node3D

var parent : Enemy

#func _physics_process(delta):
	#if not parent.is_on_floor():
		#parent.velocity.y -= 9.8 * delta
		#parent.move_and_slide()

func push_from_direction(source,force):
	var direction = global_transform.origin - source
	parent.velocity = direction * force

func push_to_direction(source,force):
	var direction = global_transform.origin - source
	parent.velocity = (direction * -1) * force
