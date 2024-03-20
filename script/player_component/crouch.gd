extends Node3D

var parent : Player

@export var animation_player : AnimationPlayer
var SPEED = 4.0
@onready var raycast = $RayCast3D
var is_crouching: bool = false

func _input(event):
	if Input.is_action_just_pressed("crouch"):
		if is_crouching && !raycast.is_colliding():
			is_crouching = false
			animation_player.play("crouch", -1, -SPEED,true)
		elif !is_crouching:
			is_crouching = true
			animation_player.play("crouch", -1, SPEED)
