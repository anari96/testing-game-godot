extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	SpawnManager.select_spawn_point(SceneManager.current_spawn_point_id)
	#FactManager.apply_fact()
