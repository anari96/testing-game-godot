extends Node3D

var parent : Player
var health : int = 100
var prev_health : int = 0.0
var is_regenerating : bool = false
var is_delta_damage : bool = false
var is_fade_out : bool = false
var invincible : bool = false
@export var camera_animation_player:AnimationPlayer
@export var health_bar : ProgressBar
@export var delta_bar : ProgressBar
@export var timer : Timer
@export var fade_out_timer : Timer
@export var camera_shake_component :Node3D

signal health_full
signal health_changed

@onready var death_cam = preload("res://scene/death_cam.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.timeout.connect(_on_health_timer_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	health_bar.value = health
	delta_bar.value = prev_health
	if is_delta_damage:
		prev_health -= 1.0
		if prev_health <= health:
			is_delta_damage = false
	
	if health <= 0:
		parent.queue_free()
		var tree = get_tree().get_root()
		var death_cam_instance = death_cam.instantiate()
		death_cam_instance.global_transform = global_transform
		tree.add_child(death_cam_instance)
		Engine.time_scale = 1.0
		#await get_tree().create_timer().timeout

func invinsibility(value):
	if value == true:
		invincible = true
	elif value == false:
		invincible = false

func hurt(value):
	if invincible == false:
		emit_signal("health_changed")
		is_delta_damage = false
		prev_health = health
		timer.start()
		health -= value
		camera_animation_player.play("hurt")
		camera_shake_component.add_trauma(value)
		
		parent.hit_stop(0.2,0.05)

func fade_in():
	var tween = get_tree().create_tween()
	tween.tween_property(health_bar,"modulate:a", 1.0,0.1)

func _on_health_timer_timeout():
	is_delta_damage = true
