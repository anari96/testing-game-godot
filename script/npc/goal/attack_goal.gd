extends Goal

@onready var actor = get_parent().get_parent()

func validity():
	if actor.get_node("Detection")._target != null:
		return true
	else:
		return false

func priority():
	return 2

func desired_state():
	return {
		"is_in_shooting_range" = true
	}
