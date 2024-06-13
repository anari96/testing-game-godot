extends GPUParticles3D

func _ready():
	finished.connect(_on_particle_finished)
	emitting = true

func _on_particle_finished():
	queue_free()
