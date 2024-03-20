class_name Player
extends CharacterBody3D

const DASH_ACCELERATION = 30.0
const AIR_ACCELERATION = 0.5
const ACCELERATION = 10.0
const DEACCELERATION = 10.0

const SPEED = 4.0
const SPRINT_SPEED = 8.0
const DASH_SPEED = 14.0
const CROUCH_SPEED = 2.5
const JUMP_VELOCITY = 5.2

var current_speed = SPEED
var current_acceleration = ACCELERATION
var gravity = 12.0

var is_blocking = false
var is_crouching = false

var is_freelook = true
var is_pausing = false

@onready var head = $head
@onready var component = $component
@onready var hand = $head/hand
@onready var camera = $head/Camera3D

var mouse_movement

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	component.init(self)

func _input(event) -> void:
	if event is InputEventMouseMotion:
		if is_freelook:
			mouse_movement = event.relative
			rotation.y -= event.relative.x * 0.001
			head.rotation.x = clamp(head.rotation.x - event.relative.y * 0.001,-1.5,1.5)

func _physics_process(delta):
	move_and_slide()

func hurt(value):
	#hit_stop(0.2,0.05)
	$component/health.hurt(value)
	#$head/Camera3D/AnimationPlayer.play("hit")

func enable():
	$component/move.enable()

func disable():
	$component/move.disable()

func hit_stop(duration,timescale):
	Engine.time_scale = timescale
	await get_tree().create_timer(duration * timescale).timeout
	Engine.time_scale = 1.0
