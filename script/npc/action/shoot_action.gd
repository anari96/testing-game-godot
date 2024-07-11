extends Action

@onready var actor = get_parent().get_parent()

func get_cost(blackboard):
	return 2

func validity():
	if actor.get_node("Detection")._target != null:
		return true
	else:
		return false

func required_state():
	return {
		"is_in_shooting_range" = true,
		"can_shoot" = true
	}

func desired_state():
	return {
		"win" = true
	}

func execute(_delta):
	print(name)
