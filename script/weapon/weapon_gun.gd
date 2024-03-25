extends Weapon

@onready var arm_animation_player = $arm/AnimationPlayer
@onready var gun_animation_player = $gun/AnimationPlayer
@onready var light_timer = $LightTimer
@onready var bullet_marker = $BulletMarker
@onready var projectile = preload("res://scene/projectile/bullet.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	light_timer.timeout.connect(_on_light_timer_timeout)

func use1() -> void:
	$OmniLight3D.light_energy = 1.0
	light_timer.start()
	play_animation(arm_animation_player,"arm_shoot")
	play_animation(gun_animation_player,"gun_shoot")
	var projectile_instance = projectile.instantiate()
	bullet_marker.add_child(projectile_instance)
	#$OmniLight3D.light_energy = 0.0

func use2() -> void:
	play_animation(arm_animation_player,"arm_melee")
	play_animation(gun_animation_player,"gun_melee")

func use3() -> void:
	play_animation(arm_animation_player,"arm_reload")
	play_animation(gun_animation_player,"gun_reload")

func play_animation(player:AnimationPlayer,animation) -> void:
	if player.is_playing() == true:
		player.stop()
		player.play(animation)
	else:
		player.play(animation)
	

func _on_light_timer_timeout():
	$OmniLight3D.light_energy = 0.0
