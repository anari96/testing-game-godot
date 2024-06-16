extends Node

var is_loading : bool = false
var loaded_scene_name
var loaded_scene_status = 0
var progress = []
var loading_screen
var current_spawn_point_id

@onready var current_scene = get_tree().get_current_scene()
@onready var loading_scene = preload("res://scene/loading.tscn")

var scene_path = "res://scene/map/"

#func _ready():
	#print(current_scene)

func set_scene(scene_name:String,_spawn_point_id = 1) -> void:
	if !is_loading:
		current_spawn_point_id = _spawn_point_id
		var path = "res://scene/map/" + scene_name + ".tscn"
		ResourceLoader.load_threaded_request(path)
		is_loading = true
		loaded_scene_name = path
		loading_screen = loading_scene.instantiate()
		get_tree().root.add_child(loading_screen)

func _process(delta):
	if is_loading:
		loaded_scene_status = ResourceLoader.load_threaded_get_status(loaded_scene_name,progress)
		if loaded_scene_status == ResourceLoader.THREAD_LOAD_LOADED:
			var new_scene = ResourceLoader.load_threaded_get(loaded_scene_name)
			#new_scene.ready.connect(scene_initialization)
			var new_scene_change = get_tree().change_scene_to_packed(new_scene)
			await get_tree().create_timer(1.0).timeout
			if new_scene_change == 0 :
				scene_initialization()
				is_loading = false
				loading_screen.queue_free()
			
func scene_initialization():
	SpawnManager.select_spawn_point(SceneManager.current_spawn_point_id)
	print("scene_loaded")
	
func get_scene_list() -> Array:
	var dir = DirAccess.open(scene_path)
	var scenes = []
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			file_name = file_name.replace(".tscn","")
			scenes.append(file_name)
			file_name = dir.get_next()
	return scenes

func quit():
	get_tree().quit()
