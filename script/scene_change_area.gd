extends Area3D

@export var scene_name:String

func _ready():
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		SceneManager.set_scene(scene_name)
