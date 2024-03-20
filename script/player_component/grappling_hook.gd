extends Node3D

var parent : Player

@export var raycast: RayCast3D
@onready var timer = $Timer

var is_grappling = false
var direction
var distance

func _ready():
	timer.timeout.connect(_on_timer_timeout)

func _input(event):
	if Input.is_action_just_pressed("grapple"):
		if raycast.is_colliding():
			set_grapple_point()
			is_grappling = true
			timer.start()

func _physics_process(delta):
	if is_grappling:
		parent.disable()
	else:
		parent.enable()

func set_grapple_point():
	if raycast != null:
		if raycast.is_colliding():
			var collision_point = raycast.get_collision_point()
			direction = parent.global_position.direction_to(collision_point)
			distance = parent.global_position.distance_to(collision_point)

func reset_grapple_point():
	direction = null
	distance = null

func grapple():
	parent.velocity = direction * (distance * 2.5) 
	parent.move_and_slide()

func _on_timer_timeout():
	is_grappling = false
	grapple()
	reset_grapple_point()
