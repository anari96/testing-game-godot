extends Node

@export var navigation_agent:NavigationAgent3D
@export var detection:Node
@onready var actor = get_parent()
@export var animation: Node

func _physics_process(delta):
	gravity(delta)

func gravity(delta):
	get_parent().velocity.y -= 10.0 * delta

#func go_to(_node) -> void:
	#navigation_agent.target_position = detection._node.global_position
	#var next_location = navigation_agent.get_next_path_position()
	#var current_location = actor.global_position
	#var new_velocity = current_location.direction_to(next_location) * (actor.SPEED * actor.SPEED_MODIFIER)
	#actor.velocity = new_velocity

func go_to_target() -> void:
	navigation_agent.target_position = detection._target.global_position
	navigate_to_position()

func go_to_node() -> void:
	navigation_agent.target_position = detection._node.global_position
	navigate_to_position()

func navigate_to_position():
	animation.animation_player.play("walk")
	var next_location = navigation_agent.get_next_path_position()
	var current_location = actor.global_position
	var new_velocity = current_location.direction_to(next_location) * (actor.SPEED * actor.SPEED_MODIFIER)
	actor.velocity = new_velocity
