extends Area3D

@export var scene_name : String
@export var spawn_point_id : int

func use():
	SceneManager.set_scene(scene_name,spawn_point_id)
