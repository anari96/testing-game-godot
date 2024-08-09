extends Weapon

@export var animation_player : AnimationPlayer
@export var cooldown_timer : Timer
@export var attack_level_cooldown_timer : Timer
@export var hurtbox : Area3D
@onready var hand_parent = get_parent()

@export var damage = 18
@export var stamina_usage = 14

var can_use : bool = true
var attack_level = 1
var push_forward_value = 10

func _ready() -> void:
	hurtbox.monitoring = false
	equipped = false
	animation_player.play("idle")
	cooldown_timer.timeout.connect(_cooldown_timer_timeout)
	attack_level_cooldown_timer.timeout.connect(_attack_level_cooldown_timer_timeout)
	hurtbox.body_entered.connect(_on_hurtbox_body_entered)

func _physics_process(delta) -> void:
	if equipped:
		show()
	elif !equipped:
		hide()

func use1() -> void:
	if can_use == true && hand_parent.stamina.stamina >= 1:
		hand_parent.stamina.damage(stamina_usage)
		can_use = false
		
		attack()
		attack_level += 1
		attack_level_cooldown_timer.start()
		cooldown_timer.start()

func attack() -> void:
	var animation
	match attack_level:
		1:
			animation = "attack1"
		2:
			animation = "attack2"
		3:
			animation = "attack3"
		_:
			attack_level = 1
			animation = "attack1"
			
	play_animation(animation)

func play_animation(animation) -> void:
	if animation_player.is_playing() == true:
		animation_player.stop()
		animation_player.play(animation)
	else:
		animation_player.play(animation)

func use2() -> void:
	pass

func equip() -> void:
	animation_player.play("equip")
	equipped = true
	show()
	
func remove() -> void:
	equipped = false
	hide()

func _cooldown_timer_timeout():
	can_use = true

func _attack_level_cooldown_timer_timeout():
	attack_level = 1

func turn_on_area():
	hurtbox.monitoring = true
	
func turn_off_area():
	hurtbox.monitoring = false

func _on_hurtbox_body_entered(body):
	if body.get_node("Health") != null:
			body.get_node("Health").hurt(30)
