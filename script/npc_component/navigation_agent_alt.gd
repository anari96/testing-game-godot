extends NavigationAgent3D

var parent : Enemy

var next_location:Vector3
var current_location:Vector3
var new_velocity:Vector3

@export var position_update_timer :Timer

func _ready():
	position_update_timer.timeout.connect(_on_position_timer_timeout)

func _physics_process(delta):
	if parent.is_on_floor():
		if parent.target != null:
			next_location = get_next_path_position()
			current_location = parent.global_position
			new_velocity = current_location.direction_to(next_location) * parent.SPEED * parent.speed_scale
			parent.velocity = new_velocity

func set_movement_target(target):
	target_position = target
	#print(target)

func _on_position_timer_timeout():
	pass
