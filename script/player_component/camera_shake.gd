extends Node3D

var parent : Player

@export var camera:Camera3D
@export var noise:Noise

var max_x = 10.0
var max_y = 10.0
var max_z = 10.0
var initial_rotation : Vector3


var trauma_reduction_rate = 0
var time = 0.0
var trauma = 100.0
var noise_speed = 0.6

var rng = RandomNumberGenerator.new()

func _ready():
	initial_rotation = camera.rotation_degrees
	
func _process(delta):
	time += delta
	trauma = max(trauma - trauma_reduction_rate * delta, 0.0)
	if trauma > 0.0:
		pass
		#camera.rotation_degrees.x = initial_rotation.x + max_x * sine_wave()
		#camera.rotation_degrees.y = initial_rotation.y + max_y * get_shake_intensity() * get_noise_from_seed(rng.randi_range(0, 10))
		#camera.rotation_degrees.z = initial_rotation.z + max_z * get_shake_intensity() * get_noise_from_seed(rng.randi_range(0, 10))

func sine_wave():
	return sin(time)

func add_trauma(_amount:float):
	pass
	#reset_trauma()
	#trauma = clamp(trauma + _amount, 0.0, 5.0)

func reset_trauma():
	trauma = 0.0

func get_shake_intensity() -> float:
	return trauma * trauma
	
func get_noise_from_seed(_seed:int) -> float:
	noise.seed = _seed
	return noise.get_noise_1d(time * noise_speed)
