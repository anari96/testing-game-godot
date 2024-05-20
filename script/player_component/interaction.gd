extends Node3D

var parent : Player

@export var interaction_raycast : RayCast3D
@export var label : Label
@export var dialogue_box : Control

func _physics_process(delta):
	if interaction_raycast.is_colliding():
		var interaction_item = interaction_raycast.get_collider()
		if interaction_item.has_method("use") || interaction_item.has_method("talk"):
			label.show()
	else:
		label.hide()

func _input(event):
	if Input.is_action_just_pressed("interact"):
		if interaction_raycast.is_colliding():
			label.show()
			var interaction_item = interaction_raycast.get_collider()
			if interaction_item.has_method("use"):
				interaction_item.use()
			if interaction_item.has_method("talk"):
				interaction_item.talk()
				dialogue_box.open()
