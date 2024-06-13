extends GPUParticles3D
class_name BaseParticle

var alignment 

# Called when the node enters the scene tree for the first time.
func _ready():
	finished.connect(_on_particle_finished)

func _process(delta):
	look_at(alignment)

func _on_particle_finished():
	queue_free()
