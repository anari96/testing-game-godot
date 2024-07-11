extends Node

@export var navigation_agent:NavigationAgent3D
@export var detection:Node
@onready var actor = get_parent()

func _physics_process(delta):
	gravity(delta)

func gravity(delta):
	get_parent().velocity.y -= 10.0 * delta

func set_movement_destination(_destination: CharacterBody3D) -> void:
	detection._target = _destination

func go_to_destination() -> void:
	navigation_agent.target_position = detection._target.global_position
	var next_location = navigation_agent.get_next_path_position()
	var current_location = actor.global_position
	var new_velocity = current_location.direction_to(next_location) * (actor.SPEED * actor.SPEED_MODIFIER)
	actor.velocity = new_velocity
