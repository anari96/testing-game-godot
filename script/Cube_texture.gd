extends MeshInstance3D

@export var hatch1:Texture2D
@export var hatch2:Texture2D
@export var hatch3:Texture2D
@export var hatch4:Texture2D

var gradient_data := {
	0.0: hatch1,
	0.5: hatch2,
	0.75: hatch3,
	1.0: hatch4
}



# Called when the node enters the scene tree for the first time.
func _ready():
	var gradient := Gradient.new()
	gradient.offsets = gradient_data.keys()
	gradient.colors = gradient_data.values()
	
	var gradient_texture = GradientTexture1D.new()
	gradient_texture.gradient = gradient
	set_instance_shader_parameter("hatching_texture", gradient_texture)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
