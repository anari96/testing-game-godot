extends Area3D

@export var scene_name : String
@export var spawn_point_id : int = 1
@export var locked : bool = false
@export var required_key : String

func use():
	if locked:
		if InventoryManager.find_item_index(required_key) != -1:
			SceneManager.set_scene(scene_name,spawn_point_id)
		return "locked"
	elif !locked:
		SceneManager.set_scene(scene_name,spawn_point_id)
