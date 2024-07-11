extends Node

@export var DetectionTimer : Timer
@export var DetectionArea : Area3D
@export var target_raycast : RayCast3D
@export var movement: Node

var _target
var _last_target

# Called when the node enters the scene tree for the first time.
func _ready():
	DetectionArea.body_entered.connect(_on_detection_area_body_entered)
	DetectionArea.body_exited.connect(_on_detection_area_body_exited)
	DetectionTimer.timeout.connect(_on_detection_timer_timeout)

func _process(delta):
	if _target != null:
		target_raycast.look_at(_target.position)

func _on_detection_area_body_entered(body):
	if body.is_in_group("player"):
		_target = body
		print(_target)
		
func _on_detection_area_body_exited(body):
	if body.is_in_group("player"):
		DetectionTimer.start()
		_last_target = body

func _on_detection_timer_timeout():
	_target = null


func look_at_target():
	target_raycast.look_at(movement.navigation_agent.get_next_path_position())
	target_raycast.rotate_y(deg_to_rad(target_raycast.rotation.y * 10.0))
