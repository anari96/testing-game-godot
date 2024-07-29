extends Node3D

var parent : Player
var stamina = 100.0
var prev_stamina = 0.0
var max_stamina = 100.0
var is_regenerating = false
var is_delta_damage = false
var is_fade_out = false
@export var stamina_bar : ProgressBar
@export var delta_bar : ProgressBar
@export var timer : Timer
@export var fade_out_timer : Timer

signal stamina_full
signal stamina_changed

func _physics_process(delta):
	stamina_bar.value = stamina
	delta_bar.value = prev_stamina
	
	if is_delta_damage:
		prev_stamina -= 1.0
		if prev_stamina <= stamina:
			is_delta_damage = false
	
	if is_regenerating:
		regenerate(100.0,delta)
		if stamina >= max_stamina:
			emit_signal("stamina_full")
			is_regenerating = false

func _ready():
	$Timer.timeout.connect(_on_timer_timeout)
	timer.timeout.connect(_on_stamina_timer_timeout)
	fade_out_timer.timeout.connect(_on_fade_out_timer_timeout)
	stamina_changed.connect(_on_stamina_changed)
	stamina_full.connect(_on_stamina_full)
	
	fade_out_timer.start()

func damage(value):
	if stamina < 0:
		stamina = 0
	fade_in()
	fade_out_timer.stop()
	emit_signal("stamina_changed")
	is_delta_damage = false
	prev_stamina = stamina
	stamina -= value
	is_regenerating = false
	$Timer.start()
	timer.start()

func fade_out():
	CanvasItem.modulate = Color(1,1,1,1)

func regenerate(rate,delta):
	stamina += rate * delta
	
func _on_timer_timeout():
	is_regenerating = true

func _on_stamina_timer_timeout():
	is_delta_damage = true

func _on_stamina_changed():
	pass

func _on_stamina_full():
	prev_stamina = stamina
	fade_out_timer.start()

func fade_in():
	var tween = get_tree().create_tween()
	tween.tween_property(stamina_bar,"modulate:a", 1.0,0.1)

func _on_fade_out_timer_timeout():
	var tween = get_tree().create_tween()
	tween.tween_property(stamina_bar,"modulate:a", 1.0,0.5)
