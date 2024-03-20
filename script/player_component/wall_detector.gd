extends Node3D

var parent : Player
var near_wall : bool

@onready var raycast_front = $RayCast3D
@onready var raycast_back = $RayCast3D2
@onready var raycast_right = $RayCast3D3
@onready var raycast_left = $RayCast3D4

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if raycast_front.is_colliding() || raycast_back.is_colliding() || raycast_left.is_colliding() || raycast_right.is_colliding():
		near_wall = true
	else:
		near_wall = false


	#print(near_wall)
