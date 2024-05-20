extends Node3D

@export var item_name: String
@export var can_spawn: bool = true

var progress = []
var loaded_item_status = 0
var path : String
var is_spawning : bool

func _ready():
	path = "res://scene/item/" + item_name + ".tscn"
	if can_spawn:
		spawn()

func spawn():
	ResourceLoader.load_threaded_request(path)
	is_spawning = true
	

func _process(delta):
	if is_spawning == true:
		loaded_item_status = ResourceLoader.load_threaded_get_status(path,progress)
		if loaded_item_status == ResourceLoader.THREAD_LOAD_LOADED:
			var item = ResourceLoader.load_threaded_get(path)
			var instance = item.instantiate()
			add_child(instance)
