extends Action

@onready var actor = get_parent().get_parent()
@export var movement:Node

func validity():
	if actor.get_node("Detection")._target != null:
		return true
	else:
		return false

func get_cost(blackboard):
	return 1

func required_state():
	return {
		"is_in_shooting_range" = false
	}

func desired_state():
	return {
		"is_in_shooting_range" = true
	}

func execute(delta):
	movement.go_to_destination()
