extends Node3D

class_name Magic

@onready var projectile = preload("res://scene/projectile/freeze.tscn")
@onready var point = $Point

func use():
	var projectile_instance = projectile.instantiate()
	point.add_child(projectile_instance)
