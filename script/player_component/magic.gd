extends Node3D

@export var player:CharacterBody3D

var equipped = 1

func _input(event):
	if !player.is_pausing:
		if Input.is_action_just_pressed("cast"):
			if get_child(0) != null:
				print(get_child(0))
				get_child(0).use()
