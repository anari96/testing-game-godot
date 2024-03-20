extends Area3D

#func _ready():
	#body_entered.connect(_on_body_entered)

func enable():
	$CollisionShape3D.disabled = false
	
func disable():
	$CollisionShape3D.disabled = true
