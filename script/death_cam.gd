extends RigidBody3D

@onready var respawn_timer = $respawnTimer
@onready var root = get_tree().get_root().get_node("root")
# Called when the node enters the scene tree for the first time.
func _ready():
	respawn_timer.timeout.connect(_on_respawn_timer_timeout)
	respawn_timer.start()

func _on_respawn_timer_timeout():
	
	var spawn_point = root.spawn_point
	spawn_point.spawn()
