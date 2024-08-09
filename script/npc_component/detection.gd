extends Node

@export var DetectionTimer : Timer
@export var DetectionArea : Area3D
@export var melee_range_area : Area3D
@export var target_raycast : RayCast3D
@export var movement_raycast : RayCast3D
@export var movement: Node

@export var always_detect_target: bool = true
@export var detect_target_at_spawn : bool = true

var _node
var _last_node
var _target
var _last_target

# Called when the node enters the scene tree for the first time.
func _ready():

	DetectionArea.body_entered.connect(_on_detection_area_body_entered)
	DetectionArea.body_exited.connect(_on_detection_area_body_exited)
	#DetectionTimer.timeout.connect(_on_detection_timer_timeout)
	melee_range_area.body_entered.connect(_on_melee_range_area_body_entered)
	melee_range_area.body_exited.connect(_on_melee_range_area_body_exited)

func _process(delta):
	if detect_target_at_spawn:
		print(PlayerManager.current_player)
		_target = PlayerManager.current_player
	if get_parent().state["is_tracking_target"] == true:
		if _target != null:
			target_raycast.look_at(_target.global_position)
			get_parent().rotate_y(deg_to_rad(target_raycast.rotation.y * 10.0))
	
	
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
	if always_detect_target == false:
		_target = null

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

func turn_on_target_tracking():
	get_parent().state["is_tracking_target"] = true

func turn_off_target_tracking():
	get_parent().state["is_tracking_target"] = false
