extends Node3D

var parent : Player

var jump_count = 1
var current_jump_count = jump_count
var can_fall = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.timeout.connect(_on_timer_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	parent.velocity.y = parent.JUMP_VELOCITY * 2.0
	can_move = true
	can_fall = true
