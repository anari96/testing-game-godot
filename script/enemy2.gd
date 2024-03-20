extends CharacterBody3D
#class_name Enemy

enum State {IDLE, FOLLOW, ATTACK, PATROL, STUN, STAGGER, FALL, DEAD}

var _current_state = State.IDLE

var _target:Node3D

var _health = 100

signal state_changed(_current_state)
signal health_changed(_current_health)

func _ready():
	pass

func _set_state(_state):
	_current_state = _state
	emit_signal("state_changed", _state)
	
func _physics_process(delta):
	match _current_state:
		State.IDLE:
			pass
		State.FOLLOW:
			pass
		State.ATTACK:
			pass
		State.STUN:
			pass
		State.PATROL:
			pass

func think():
	pass
	
func rotate_to_target():
	pass

func move_to_target():
	pass

func set_target(_target):
	pass

func start_ragdoll():
	pass
	
func stop_ragdoll():
	pass

func damage(_value):
	pass
