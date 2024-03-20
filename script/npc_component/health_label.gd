extends Label3D

@export var root:CharacterBody3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = str(root.health)
