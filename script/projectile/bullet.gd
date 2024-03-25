extends Area3D

func _ready():
	body_entered.connect(_on_body_entered)
	set_as_top_level(true)
	
func _physics_process(delta):
	transform.origin -= transform.basis.z * 100.0 * delta
	
func _on_body_entered(body):
	if body.is_in_group("enemy"):
		
		#await body.create_timer(1.0).timeout
		body.damage(10)
		#body._set_state(body.State.FREEZE)
		#body.queue_free()
	queue_free()
	
