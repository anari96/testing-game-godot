extends Node

@export var DetectionTimer : Timer
@export var DetectionArea : Area3D
@export var melee_range_area : Area3D
@export var target_raycast : RayCast3D
@export var movement_raycast : RayCast3D
@export var movement: Node

var is_tracking_target = false

var _node
var _last_node
var _target
var _last_target

# Called when the node enters the scene tree for the first time.
func _ready():
	DetectionArea.body_entered.connect(_on_detection_area_body_entered)
	DetectionArea.body_exited.connect(_on_detection_area_body_exited)
	DetectionTimer.timeout.connect(_on_detection_timer_timeout)
	melee_range_area.body_entered.connect(_on_melee_range_area_body_entered)
	melee_range_area.body_exited.connect(_on_melee_range_area_body_exited)

func _process(delta):
	if _target != null:
		target_raycast.look_at(_target.global_position)
	if movement.navigation_agent.get_next_path_position() != null:
		movement_raycast.look_at(movement.navigation_agent.get_next_path_position())
	if get_parent().state["is_aimed"] == true:
		#print("someone aimed at me")
		get_parent().state["is_aimed"] = false

func _on_detection_area_body_entered(body):
	if body.is_in_group("player"):
		_target = body
		
func _on_detection_area_body_exited(body):
	if body.is_in_group("player"):
		DetectionTimer.start()
		

func _on_detection_timer_timeout():
	_last_target = _target
	_target = null

func distance_from_player(_object):
	if _object != null:
		return get_parent().position.distance_to(_object.position)
	else:
		return 0

func distance_to_target():
	if _target != null:
		return get_parent().global_position.distance_to(_target.global_position)
	else:
		return 0

func distance_to_node():
	if _node != null:
		return get_parent().global_position.distance_to(_node.global_position)
	else:
		return 0

func look_at_target():
	get_parent().rotate_y(deg_to_rad(target_raycast.rotation.y * 10.0))

func look_at_movement():
	get_parent().rotate_y(deg_to_rad(movement_raycast.rotation.y * 10.0))

func get_nearest_node():
	var npc_node = get_tree().get_nodes_in_group("npc_node")
	var nearest_node
	for n in npc_node:
		if nearest_node == null || get_parent().position.distance_to(n.position) < get_parent().position.distance_to(nearest_node.position):
			nearest_node = n
	return nearest_node

func _on_melee_range_area_body_entered(body):
	get_parent().state["is_near_target"] = true

func _on_melee_range_area_body_exited(body):
	get_parent().state["is_near_target"] = false
