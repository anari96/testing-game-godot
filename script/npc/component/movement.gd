extends Node

@export var navigation_agent:NavigationAgent3D
@export var detection:Node
@onready var actor = get_parent()
@export var animation: Node
@export var timer: Timer

var movement_process = true

func _ready():
	animation.animation_player.animation_finished.connect(_on_dodge_animation_finished)
	timer.timeout.connect(_on_dodge_timer_timeout)

func _physics_process(delta):
	if movement_process:
		get_parent().move_and_slide()
	gravity(delta)

func gravity(delta):
	get_parent().velocity.y -= 10.0 * delta

func turn_on_movement_process():
	movement_process = true

func turn_off_movement_process():
	movement_process = false

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

func dodge():
	get_parent().velocity = Vector3(0,get_parent().velocity.y,0)
	var dodge_direction = randi_range(-1,1)
	if dodge_direction == 0:
		dodge_direction = randi_range(-1,1)
	if dodge_direction == 1:
		animation.animation_player.play("dodge_right_faster")
	elif dodge_direction == -1:
		animation.animation_player.play("dodge_left_faster")
	var direction = Vector3(dodge_direction * 4,0,0)

	direction = direction.rotated(Vector3.UP,detection.target_raycast.global_rotation.y)
	get_parent().velocity.y = direction.y
	get_parent().velocity.z = direction.z
	get_parent().velocity.x = direction.x

func navigate_to_position():
	animation.animation_player.play("run")
	var next_location = navigation_agent.get_next_path_position()
	var current_location = actor.global_position
	var new_velocity = current_location.direction_to(next_location) * (actor.SPEED * actor.SPEED_MODIFIER)
	actor.velocity = new_velocity

func _on_dodge_animation_finished(anim_name):
	if anim_name == "dodge_left_faster" || anim_name == "dodge_right_faster":
		print("dodge_animation_done")
		get_parent().state["can_dodge"] = false
		timer.start()

func _on_dodge_timer_timeout():
	get_parent().state["can_dodge"] = true
