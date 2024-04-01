extends Node3D

@onready var player = preload("res://scene/player.tscn")
#@onready var root = get_tree().get_root().get_node("root")
#@export var spawn_direction : float
@export var id:int = 1
# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass
	#spawn()

func _ready():
	$MeshInstance3D.hide()

func spawn():
	#SpawnManager.set_spawn_point(self)
	var player_instance = player.instantiate()
	player_instance.rotation.y = $MeshInstance3D.rotation.y
	add_child(player_instance)
