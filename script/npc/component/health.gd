extends Node

@export var hitbox : Area3D

var health:int = 100

var low_health_warning = 40

func _process(delta):
	if health <= 0:
		get_parent().queue_free()

func _ready():
	hitbox.body_entered.connect(_on_hitbox_body_entered)

func _on_hitbox_body_entered(body):
	pass

func hurt(damage):
	health -= damage
	if health < low_health_warning:
		print("low_health")
		get_parent().state["low_health"] = true
