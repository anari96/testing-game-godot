extends Node
class_name Action

func validity():
	return true

func get_cost(blackboard):
	return 1

func required_state():
	return {}

func desired_state():
	return {}

func execute(_delta):
	print("action executed")
