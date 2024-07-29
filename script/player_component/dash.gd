extends Node3D

var parent : Player
var input_dir
var stamina_usage = 33
var is_dashing = false
@export var move_component:Node3D
@export var camera_animation_player:AnimationPlayer
@export var stamina: Node3D
@export var health: Node3D

func _ready():
	$Timer.timeout.connect(_on_timer_timeout)
	$invisibilityTimer.timeout.connect(_on_invsibility_timer_timeout)
	$SlowTimer.timeout.connect(_on_slow_timer_timeout)

# Called when the node enters the scene tree for the first time.
func _input(event):
	if stamina.stamina >= 1 && parent.is_on_floor():
		if Input.is_action_just_pressed("move_dash") && is_dashing == false:
			health.invinsibility(true)
			$invisibilityTimer.start()
			stamina.damage(stamina_usage)
			parent.disable()
			is_dashing = true
			$Timer.start()
			input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
			#if input_dir.x > 0:
				#camera_animation_player.play("dash_right")
			#elif input_dir.x < 0:
				#camera_animation_player.play("dash_left")
		if Input.is_action_just_pressed("move_dash") && move_component.is_moving == false && is_dashing == false:
			parent.disable()
			is_dashing = true
			$Timer.start()
			input_dir = Vector2(0,-1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if is_dashing == true:
		var direction = (parent.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		parent.velocity.x = direction.x * 6.4
		parent.velocity.z = direction.z * 6.4
		parent.move_and_slide()

func _on_timer_timeout():
	is_dashing = false
	$SlowTimer.start()
	parent.enable()
	var tween = get_tree().create_tween()
	tween.tween_property(parent, "velocity", Vector3.ZERO, 0.5)
	#parent.velocity = Vector3.ZERO
	parent.current_speed_modifier = parent.current_speed_modifier / 0.3
	#parent.current_speed = parent.current_speed / 0.5


func _on_invsibility_timer_timeout():
	health.invinsibility(false)

func _on_slow_timer_timeout():
	#parent.current_acceleration = parent.ACCELERATION
	parent.current_speed_modifier = parent.SPEED_MODIFIER
	pass
