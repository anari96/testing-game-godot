extends Node3D

@onready var start_button = $CanvasLayer/Menu/Button
@onready var quit_button = $CanvasLayer/Menu/Button2

func _ready():
	start_button.pressed.connect(_on_start_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	#print(SceneManager.get_scene_list())
	#print(get_tree().get_nodes_in_group("interface"))
	
func _on_start_button_pressed():
	SceneManager.set_scene("hotel_scene",2)

func _on_quit_button_pressed():
	SceneManager.quit()
