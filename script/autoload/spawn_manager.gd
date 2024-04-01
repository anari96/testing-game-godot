extends Node

@onready var player = preload("res://scene/player.tscn")
var spawn_point_id
var spawn_point : Node3D

func select_spawn_point(_id:int):
	spawn_point_id = _id
	var spawn_points = get_tree().get_nodes_in_group("player_spawn")
	print(get_tree().root.get_children())
	for i in spawn_points:
		if i.id == _id:
			spawn_point = i
			spawn_point.spawn()
	
#func spawn():
	#pass
