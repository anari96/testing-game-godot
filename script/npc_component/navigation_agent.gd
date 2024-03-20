extends NavigationAgent3D

var parent : Enemy

func _ready() -> void:
	velocity_computed.connect(_on_velocity_computed)

func set_movement_target(movement_target: Vector3):
	set_target_position(movement_target)
	
func _physics_process(delta):
	if is_navigation_finished():
		return
	var next_path_position: Vector3 = get_next_path_position()

	var direction = next_path_position - parent.global_position
	direction = direction.normalized()

	if parent.is_on_floor():
		if avoidance_enabled:
			set_velocity(direction)
		else:
			_on_velocity_computed(direction)

func _on_velocity_computed(safe_velocity: Vector3):
	if parent.is_on_floor():
		parent.velocity = parent.velocity.lerp(safe_velocity * parent.SPEED, 5.0)
