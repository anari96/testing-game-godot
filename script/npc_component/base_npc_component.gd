extends Node3D

class_name NpcComponentManager

func init(parent: Enemy) -> void:
	for child in get_children():
		child.parent = parent
