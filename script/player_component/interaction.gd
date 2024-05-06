extends Node3D

var parent : Player

@export var interaction_raycast : RayCast3D

func _physics_process(delta):
	if Input.is_action_just_pressed("interact"):
		if interaction_raycast.is_colliding():
			var interaction_item = interaction_raycast.get_collider()
			if interaction_item.has_method("use"):
				interaction_item.use()
				if interaction_item.use() == "locked":
					parent.text.show()
					#parent.text.animation_player.play("text_appears")
