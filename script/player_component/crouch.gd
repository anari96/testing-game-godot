extends Node3D

var parent : Player

@export var animation_player : AnimationPlayer
@export var move : Node3D
var SPEED = 3.3
@onready var raycast = $RayCast3D
var is_crouching: bool = false
signal state_changed(is_crouching)

func _ready():
	state_changed.connect(_on_state_changed)

func _input(event):
	if Input.is_action_just_pressed("crouch"):
		if is_crouching && !raycast.is_colliding():
			is_crouching = false
		elif !is_crouching:
			is_crouching = true
		emit_signal("state_changed", is_crouching)

func _on_state_changed(is_crouching):
	if is_crouching:
		crouch()
	elif !is_crouching:
		uncrouch()
 
func crouch():
	animation_player.play("crouch", -1, SPEED)

func uncrouch():
	animation_player.play("crouch", -1, -SPEED,true)
