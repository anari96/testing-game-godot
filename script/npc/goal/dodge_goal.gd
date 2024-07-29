extends Goal

@onready var actor = get_parent().get_parent()

func validity():
	if actor.state["is_aimed_at"] == true:
		return true
	else:
		return false

func priority():
	return 8

func desired_state():
	return {
		"is_aimed" = false
	}
