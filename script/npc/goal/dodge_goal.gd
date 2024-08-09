extends Goal

@onready var actor = get_parent().get_parent()
@export var detection: Node

func validity():
	if actor.state["can_dodge"] == true:
		if detection._target != null:
			if actor.state["is_aimed"] == true:
				return true
	else:
		return false

func priority():
	return 15

func desired_state():
	return {
		"is_aimed" = false
	}
