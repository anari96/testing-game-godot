extends CharacterBody3D
class_name Enemy
signal state_changed(state)
signal health_changed

enum State {FOLLOW, IDLE, ATTACK, STUN, PATROL, DEAD, FALLING, FREEZE}

var _state = State.IDLE

const SPEED = 5.0
const SPEED_SCALE = 1.0
const JUMP_VELOCITY = 4.5

var attack = false
var health = 40
var speed_scale = SPEED_SCALE
var alerted = false
var on_range = false
var alive = true
var gravity = 12.0

var target : Node3D

var assigned_patrol_path : Node3D

@onready var component = $component

@onready var attackRange = $attackRange
@onready var detectionRange = $detectionRange
@onready var enemyTargeter = $enemyTargeter
@onready var animationPlayer = $character1/AnimationPlayer

func _set_state(state):
	_state = state
	emit_signal("state_changed", _state)

func _ready():
	component.init(self)
	#animationPlayer.animation_finished.connect(_on_animation_player_animation_finished)
	attackRange.body_entered.connect(_on_attack_range_body_entered)
	attackRange.body_exited.connect(_on_attack_range_body_exited)
	detectionRange.body_entered.connect(_on_detection_range_body_entered)
	detectionRange.body_exited.connect(_on_detection_range_body_exited)
	health_changed.connect(_on_health_changed)
	state_changed.connect(_on_state_changed)

func _physics_process(delta):
	animationPlayer.speed_scale = speed_scale
	#if speed_scale != SPEED_SCALE:
		#await get_tree().create_timer(5.0).timeout
		#speed_scale = SPEED_SCALE
	if alive:
		move_and_slide()
		#if target != null && _state != State.FREEZE:
		
	if not is_on_floor():
		_set_state(State.FALLING)
		
	
	match _state:
		State.PATROL:
			animationPlayer.play("character_walk2")
			look_at_target()
			reevaluate(delta)
		State.IDLE:
			if alive:
				$attackRange/CollisionShape3D.disabled = false
				$detectionRange/CollisionShape3D.disabled = false
				$patrolPointDetectorRange/CollisionShape3D.disabled = false

				stop_ragdoll()
				animationPlayer.play("idle1")
				reevaluate(delta)
		State.FOLLOW:
			#move_and_slide()
			
			look_at_target()
			if target != null:
				move_to_target(1.0 * delta)
				animationPlayer.play("character_walk2")
			
		State.ATTACK:
			attacking()
		State.STUN:
			disable_hurtbox()
			push(Vector3(0,0,4.0))
			animationPlayer.play("hit")
		State.FALLING:
			velocity.y -= gravity * delta
			if is_on_floor():
				_set_state(State.IDLE)
		State.FREEZE:
			pass
			#animationPlayer.stop()
			#alive = false
			#$attackRange/CollisionShape3D.disabled = true
			#$detectionRange/CollisionShape3D.disabled = true
			#$patrolPointDetectorRange/CollisionShape3D.disabled = true

			#alerted = false
			#start_ragdoll()
			#await get_tree().create_timer(5.0).timeout
			#alive = true
			#_set_state(State.IDLE)
		State.DEAD:
			#print("dead")
			disable_hurtbox()
			dead()
			alive = false
			$CollisionShape3D.disabled = true
			$attackRange/CollisionShape3D.disabled = true
			$detectionRange/CollisionShape3D.disabled = true
			$patrolPointDetectorRange/CollisionShape3D.disabled = true


func attacking():
	animationPlayer.play("character_attack7")

func stun():
	_set_state(State.STUN)

func reevaluate(delta):
	print("aaaaaaaaaa")
	if alive:
		if on_range == true:
			_set_state(State.ATTACK)
		elif alerted == true:
			_set_state(State.FOLLOW)
		
		if alerted != true:
			get_nearest_patrol_point()
			if target != null:
				_set_state(State.PATROL)
				move_to_target(delta * 1.0)

func damage(_value,_push_direction = Vector3(0,0,10.0)):
	if health > 0:
		health -= _value
		_set_state(State.STUN)
	emit_signal("health_changed")

func start_ragdoll():
	$character1/character/Skeleton3D.physical_bones_start_simulation()

func stop_ragdoll():
	$character1/character/Skeleton3D.physical_bones_stop_simulation()

func dead():
	$hurtbox/CollisionShape3D.disabled = true
	start_ragdoll()
	#print("dead")
	#animationPlayer.play("character_knockdown")

func idle():
	_set_state(State.IDLE)

func look_at_target():
	enemyTargeter.look_at($component/navigationAgent.next_location)
	#if target != null:
		#enemyTargeter.look_at(target.global_transform.origin,Vector3.UP)
	#if enemyTargeter.is_colliding():
	rotate_y(deg_to_rad(enemyTargeter.rotation.y * 10.0))

func move_forward(speed):
	var direction = Vector3(0,0,-1)
	direction = direction.rotated(Vector3.UP,global_rotation.y)
	velocity.x = lerp(velocity.x, direction.x * SPEED, speed)
	velocity.z = lerp(velocity.z, direction.z * SPEED, speed)

func go_to_target(speed):
	look_at_target()
	move_forward(speed)

func move_to_target(_speed):
	#go_to_target(speed)
	$component/navigationAgent.set_movement_target(target.global_position)

func _on_attack_range_body_entered(body):
	if alive :
		if body.is_in_group("player"):
			on_range = true
			_set_state(State.ATTACK)
			#print("onrange :",on_range)

func _on_attack_range_body_exited(body):
	if alive :
		if body.is_in_group("player"):
			on_range = false
			#print("onrange :",on_range)

func _on_detection_range_body_entered(body):
	if alive:
		if body.is_in_group("patrol_point"):
			_set_state(State.FOLLOW)
		if body.is_in_group("player"):
			alerted = true
			target = body
			_set_state(State.FOLLOW)
			#print("alerted :", alerted)

func _on_detection_range_body_exited(body):
	if alive:
		if body.is_in_group("player"):
			alerted = false
			_set_state(State.IDLE)
			#print("alerted :",alerted)

func enable_hurtbox():
	$hurtbox.enable()

func disable_hurtbox():
	$hurtbox.disable()

func stop():
	velocity = Vector3(0,0,0)
	
func dash_forward():
	var direction = Vector3(0,0,-1.0)
	direction = direction.rotated(Vector3.UP,global_rotation.y)
	velocity.x = direction.x * 5.0
	velocity.z = direction.z * 5.0
	
func push(push_direction: Vector3):
	var direction = push_direction
	direction = direction.rotated(Vector3.UP,$enemyTargeter.global_rotation.y) 
	velocity.y = direction.y
	velocity.z = direction.z
	velocity.x = direction.x
	#move_and_slide()

func get_nearest_patrol_point():
	if !alerted :
		var parent = get_parent_node_3d()
		var children = parent.find_children("*PatrolPoint*")
		#print(children)
		for i in children:
			var temp_point
			
			if temp_point == null:
				temp_point = i
			elif position.distance_squared_to(i.position) < position.distance_squared_to(temp_point.position):
				temp_point = i
			
			target = temp_point
			
			if target != null:
				_set_state(State.FOLLOW)
			
			#print(position.distance_squared_to(i.position))

func _on_health_changed():
	if health <= 0:
		_set_state(State.DEAD)

func _on_state_changed(state):
	print(state)
