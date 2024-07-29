extends Action

@onready var actor = get_parent().get_parent()
@export var projectile:Node
var max_projectile = 1

func get_cost(blackboard):
	return 1

func required_state():
	return {
		"can_shoot" = true
	}

func desired_state():
	return {
		"win" = true
	}

func execute(_delta):
	projectile.shoot()
	return true
