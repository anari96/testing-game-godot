class_name Weapon
extends Node3D

var equipped
var can_attack : bool = true

func use1() -> void:
	print("use1")

func use2() -> void:
	print("use2")

func equip() -> void:
	var equipped = true
	show()
	
func remove() -> void:
	var equipped = false
	hide()
