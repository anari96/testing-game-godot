extends Goal

@onready var actor = get_parent().get_parent()
@export var detection : Node

func validity():
	if detection._target != null:
		return true
	else:
		return false

func priority():
	return 10

func desired_state():
	return {
		"is_near_target" = true
	}
