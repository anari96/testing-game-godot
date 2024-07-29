extends Goal

@onready var actor = get_parent().get_parent()
@export var detection: Node

func validity():
	if detection._target != null:
		return true
	else:
		return false

func priority():
	if detection.distance_to_target() <= 10.0:
		return 10
	else:
		return 5

func desired_state():
	return {
		"win" = true,
	}
