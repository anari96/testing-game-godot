extends Node3D

@onready var player = preload("res://scene/player.tscn")
@onready var root = get_tree().get_root().get_node("root")
@export var spawn_direction : float
# Called when the node enters the scene tree for the first time.
func _ready():
	spawn()

func spawn():
	root.set_spawn_point(self)
	var player_instance = player.instantiate()
	#player_instance.rotation.y = spawn_direction
	add_child(player_instance)
