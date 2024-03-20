extends CharacterBody3D

@export var movement_speed: float = 4.0
@export var target:CharacterBody3D
@onready var navigation_agent = $NavigationAgent3D

func _ready() -> void:
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))
	set_movement_target(target.global_position)

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= 9.8 * delta
	var direction = Vector3()
	navigation_agent.target_position = target.global_position
	direction = navigation_agent.get_next_path_position() - global_position
	direction = direction.normalized()
	
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(direction)
	else:
		_on_velocity_computed(direction)
	
func _on_velocity_computed(safe_velocity: Vector3):
	velocity = velocity.lerp(safe_velocity * movement_speed, 1.0)
	move_and_slide()
	
