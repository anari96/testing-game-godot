extends Node3D

var parent : Player

var disable_input = false

var can_fall = true
var can_move = true
var jump_count = 1
var temp_jump_count = jump_count
var input_dir = Vector3()

var is_moving
var is_grounded = false

@export var wall_detector:Node3D
@export var crouch_component:Node3D
@export var screen_shake_component:Node3D
@export var camera_animation_player:AnimationPlayer
@export var camera_movement_component:Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.timeout.connect(_on_timer_timeout)

func _input(event):
	if disable_input == false:
		input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	elif disable_input == true:
		input_dir = Vector3()
	if Input.is_action_pressed("move_forward") || Input.is_action_pressed("move_backward") || Input.is_action_pressed("move_left") || Input.is_action_pressed("move_right"):
		is_moving = true

	else:
		is_moving = false

func _physics_process(delta):
	# Add the gravity.
	if not parent.is_on_floor() && can_fall:
		parent.velocity.y -= parent.gravity * delta
	
	if parent.is_on_floor():
		if !is_grounded:
			camera_movement_component.fall()
			#screen_shake_component.add_trauma(1.0)
		is_grounded = true
		parent.current_speed = parent.SPEED
		parent.current_acceleration = parent.ACCELERATION
		temp_jump_count = jump_count
	
	if !parent.is_on_floor():
		is_grounded = false
	
	if parent.is_on_floor() == false:
		parent.current_acceleration = parent.AIR_ACCELERATION
	# Handle jump.
	if Input.is_action_just_pressed("move_jump"):
		if parent.is_on_floor():
			camera_movement_component.jump()
			#screen_shake_component.add_trauma(1.0)
			parent.velocity.y = parent.JUMP_VELOCITY
		elif parent.is_on_floor() == false && temp_jump_count > 0 && wall_detector.near_wall :
			disable()
			$Timer.start()
			temp_jump_count -= 1
	
	if Input.is_action_pressed("move_sprint"):
		parent.current_speed = parent.SPRINT_SPEED
		parent.current_acceleration = 15.0
		
	
	var direction = (parent.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if can_move:
		if direction:
			move(parent.current_speed,parent.current_acceleration,direction.x,direction.z,delta)
		elif not direction && parent.is_on_floor():
			move(0.0,parent.DEACCELERATION,direction.x,direction.z,delta)
		elif not direction && not parent.is_on_floor():
			move(0.0,parent.current_acceleration,direction.x,direction.z,delta)
	

func move(current_speed,current_acceleration,direction_x,direction_z,delta):
	parent.velocity.x = lerp(parent.velocity.x,direction_x * current_speed, current_acceleration * delta)
	parent.velocity.z = lerp(parent.velocity.z,direction_z * current_speed, current_acceleration * delta)
	#parent.move_and_slide()

func disable():
	parent.velocity = Vector3(0,0,0)
	can_move = false
	can_fall = false
	print("disable")

func enable():
	can_move = true
	can_fall = true
	print("enable")

func _on_timer_timeout():
	#input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (parent.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	parent.velocity.y = parent.JUMP_VELOCITY * 2.0
	
	parent.velocity.x = lerp(parent.velocity.x,direction.x * 3.0, 1.3)
	parent.velocity.z = lerp(parent.velocity.z,direction.z * 3.0, 1.0)
	enable()
