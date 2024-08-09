extends Weapon

enum State {IDLE,SHOOT,RELOAD,ALT}
signal state_changed(state)

var _state = State.IDLE

@onready var animation_player = $gun/AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var light_timer = $LightTimer
@onready var bullet_marker = $BulletMarker
@onready var projectile = preload("res://scene/projectile/bullet.tscn")
@onready var audio_player = $AudioStreamPlayer3D
@onready var rate_of_fire_timer = $RateOfFireTimer
@onready var spread_reset_timer = $SpreadResetTimer
@onready var crosshair = $Crosshair
@onready var raycast : RayCast3D = get_parent().camera_raycast
@onready var spark_particle = preload("res://scene/particle/gpu_particles_3d.tscn")
@onready var smoke_particle = preload("res://scene/particle/smoke_particle.tscn")
@onready var flash_particle = preload("res://scene/particle/flash.tscn")
@onready var player = PlayerManager.current_player

var is_playing_animation = false

var can_shoot = true
var current_spread = 0
var max_spread = 0.1
var spread_multiplier = 0.1
var spread_recover_rate  = 0.4

var is_recovering_spread = false

var MAX_AMMO = 6
var ammo = MAX_AMMO

func _set_state(state):
	_state = state
	emit_signal("state_changed", _state)

# Called when the node enters the scene tree for the first time.
func _ready():
	equip()
	light_timer.timeout.connect(_on_light_timer_timeout)
	rate_of_fire_timer.timeout.connect(_on_rate_of_fire_timer_timeout)
	spread_reset_timer.timeout.connect(_on_spread_reset_timer_timeout)

func _process(delta):
	if is_recovering_spread == true:
		current_spread = current_spread - spread_recover_rate
		if current_spread <= 0.0:
			current_spread = 0.0
			is_recovering_spread = false
			crosshair.change_crosshair(current_spread)
	
func use1() -> void:
	if can_shoot:
		spawn_particle()
		shoot()

func use2() -> void:
	set_animation("gun_melee")

func use3() -> void:
	set_animation("gun_reload")

func play_animation(player:AnimationPlayer,animation) -> void:
	if player.is_playing() == true:
		player.stop()
		player.play(animation)
	else:
		player.play(animation)
		
func equip() -> void:
	set_animation("gun_equip")
	equipped = true
	show()

func remove() -> void:
	equipped = false
	hide()

func shoot():
	var smoke_particle_instance = smoke_particle.instantiate()
	var flash_particle_instance = flash_particle.instantiate()
	var pos = raycast.get_collision_point()
	var collider = raycast.get_collider()
	if collider != null:
		if collider.get_node("Health") != null:
			collider.get_node("Health").hurt(30)
			print(collider.get_node("Health"))
		if collider.get_node("Detection") != null:
			collider.get_node("Detection")._target = get_parent().get_parent().get_parent() #set player as the target
	can_shoot = false
	rate_of_fire_timer.start()
	audio_player.play()
	$OmniLight3D.light_energy = 1.0
	light_timer.start()
	#_set_state(State.SHOOT)
	set_animation("gun_shoot")
	var projectile_instance = projectile.instantiate()
	bullet_marker.look_at(pos)
	bullet_marker.add_child(projectile_instance)
	bullet_marker.add_child(smoke_particle_instance)
	bullet_marker.add_child(flash_particle_instance)
	apply_spread()
	#$OmniLight3D.light_energy = 0.0

func spawn_particle():
	var particle_instance = spark_particle.instantiate()
	var pos = raycast.get_collision_point()
	var normal = raycast.get_collision_normal()
	particle_instance.global_position = pos
	#particle_instance.rotation_degrees.y = 90
	particle_instance.rotation = (normal)
	if normal == Vector3.UP:
		particle_instance.rotation_degrees.x = -90
	elif normal == Vector3.DOWN:
		particle_instance.rotation_degrees.x = 90
	particle_instance.alignment = pos-normal
	particle_instance.emitting = true
	get_tree().root.add_child(particle_instance)

func apply_spread():
	if current_spread < max_spread:
		current_spread += spread_multiplier
	var random_spread = Vector3(randf_range(-current_spread,current_spread),randf_range(-current_spread,current_spread),0)
	raycast.rotation = random_spread
	spread_reset_timer.start()
	crosshair.change_crosshair(current_spread)

func set_animation(animation_name:String):
	animation_player.play(animation_name)
	if animation_player.is_playing():
		animation_player.stop()
		animation_player.play(animation_name)
	

func _on_light_timer_timeout():
	$OmniLight3D.light_energy = 0.0

func _on_rate_of_fire_timer_timeout():
	can_shoot = true

func _on_spread_reset_timer_timeout():
	is_recovering_spread = true
	crosshair.change_crosshair(current_spread)
	get_parent().camera_raycast.rotation = Vector3.ZERO

