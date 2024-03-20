extends Node3D

class_name ComponentManager

func init(parent: Player) -> void:
	for child in get_children():
		child.parent = parent
