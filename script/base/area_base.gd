extends Area3D

class_name AreaBase

func enable():
	$CollisionShape3D.disabled = false
	
func disable():
	$CollisionShape3D.disabled = true
