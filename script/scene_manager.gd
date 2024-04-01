extends Node3D

var current_scene

var scene_path = "res://scene/map/"

func set_scene(scene_name:String) -> void:
	get_child(0).queue_free()
	var new_scene = load(scene_path + scene_name)
	current_scene = new_scene.instantiate()
	add_child(current_scene)

